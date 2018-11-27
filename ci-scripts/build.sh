#!/bin/sh
set -e

scriptDir="$(dirname $(readlink -f $0))"
baseDir="${scriptDir%/ci-scripts}"
sourceDir="${baseDir}/source"
outputDir="${baseDir}/output"


# build
cd ${sourceDir}
javac -d ${outputDir} SimpleHTTPServer.java
cp -v manifest.mf ${outputDir}/

# pack
cd ${outputDir}
jar -cvf SimpleHTTPServer.jar SimpleHTTPServer*.class
jar -uvfm SimpleHTTPServer.jar manifest.mf
rm -f SimpleHTTPServer*.class manifest.mf *.tmp

