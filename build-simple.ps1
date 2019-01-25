


# SONAR BEGIN
dotnet tool install dotnet-sonarscanner  --tool-path tools
.\tools\dotnet-sonarscanner begin /k:"evilz_resharper-to-sonarqube-example" /d:sonar.organization="evilz-github" /d:sonar.host.url="https://sonarcloud.io" /d:sonar.login="e7dcfc9c655f3ac6a72907131c093140882efa96" /d:sonar.externalIssuesReportPaths="sonarqube-report.json"


# BUILD
dotnet build "./src/Demo.Web.sln"

# RESHARPER
Invoke-WebRequest -Uri "https://download.jetbrains.com/resharper/ReSharperUltimate.2018.3.1/JetBrains.ReSharper.CommandLineTools.2018.3.1.zip" -OutFile ".\tools\JetBrains.ReSharper.CommandLineTools.2018.3.1.zip"
Expand-Archive -LiteralPath .\tools\JetBrains.ReSharper.CommandLineTools.2018.3.1.zip -DestinationPath .\tools\JetBrains.ReSharper.CommandLineTools
.\tools\JetBrains.ReSharper.CommandLineTools\InspectCode.exe "./src/Demo.Web.sln" -o="resharper-report.xml" -s=INFO

# REQUBE
dotnet tool install dotnet-reqube --tool-path tools
.\tools\dotnet-reqube -i "resharper-report.xml" -o "sonarqube-report.json" -d "./src/"


#SONAR END
dotnet tool install dotnet-sonarscanner  --tool-path tools
.\tools\dotnet-sonarscanner end /d:sonar.login="e7dcfc9c655f3ac6a72907131c093140882efa96"