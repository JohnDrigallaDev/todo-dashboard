-- Im Supabase SQL Editor ausführen. RLS schützt alle Daten pro angemeldetem Nutzer.
create extension if not exists pgcrypto;
create table if not exists public.projects (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  name text not null check (char_length(trim(name)) between 1 and 100),
  color text not null default '#8b5cf6',
  created_at timestamptz not null default now()
);
create table if not exists public.tasks (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  project_id uuid references public.projects(id) on delete set null,
  title text not null check (char_length(trim(title)) between 1 and 200),
  description text not null default '',
  status text not null default 'todo' check (status in ('todo','doing','blocked','done')),
  priority text not null default 'medium' check (priority in ('urgent','high','medium','low')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create index if not exists tasks_user_status_idx on public.tasks(user_id,status);
create index if not exists projects_user_idx on public.projects(user_id);
alter table public.projects enable row level security;
alter table public.tasks enable row level security;
create policy "Own projects" on public.projects for all to authenticated using (user_id = auth.uid()) with check (user_id = auth.uid());
create policy "Own tasks" on public.tasks for all to authenticated using (user_id = auth.uid()) with check (user_id = auth.uid() and (project_id is null or exists (select 1 from public.projects p where p.id = project_id and p.user_id = auth.uid())));
-- Zusätzlicher Schutz vor Verknüpfung mit fremden Projekten bei Updates:
create or replace function public.validate_task_project() returns trigger language plpgsql set search_path = public as $$
begin
 if new.project_id is not null and not exists (select 1 from public.projects where id = new.project_id and user_id = new.user_id) then
  raise exception 'Projekt gehört nicht zum Benutzer';
 end if;
 new.updated_at = now();
 return new;
end $$;
drop trigger if exists validate_task_project_trigger on public.tasks;
create trigger validate_task_project_trigger before insert or update on public.tasks for each row execute function public.validate_task_project();
