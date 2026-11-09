# Glassboard

Privates, einseitiges Kanban-Dashboard mit Next.js, Tailwind, Framer Motion und Supabase. Dark-/Light-Mode, Projekte als Tags, Prioritäten, Drag-and-drop, Filter, Suche und Supabase-Login.

## Einrichtung (ca. 10–15 Minuten)

1. **Supabase:** Neues kostenloses Projekt unter https://supabase.com erstellen.
2. **Datenbank:** SQL Editor öffnen und den gesamten Inhalt von `supabase/schema.sql` ausführen (bei erstmaliger Einrichtung nur einmal).
3. **Benutzer:** Authentication → Users → Add user → Create new user. Deine E-Mail und ein starkes Passwort eingeben; E-Mail als bestätigt markieren. Unter Authentication → Providers → Email die öffentliche Registrierung deaktivieren ("Allow new users to sign up" aus), damit niemand neue Konten anlegen kann. Alternativ Signups in Auth-Einstellungen deaktivieren, je nach Supabase-Oberfläche.
4. **API-Zugang:** Project Settings → API Keys bzw. Connect. Project URL und den *publishable* oder älteren *anon* Key kopieren. **Niemals `service_role` oder Secret Key im Browser verwenden.**
5. **GitHub:** Entpackten Projektordner in ein neues privates GitHub-Repository hochladen.
6. **Vercel:** Add New → Project → GitHub-Repository importieren. Framework Next.js automatisch erkennen lassen. Unter Environment Variables hinzufügen:
   - `NEXT_PUBLIC_SUPABASE_URL` = deine Project URL
   - `NEXT_PUBLIC_SUPABASE_ANON_KEY` = dein Publishable/Anon Key
7. **Deploy** klicken. Anschließend deine Vercel-Adresse öffnen und mit dem in Supabase angelegten Benutzer anmelden.

### Lokal starten (optional)

Node.js 20.9+ installieren, `.env.example` als `.env.local` kopieren und Werte eintragen. Dann `npm install` und `npm run dev`.

## Sicherheit und Kosten

- Die Tabellen haben Row Level Security (RLS). Ein angemeldeter Nutzer kann nur seine eigenen Projekte/Aufgaben sehen und bearbeiten.
- Keine öffentliche Registrierung in der App. Supabase-Registrierung zusätzlich in den Projekteinstellungen deaktivieren.
- Der Publishable/Anon Key darf öffentlich sein; der Schutz kommt von RLS und Auth.
- Für persönliche, nicht-kommerzielle Nutzung sind Vercel Hobby und Supabase Free grundsätzlich geeignet, solange die jeweils geltenden Limits eingehalten werden. Gratisangebote können sich ändern; Supabase Free-Projekte können bei Inaktivität pausiert werden.
- Keine Zahlungsdaten erforderlich, sofern der Anbieter beim Einrichten des jeweiligen Free-Tarifs keine verlangt.

## Bedienung

- Neue Projekte über **Projekt hinzufügen** anlegen; Aufgaben können ihnen zugewiesen werden.
- Projekt im Filter auswählen und auf das Stiftsymbol klicken, um es zu bearbeiten/löschen.
- Karten per Drag-and-drop verschieben oder über das Status-Dropdown (auch mobil) ändern.
- Karte anklicken, um sie zu bearbeiten oder zu löschen.
- Dark/Light-Umschalter oben rechts.
