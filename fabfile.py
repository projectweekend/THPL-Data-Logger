from fabric.api import env, run, local, sudo, settings


def stop_service():
    with settings(warn_only=True):
        sudo('service thpl-data-logger stop')


def start_service():
    sudo('service thpl-data-logger start')


def docker_pull():
    run('docker pull projectweekend/thpl-data-logger')


def deploy():
    stop_service()
    docker_pull()
    start_service()
