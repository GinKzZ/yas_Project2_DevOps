# ==========================================
# GIAI ĐOẠN 1: BUILD
# ==========================================
FROM eclipse-temurin:25-jdk AS build
WORKDIR /app

# Cài đặt Maven thủ công vào trong container
RUN apt-get update && apt-get install -y maven

# Copy toàn bộ mã nguồn vào
COPY . .

# Build hệ thống
RUN mvn clean package -DskipTests

# ==========================================
# GIAI ĐOẠN 2: RUNTIME
# ==========================================
FROM eclipse-temurin:25-jre
WORKDIR /app

# Cài curl để check health-check
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Tạo kho chứa
RUN mkdir -p /app/libs

# Copy 19 file JAR
COPY --from=build /app/media/target/*.jar /app/libs/media.jar
COPY --from=build /app/search/target/*.jar /app/libs/search.jar
COPY --from=build /app/payment-paypal/target/*.jar /app/libs/payment-paypal.jar
COPY --from=build /app/backoffice-bff/target/*.jar /app/libs/backoffice-bff.jar
COPY --from=build /app/cart/target/*.jar /app/libs/cart.jar
COPY --from=build /app/webhook/target/*.jar /app/libs/webhook.jar
COPY --from=build /app/inventory/target/*.jar /app/libs/inventory.jar
COPY --from=build /app/product/target/*.jar /app/libs/product.jar
COPY --from=build /app/location/target/*.jar /app/libs/location.jar
COPY --from=build /app/order/target/*.jar /app/libs/order.jar
COPY --from=build /app/rating/target/*.jar /app/libs/rating.jar
COPY --from=build /app/delivery/target/*.jar /app/libs/delivery.jar
COPY --from=build /app/tax/target/*.jar /app/libs/tax.jar
COPY --from=build /app/customer/target/*.jar /app/libs/customer.jar
COPY --from=build /app/payment/target/*.jar /app/libs/payment.jar
COPY --from=build /app/sampledata/target/*.jar /app/libs/sampledata.jar
COPY --from=build /app/recommendation/target/*.jar /app/libs/recommendation.jar
COPY --from=build /app/storefront-bff/target/*.jar /app/libs/storefront-bff.jar
COPY --from=build /app/promotion/target/*.jar /app/libs/promotion.jar

CMD ["echo", "YAS All-in-one Backend (Java 25) is READY!"]