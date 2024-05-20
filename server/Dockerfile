FROM azul/zulu-openjdk-alpine:21

ENV TZ Asia/Seoul
ADD ./build/libs/*.jar app.jar
ENTRYPOINT ["java", "-jar", "-Dspring.profiles.active=production", "-Duser.timezone=Asia/Seoul", "/app.jar"]
