FROM openjdk:8-jdk-alpine

ENV SERVER_PORT=1991
ENV MYSQL_USER=root
ENV MYSQL_PASS=surveyking
ENV DB_URL=jdbc:mysql://localhost:3306/surveyking

WORKDIR /app

COPY ./surveyking-v1.6.0.jar /app/surveyking.jar

CMD /usr/bin/java -jar -Xms256M /app/surveyking.jar \
    --server.port=${SERVER_PORT} \
      --spring.datasource.url=${DB_URL} \
      --spring.datasource.username=${MYSQL_USER} \
      --spring.datasource.password=${MYSQL_PASS}