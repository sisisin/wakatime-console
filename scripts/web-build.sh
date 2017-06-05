#!/bin/bash

cd web
dotnet restore
dotnet publish -c Release -o build
cd ..
docker-compose build
