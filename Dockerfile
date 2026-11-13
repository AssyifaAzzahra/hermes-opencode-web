# syntax=docker/dockerfile:1
# Serve the hermes-opencode-web login page with nginx.

FROM nginx:1.27-alpine

# Build-time flags (exposed to the image build).
ARG BUILD_ENV=production
ENV NODE_ENV=${BUILD_ENV}

# Serve static files from the nginx document root.
WORKDIR /usr/share/nginx/html

# Copy project web files (login page + docs).
COPY login.html README.md ./

# Make login.html the main entry point (visit "/" will load it).
RUN printf '<!DOCTYPE html>\n<html lang="id">\n<head>\n  <meta charset="utf-8">\n  <meta http-equiv="refresh" content="0; url=/login.html">\n  <title>Redirecting</title>\n</head>\n<body>\n  <p>Loading login page &hellip;</p>\n  <script>location.replace("/login.html");</script>\n</body>\n</html>\n' > index.html \
    && chown -R nginx:nginx /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
