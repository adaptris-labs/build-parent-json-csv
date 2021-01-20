FROM adaptris/interlok-base:latest-zulu

ARG java_tool_opts
ENV JAVA_TOOL_OPTIONS=$java_tool_opts

WORKDIR /opt/interlok
COPY . /root/builder

RUN cd /root/builder && \
    chmod +x /root/builder/gradlew && \
    ./gradlew --no-daemon -PinterlokDistDirectory=/opt/interlok -PbuildEnv=dev build && \
    rm -rf /root/.gradle && \
    rm -rf /root/builder

ENV JAVA_TOOL_OPTIONS=""
ENV JAVA_OPTS="-Dsun.net.inetaddr.ttl=30"
ENV INTERLOK_BASE="/opt/interlok"
ENV JVM_ARGS="-XX:MaxRAMPercentage=75.0"

EXPOSE 5555 8080

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD [ "bootstrap.properties" ]
