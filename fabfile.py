import os
from fabric.api import env, run, local, sudo, settings


FLYWAY_DB_URL = os.getenv('FLYWAY_DB_URL')
assert FLYWAY_DB_URL

FLYWAY_DB_USER = os.getenv('FLYWAY_DB_USER')
assert FLYWAY_DB_USER

FLYWAY_DB_PASSWORD = os.getenv('FLYWAY_DB_PASSWORD')
assert FLYWAY_DB_PASSWORD

FLYWAY_MIGRATE = "flyway -url=jdbc:{0} -user={1} -password={2} migrate".format(
    FLYWAY_DB_URL,
    FLYWAY_DB_USER,
    FLYWAY_DB_PASSWORD)


def stop_service():
    with settings(warn_only=True):
        sudo('service thpl-data-logger stop')


def start_service():
    sudo('service thpl-data-logger start')


def docker_pull():
    run('docker pull projectweekend/thpl-data-logger')


def migrate_db():
    run("docker run projectweekend/thpl-data-logger {0}".format(FLYWAY_MIGRATE))


def deploy():
    stop_service()
    docker_pull()
    migrate_db()
    start_service()
