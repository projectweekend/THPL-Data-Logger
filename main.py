from picloud_client import SubClient
from app.config import PICLOUD_SUB_URL, PICLOUD_API_KEY
from app.utils.database import database_connection


def main():
    db = database_connection()
    picloud = SubClient(
        url=PICLOUD_SUB_URL,
        api_key=PICLOUD_API_KEY,
        client_name='THPL-Data-Logger')

    def on_thpl_data(data):
        cursor = db.cursor()
        cursor.callproc('thpl_data_insert', ['home', data])
        cursor.close()

    picloud.subscribe(event='home:thpl', callback=on_thpl_data)

    while True:
        picloud.process_subscriptions()


if __name__ == "__main__":
    main()
