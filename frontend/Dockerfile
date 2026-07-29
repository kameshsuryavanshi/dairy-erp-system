FROM ghcr.io/cirruslabs/flutter:3.24.5 AS build
WORKDIR /app
COPY pubspec.yaml ./
RUN flutter pub get
COPY . .
RUN flutter build web --release --dart-define=API_BASE_URL=/api/v1
FROM nginx:alpine
COPY --from=build /app/build/web /usr/share/nginx/html
EXPOSE 80
