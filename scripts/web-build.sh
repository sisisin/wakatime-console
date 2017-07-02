#!/bin/bash

cd web-front
npm i
npm run build-prod
cd ../web
dotnet restore
dotnet publish -c Release -o build
cd ..
docker-compose build
