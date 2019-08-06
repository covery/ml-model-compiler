@echo off
rem  Configuration
set H2O_VERSION=3.20.0.5
set JAR="h2o-genmodel-%H2O_VERSION%.jar"
set MODEL=%1

set MODEL_FOLDER=.
set NAME=%MODEL%
set PREFIX=%~n1
set TMP_FOLDER=tmp
mkdir %TMP_FOLDER%

echo "Building model: %MODEL%"
echo "   H2O library: %JAR%"
echo "  Model folder: %MODEL_FOLDER%"
echo "  Build folder: %TMP_FOLDER%"

rem Copying java file to folder
copy %MODEL% %TMP_FOLDER%

rem Compiling
echo "Compiling, this make take a while"
javac -encoding utf8 -J-Xmx4096m -cp %JAR% %TMP_FOLDER%/%NAME%
del %TMP_FOLDER%\%NAME%

rem Building JAR
echo "Assembling JAR file"
jar -cf %MODEL_FOLDER%/%PREFIX%.jar -C %TMP_FOLDER% .

rem Cleanup
rd /q /s %TMP_FOLDER% 2>nul
echo "Done"