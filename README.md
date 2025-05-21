# Netbox

Docker compose for running Netbox locally, connecting to SaaS PostgreSQL and Valkey instances

## Usage

- Start: `docker compose up -d`
- Stop: `docker compose down -v`

## .env file

```
CORS_ORIGIN_ALLOW_ALL=True
DB_HOST=***
DB_NAME=netbox
DB_PASSWORD=***
DB_USER=***
EMAIL_FROM=netbox@bar.com
EMAIL_PASSWORD=
EMAIL_PORT=25
EMAIL_SERVER=localhost
EMAIL_SSL_CERTFILE=
EMAIL_SSL_KEYFILE=
EMAIL_TIMEOUT=5
EMAIL_USERNAME=netbox
# EMAIL_USE_SSL and EMAIL_USE_TLS are mutually exclusive, i.e. they can't both be `true`!
EMAIL_USE_SSL=false
EMAIL_USE_TLS=false
GRAPHQL_ENABLED=true
HOUSEKEEPING_INTERVAL=86400
MEDIA_ROOT=/opt/netbox/netbox/media
METRICS_ENABLED=false
REDIS_CACHE_DATABASE=1
REDIS_CACHE_HOST=***
REDIS_CACHE_INSECURE_SKIP_TLS_VERIFY=false
REDIS_CACHE_PASSWORD=***
REDIS_CACHE_PORT=***
REDIS_CACHE_SSL=true
REDIS_DATABASE=0
REDIS_HOST=***
REDIS_INSECURE_SKIP_TLS_VERIFY=false
REDIS_PASSWORD=***
REDIS_PORT=***
REDIS_SSL=true
RELEASE_CHECK_URL=https://api.github.com/repos/netbox-community/netbox/releases
SECRET_KEY='r(m)9nLGnz$(_q3N4z1k(EFsMCjjjzx08x9VhNVcfd%6RF#r!6DE@+V5Zk2X'
SUPERUSER_EMAIL=***
SUPERUSER_NAME=***
SUPERUSER_PASSWORD=***
WEBHOOKS_ENABLED=true
```