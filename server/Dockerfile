FROM azul/zulu-openjdk-alpine:17

CMD "chmod +x ./gradlew"
CMD "./gradlew clean bootJar"

ADD ./build/libs/*.jar app.jar

ENTRYPOINT ["java", "-jar", "-Dspring.profiles.active=production", "-Duser.timezone=Asia/Seoul", "/app.jar"]
