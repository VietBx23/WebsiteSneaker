# Sử dụng Maven làm hình ảnh cơ sở
FROM maven:3.8.4-openjdk-17 AS build

# Đặt thư mục làm việc
WORKDIR /app

# Sao chép file pom.xml và mã nguồn vào container
COPY pom.xml .
COPY src ./src

# Đóng gói ứng dụng Spring Boot thành file JAR
RUN mvn package -DskipTests

# Tạo hình ảnh runtime
FROM openjdk:17-jdk-slim
WORKDIR /app

# Sao chép file JAR từ hình ảnh build vào hình ảnh runtime
COPY --from=build /app/target/websiteSneaker-0.0.1-SNAPSHOT.jar .

# Chạy ứng dụng khi container khởi động
CMD ["java", "-jar", "websiteSneaker-0.0.1-SNAPSHOT.jar"]
