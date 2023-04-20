FROM node:16 as storybook-6-build
RUN apt-get update && apt-get install -y -yq gconf-service libasound2 libatk1.0-0 libc6 libcairo2 \
    libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 \
    libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 \
    libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 \
    libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 \
    libxss1 libxtst6 ca-certificates fonts-liberation libnss3 lsb-release \
    xdg-utils wget
    
COPY storybook-6 /app

WORKDIR /app

RUN npm install

RUN npm run build-storybook

RUN npx sb extract


FROM node:16 as storybook-7-build

COPY storybook-7/ /app

RUN apt-get update && apt-get install -y -yq gconf-service libasound2 libatk1.0-0 libc6 libcairo2 \
    libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 \
    libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 \
    libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 \
    libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 \
    libxss1 libxtst6 ca-certificates fonts-liberation libnss3 lsb-release \
    xdg-utils wget

WORKDIR /app

RUN npm install

RUN npm run build-storybook

RUN npx sb extract

FROM caddy:latest

COPY --from=storybook-6-build /app/storybook-static /app/storybook-6/
COPY --from=storybook-7-build /app/storybook-static /app/storybook-7/
COPY Caddyfile /app
WORKDIR /app
EXPOSE 3003

ENTRYPOINT [ "caddy", "run"]
