import os


DATABASE_URL = os.getenv('THPL_DATABASE_URL', None)
DB_PORT_5432_TCP_ADDR = os.getenv('DB_PORT_5432_TCP_ADDR', None)

if DATABASE_URL is None:
    assert DB_PORT_5432_TCP_ADDR
    DATABASE_URL = 'postgres://postgres@{0}:5432/postgres'.format(DB_PORT_5432_TCP_ADDR)

PICLOUD_SUB_URL = os.getenv('PICLOUD_SUB_URL')
assert PICLOUD_SUB_URL

PICLOUD_API_KEY = os.getenv('PICLOUD_API_KEY')
assert PICLOUD_API_KEY
