# Pixel & Wood IDE — Test Project

This is a small proof-of-concept for a future Pixel & Wood browser-based coding environment.

## What this version does

It creates ONE test coding environment containing:

- code-server (VS Code in a browser)
- Python 3
- SQLite
- automatic file saving
- a persistent workspace
- basic Docker resource/security restrictions

It does NOT yet contain:

- pupil accounts
- live collaboration
- Pixel & Wood website integration
- automatic pupil containers
- a public domain/HTTPS setup

Those come later, only after this simple version has been tested.

## Important safety point

The IDE port is bound to `127.0.0.1` only.

That means this first version is NOT deliberately exposed directly to the public internet. We can decide how to provide secure HTTPS access after checking the VPS.

## Files

- `Dockerfile` — builds the Pixel & Wood IDE image.
- `docker-compose.yml` — starts the test IDE.
- `.env.example` — shows where the IDE password goes.
- `config/settings.json` — simple VS Code settings including auto-save.
- `workspace-template/` — sample Python and SQL work.
- `workspace/` — created for live work and deliberately ignored by Git.
- `README.md` — this guide.

## Before running this on the VPS

Do not run anything until we have checked:

1. Docker is installed.
2. Port 8088 is not already being used.
3. The VPS has enough RAM/disk space.
4. The existing Pixel & Wood website/services will not be affected.

## First setup

Once the VPS has been checked:

```bash
cp .env.example .env
```

Edit `.env` and replace the example password with a strong password.

Create the live workspace:

```bash
mkdir -p workspace
cp -R workspace-template/. workspace/
```

Then build/start the test:

```bash
docker compose up -d --build
```

Check it:

```bash
docker compose ps
```

View logs:

```bash
docker compose logs -f ide
```

Stop it:

```bash
docker compose down
```

Stopping/removing the container does not delete `./workspace`, because the pupil work is stored outside the container.

## Persistence test

1. Start the IDE.
2. Create `/workspace/Python/my-test.py`.
3. Save it.
4. Run `docker compose down`.
5. Run `docker compose up -d`.
6. Confirm `my-test.py` is still present.

## SQLite test

A sample database is included at:

`SQL/school.db`

Open a terminal in the IDE and run:

```bash
sqlite3 SQL/school.db
```

Then:

```sql
SELECT * FROM pupil;
```

Type `.quit` to leave SQLite.

## Next stage

Only after this works should we add:

1. secure HTTPS access
2. easier SQL tooling
3. collaboration
4. separate pupil containers
5. backups
6. Pixel & Wood login integration
