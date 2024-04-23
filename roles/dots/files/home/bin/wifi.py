#!/bin/python3
import subprocess
import sqlite3


def initialize_database():
    connection = sqlite3.connect('wifi_passwords.db')
    cursor = connection.cursor()
    cursor.execute('''CREATE TABLE IF NOT EXISTS wifi_passwords
                      (wifi_name TEXT PRIMARY KEY, password TEXT)''')
    connection.commit()
    connection.close()


def save_password(wifi_name, password):
    connection = sqlite3.connect('wifi_passwords.db')
    cursor = connection.cursor()
    cursor.execute("INSERT OR REPLACE INTO wifi_passwords (wifi_name, password) VALUES (?, ?)", (wifi_name, password))
    connection.commit()
    connection.close()


def get_password(wifi_name):
    connection = sqlite3.connect('wifi_passwords.db')
    cursor = connection.cursor()
    cursor.execute("SELECT password FROM wifi_passwords WHERE wifi_name=?", (wifi_name,))
    result = cursor.fetchone()
    connection.close()
    if result:
        return result[0]
    return None


def get_available_wifi_list():
    result = subprocess.run("nmcli device wifi list", shell=True, capture_output=True, text=True)
    wifi_list = result.stdout.strip().split('\n')[1:]
    for i, wifi in enumerate(wifi_list, start=1):
        print(f"{i}. {wifi}")
    return wifi_list


def connect_to_wifi_by_number(wifi_list, wifi_number, password):
    command = f"nmcli device wifi connect '{selected_wifi}' password '{password}'"
    subprocess.run(command, shell=True, check=True)
    print(f"Successfully connected to WiFi: {selected_wifi}")


# Initialize the database
initialize_database()

wifi_list = get_available_wifi_list()

if wifi_list:
    try:
        wifi_number = int(input("wifi number:"))
        selected_wifi = wifi_list[wifi_number - 1].strip().split()[1]
        saved_password = get_password(selected_wifi)

        if not saved_password:
            password = input("password:")
        else:
            password = saved_password

        connect_to_wifi_by_number(wifi_list, wifi_number, password)
        # Save the password if the connection is successful
        selected_wifi = wifi_list[wifi_number - 1].strip().split()[1]
        save_password(selected_wifi, password)
    except ValueError:
        print("invalid WiFi number")
