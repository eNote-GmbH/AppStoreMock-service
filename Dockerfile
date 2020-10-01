FROM adoptopenjdk/openjdk13:debianslim-jre

# hadolint ignore=DL3008
RUN apt-get update \
    && rm -rf /var/lib/apt/lists/* \
    && addgroup -gid 1000 spring \
    && useradd -g spring --shell /usr/sbin/nologin --uid 1000 -m spring \
    && mkdir /home/spring/archives \
    && chown spring:spring /home/spring/archives \
    && chmod 750 /home/spring/archives

USER spring:spring

ARG ARTIFACT_NAME=target/appStoreMock.jar
COPY /iap-service/target/scala-2.11/$ARTIFACT_NAME /app/service.jar

CMD ["java", "-XX:MaxRAMPercentage=75", "-jar", "/app/service.jar"]
