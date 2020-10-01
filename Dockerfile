FROM adoptopenjdk/openjdk13:debianslim-jre

ARG ARTIFACT_NAME=appStoreMock.jar

# hadolint ignore=DL3008
RUN apt-get update \
    && rm -rf /var/lib/apt/lists/* \
    && addgroup -gid 1000 spring \
    && useradd -g spring --shell /usr/sbin/nologin --uid 1000 -m spring

COPY ./iap-service/target/scala-2.11/$ARTIFACT_NAME /app/service.jar
COPY ./test/plans.json /tmp

USER spring:spring


CMD ["java", "-XX:MaxRAMPercentage=75", "-jar", "/app/service.jar"]
