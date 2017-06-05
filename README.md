# setup

- install dotnet
- install docker

# dev

```
docker-compose -f docker-compose.dev.yml up
cd web
dotnet run
```

# build & run

## batch

```sh
cd batch
dotnet restore
dotnet publish -c Release -o build
```

## web

```sh
bash ./scripts/web-build.sh
docker-compose up
```
