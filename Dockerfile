# STAGE 1: Build JARs
FROM eclipse-temurin:25-jdk AS build
WORKDIR /app
RUN apt-get update && apt-get install -y maven
COPY . .
RUN mvn clean package -DskipTests

# STAGE 2: Runtime
FROM eclipse-temurin:25-jre
WORKDIR /app
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*
RUN mkdir -p /app/libs

COPY --from=build /app/product/target/*.jar /app/libs/product.jar
COPY --from=build /app/cart/target/*.jar /app/libs/cart.jar
COPY --from=build /app/order/target/*.jar /app/libs/order.jar
COPY --from=build /app/customer/target/*.jar /app/libs/customer.jar
COPY --from=build /app/inventory/target/*.jar /app/libs/inventory.jar
COPY --from=build /app/tax/target/*.jar /app/libs/tax.jar
COPY --from=build /app/media/target/*.jar /app/libs/media.jar
COPY --from=build /app/search/target/*.jar /app/libs/search.jar
COPY --from=build /app/location/target/*.jar /app/libs/location.jar
COPY --from=build /app/storefront-bff/target/*.jar /app/libs/storefront-bff.jar
COPY --from=build /app/backoffice-bff/target/*.jar /app/libs/backoffice-bff.jar

CMD ["echo", "Backend Image is READY"]