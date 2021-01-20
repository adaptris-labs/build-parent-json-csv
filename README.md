# build-parent-json-csv

[![Actions Status](https://github.com/adaptris-labs/build-parent-json-csv/workflows/assemble/badge.svg)](https://github.com/adaptris-labs/build-parent-json-csv/actions)

The suggested name was supreme-giggle

This showcases using [interlok-build-parent](https://github.com/adaptris-labs/interlok-build-parent); with an actual real world deploy-able example for you.

# What it does

* jetty workflow that accepts a JSON Array, and returns you back CSV
  - If the channel is started then `curl -si -XPOST -d'[{"column1": "line1"}, {"column1": "line2"}]' http://localhost:8080/api/csv` will give you some data

* there is a service-test.xml which tests the json-array-csv service
* there is limited error handling such that if you give it a non-json-array; it gives you a json stacktrace.

## Getting started

* `./gradlew clean build`
* `(cd ./build/distribution && java -jar lib/interlok-boot.jar)`
* Login to the UI as usual via (http://localhost:8080/interlok); note that the adapter is _started_ but the channel is _stopped_
* Kill everything

* `./gradlew -PbuildEnv=dev clean build`
* `(cd ./build/distribution && java -jar lib/interlok-boot.jar)`
* Login to the UI as usual; the adapter is _started_ and channel is now _started_
* You can now also use the service-tester page.

By specifying a build environment, you are effectively copying `variables-local-dev.properties` to `variables-local.properties` in your output directory; this means that the channel is now marked as `autostart=true`; Also, with the buildEnvironment set to be _dev_, you can use the service tester page in the UI, since the service tester jar files are now included as part of the distribution.

## Docker

You can of course choose your own tag name.

```
docker build --tag "zzlc/json-csv" .
docker run -it --rm -p8080:8080 zzlc/json-csv
```

or...

```
./gradlew -PbuildEnv=dev build
docker build -f Dockerfile.alt --tag "zzlc/json-csv" .
docker run -it --rm -p8080:8080 zzlc/json-csv
```

The first way makes docker run everything; the second way just copies things into the right place.

Then in a separate window you can do
```
$ curl -si -XPOST -d'[{"column1": "line1"}, {"column1": "line2"}]' http://localhost:8080/api/csv
HTTP/1.1 200 OK
X-Interlok-Build:
X-Interlok-Release: 3.11.1-RELEASE
Content-Type: text/plain
Transfer-Encoding: chunked
Server: Jetty(9.4.34.v20201102)

column1
line1
line2
```

Note that the `X-Interlok-Build` header is blank probably because there is no git information so the versioning is blank. This will largely depend on how you're building the docker image.
