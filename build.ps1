# TechSign Build Script for PowerShell
Write-Host "Building TechSign project..." -ForegroundColor Green

# Clean build directory
if (Test-Path "build") {
    Remove-Item "build" -Recurse -Force
    Write-Host "Cleaned build directory" -ForegroundColor Yellow
}

# Create build directories
New-Item -ItemType Directory -Path "build\web\WEB-INF\classes" -Force | Out-Null
New-Item -ItemType Directory -Path "build\web\META-INF" -Force | Out-Null
Write-Host "Created build directories" -ForegroundColor Yellow

# Copy META-INF files
Copy-Item "web\META-INF\*" "build\web\META-INF\" -Recurse -Force
Write-Host "Copied META-INF files" -ForegroundColor Yellow

# Copy web files
Copy-Item "web\*" "build\web\" -Recurse -Force -Exclude "WEB-INF"
Write-Host "Copied web files" -ForegroundColor Yellow

# Copy WEB-INF files (except classes and lib)
Copy-Item "web\WEB-INF\*" "build\web\WEB-INF\" -Recurse -Force -Exclude "classes", "lib"
Write-Host "Copied WEB-INF files" -ForegroundColor Yellow

# Compile Java files
Write-Host "Compiling Java files..." -ForegroundColor Yellow
$compileResult = javac -cp "web/lib/*;src/java" -d build/web/WEB-INF/classes src/java/controller/*.java src/java/dao/*.java src/java/model/*.java src/java/util/*.java 2>&1

if ($LASTEXITCODE -eq 0) {
    Write-Host "Java compilation successful!" -ForegroundColor Green
} else {
    Write-Host "Java compilation failed!" -ForegroundColor Red
    Write-Host $compileResult
    exit 1
}

# Copy JAR files
Write-Host "Copying JAR files..." -ForegroundColor Yellow
Copy-Item "web\lib\*.jar" "build\web\WEB-INF\lib\" -Force
Write-Host "Copied JAR files" -ForegroundColor Yellow

# Create WAR file
Write-Host "Creating WAR file..." -ForegroundColor Yellow
if (Test-Path "dist") {
    Remove-Item "dist" -Recurse -Force
}
New-Item -ItemType Directory -Path "dist" -Force | Out-Null

# Use PowerShell to create WAR file
$warFile = "dist\TechSign.war"
$buildDir = "build\web"

# Create a temporary directory for WAR contents
$tempDir = "temp_war"
if (Test-Path $tempDir) {
    Remove-Item $tempDir -Recurse -Force
}
Copy-Item $buildDir $tempDir -Recurse -Force

# Create WAR file using .NET compression
Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::CreateFromDirectory($tempDir, $warFile)

# Clean up
Remove-Item $tempDir -Recurse -Force

Write-Host "Build completed successfully!" -ForegroundColor Green
Write-Host "WAR file created: $warFile" -ForegroundColor Green
Write-Host "Built application is in: build\web" -ForegroundColor Green 