# build-parent-json-csv

The suggested name was supreme-giggle

This showcases using [interlok-build-parent](https://github.com/adaptris-labs/interlok-build-parent); with an actual real world deploy-able example for you.

# What it does

* jetty workflow that accepts a JSON Array, and returns you back CSV

There's no error handling, but it introduces a number of optional components to be included as dependencies.

Sadly there are no tests; that's left as an exercise for you.

## Getting started

* `./gradlew clean build`
* `(cd ./build/distribution && java -jar lib/interlok-boot.jar)`
* Login to the UI as usual; note that the adapter is _started_ but the channel is _stopped_
* Kill everything

* `./gradlew -PbuildEnv=dev clean build`
* `(cd ./build/distribution && java -jar lib/interlok-boot.jar)`
* Login to the UI as usual; the adapter is _started_ and channel is now _started_

By specifying a build environment, you are effectively copying `variables-local-dev.properties` to `variables-local.properties` in your output directory; this means that the channel is now marked as `autostart=true`; Also, with the buildEnvironment set to be _dev_, you can use the service tester page in the UI, since the service tester jar files are now included as part of the distribution.

