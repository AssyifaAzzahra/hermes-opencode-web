# hermes-opencode-web

Web assets for the Hermes–OpenCode bridge.

## Files

- `login.html` — auth/login page (full page login form)
- `Dockerfile` — nginx static server image
- `docker-compose.yml` — local/prod compose
- `.dockerignore` — build context exclusions

> Docker + Docker Compose are required. See the [Docker](#docker) section for details.

## Start with Docker

```bash
docker compose build
docker compose up
```

Then open http://localhost:8080 (auto-redirects to `login.html`).

Manually:

```bash
docker build -t hermes-opencode-web .
docker run -d -p 8080:80 --name hermes-opencode-web hermes-opencode-web
```

## GitHub deployment

Push code:

```bash
git push origin main
```

Push image to GitHub Container Registry:

```bash
export GITHUB_TOKEN=<PAT with `packages:write` scope>
echo "$GITHUB_TOKEN" | docker login ghcr.io -u AssyifaAzzahra --password-stdin
docker tag hermes-opencode-web ghcr.io/AssyifaAzzahra/hermes-opencode-web:latest
docker push ghcr.io/AssyifaAzzahra/hermes-opencode-web:latest
```

> Token: a `github_pat_` token may be expired or invalid. If you get
> `401 Bad credentials`, regenerate the token at
> https://github.com/settings/tokens or switch to SSH (Settings -> SSH keys).
