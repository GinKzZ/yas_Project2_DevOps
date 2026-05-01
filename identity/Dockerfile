# Sử dụng bản Keycloak ổn định
FROM quay.io/keycloak/keycloak:24.0.0

# 1. Copy giao diện tùy chỉnh của YAS vào đúng thư mục của Keycloak
COPY themes /opt/keycloak/themes/

# 2. Copy file cấu hình định danh vào thư mục import
COPY realm-export.json /opt/keycloak/data/import/

# 3. Cấu hình để Keycloak tự động nhận diện và import dữ liệu khi khởi động
ENV KEYCLOAK_IMPORT=/opt/keycloak/data/import/realm-export.json
ENV KC_FEATURES=token-exchange

# Chạy ở chế độ Development để bỏ qua HTTPS
ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start-dev", "--import-realm"]
