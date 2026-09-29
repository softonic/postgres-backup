# postgres-backup

Dumps a PostgreSQL database and uploads it, gzipped, to an AWS S3 bucket.

Postgres twin of [softonic/mysql-backup](https://github.com/softonic/mysql-backup). Used by the
[postgres-backup Helm chart](https://github.com/softonic/postgres-backup-chart) to back up Cloud SQL
PostgreSQL instances outside of Google, so backups do not depend solely on GCP.

## Environment variables

| Variable | Required | Default | Description |
|---|---|---|---|
| `POSTGRES_HOST` | yes | — | Database host |
| `POSTGRES_PORT` | no | `5432` | Database port |
| `POSTGRES_DATABASE` | yes | — | Database to dump |
| `POSTGRES_USER` | yes | — | Database user |
| `POSTGRES_PASSWORD` | yes | — | Database password |
| `AWS_ACCESS_KEY_ID` | yes | — | AWS credentials |
| `AWS_SECRET_ACCESS_KEY` | yes | — | AWS credentials |
| `AWS_S3_BUCKET` | yes | — | Destination bucket |
| `AWS_S3_FILE_PREFIX` | yes | — | Object key prefix; uploads `<prefix>-<epoch>.sql.gz` |
| `AWS_ENDPOINT_URL` | no | — | Override the S3 endpoint (MinIO and friends) |

## Usage

```bash
docker run --rm \
    -e POSTGRES_HOST=10.221.112.134 \
    -e POSTGRES_DATABASE=sonarDB \
    -e POSTGRES_USER=backup \
    -e POSTGRES_PASSWORD=... \
    -e AWS_ACCESS_KEY_ID=... \
    -e AWS_SECRET_ACCESS_KEY=... \
    -e AWS_S3_BUCKET=pgdump-softonic-infrastructure \
    -e AWS_S3_FILE_PREFIX=sonarqube/sonarqube \
    softonic/postgres-backup:0.2.0
```

The bundled `pg_dump` is version 17. It refuses to dump a newer server, but dumps any older one, so it covers the PostgreSQL 14, 15 and 17 instances alike.
