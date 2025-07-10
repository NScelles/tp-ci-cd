# Etape 1 : build avec maven
FROM maven AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Etape 2 : image d'execution
FROM eclipse-temurin
WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT [ "java","-jar","app.jar" ]

# docker build -t exercise_spring .
# docker run -d -p 7777:8080 exercise_spring