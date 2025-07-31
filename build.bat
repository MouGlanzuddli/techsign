@echo off
echo Building TechSign project...

REM Clean build directory
if exist build rmdir /s /q build
mkdir build\web\WEB-INF\classes

REM Compile Java files
echo Compiling Java files...
javac -cp "web/lib/*;src/java" -d build/web/WEB-INF/classes src/java/controller/*.java src/java/dao/*.java src/java/model/*.java src/java/util/*.java

REM Copy web files
echo Copying web files...
xcopy web\* build\web\ /E /I /Y

REM Copy JAR files
echo Copying JAR files...
xcopy web\lib\*.jar build\web\WEB-INF\lib\ /Y

echo Build completed successfully!
echo The built application is in the build/web directory.
pause 