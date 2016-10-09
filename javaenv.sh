#!/bin/sh

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar

export PATH=$JAVA_HOME/bin:$PATH
