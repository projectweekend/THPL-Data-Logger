from picloud_client import PiCloud
from app.utils.database import database_connection


def main():
    db = database_connection()
    picloud = PiCloud()

    def on_thpl_data(data):
        print(data)
        cursor = db.cursor()
        cursor.callproc('thpl_data_insert', ['home', data])
        cursor.close()

    picloud.subscribe(event='home:thpl', callback=on_thpl_data)

    while True:
        picloud.process_subscriptions()


if __name__ == "__main__":
    main()
