FROM mcr.microsoft.com/dotnet/sdk:6.0 AS dotnet6

WORKDIR /app

COPY ./HelloWorld.csproj /app/
COPY ./Program.cs /app/

# Restore as distinct layers
RUN dotnet restore
# Build and publish a release
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=dotnet6 /app/out .
ENTRYPOINT ["dotnet", "HelloWorld.dll"]
