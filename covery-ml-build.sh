#!/usr/bin/env bash

# Configuration
H2O_VERSION="3.20.0.5"
JAR="h2o-genmodel-${H2O_VERSION}.jar"
MODEL="$1"

MODEL_FOLDER=.
NAME=${MODEL}
PREFIX="${NAME%.*}"
TMP_FOLDER=./tmp
mkdir ${TMP_FOLDER}

echo "Building model: $MODEL"
echo "   H2O library: $JAR"
echo "  Model folder: $MODEL_FOLDER"
echo "  Build folder: $TMP_FOLDER"

# Copying java file to folder
cp ${MODEL} ${TMP_FOLDER}/${NAME}

# Compiling
echo "Compiling, this make take a while"
javac -cp ${JAR} ${TMP_FOLDER}/${NAME}
rm ${TMP_FOLDER}/${NAME}

# Building JAR
echo "Assembling JAR file"
jar -cf ${MODEL_FOLDER}/${PREFIX}.jar -C ${TMP_FOLDER} .

# Cleanup
rm -rf ${TMP_FOLDER}
echo "Done"