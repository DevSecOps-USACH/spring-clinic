FROM openjdk:8-jre

EXPOSE 8090

ADD gradle/wrapper/gradle-wrapper.jar /app/app.jar

WORKDIR /app

CMD java -jar app.jar

