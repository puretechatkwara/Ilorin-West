FROM mcr.microsoft.com/dotnet/core/aspnet:2.2-stretch-slim AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/core/sdk:2.2-stretch AS build
WORKDIR /src
COPY ["Ilorin-West.csproj", ""]
RUN dotnet restore "./Ilorin-West.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "Ilorin-West.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Ilorin-West.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Ilorin-West.dll"]