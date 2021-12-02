import requests
import mysql.connector
import datetime
from apscheduler.schedulers.background import BackgroundScheduler

def toDatabase(weather_info):
    name = weather_info['name']
    country = weather_info['sys']['country']
    desc = weather_info['weather'][0]['description']
    temp = weather_info['main']['temp']
    temp_min = weather_info['main']['temp_min']
    temp_max = weather_info['main']['temp_max']
    humidity = weather_info['main']['humidity']
    sunset = datetime.datetime.fromtimestamp(weather_info['sys']['sunset'])
    sunset_str = str(sunset.hour) + ':' + str(sunset.minute)
    balloon = (name, country, desc, temp, temp_min, temp_max, humidity, sunset, sunset_str)
    return balloon

def main():
    response = requests.get("https://api.openweathermap.org/data/2.5/weather?q=Toronto&appid=eaa43d94f204987cc6ae167cb7e5c738&units=metric")
    try:
        database = mysql.connector.connect(
        host="localhost",
        user="",
        password="",
        database="cs4471")
        cursor = database.cursor()
    except mysql.connector.Error as err:
        print(err)

    cursor.execute("DROP TABLE IF EXISTS weather")
    database.commit()
    weather_table = ("CREATE TABLE weather (wid INT NOT NULL AUTO_INCREMENT, name VARCHAR(45) NULL, country VARCHAR(45) NULL, weather_desc VARCHAR(45) NULL,temp FLOAT NULL, temp_min FLOAT NULL, temp_max FLOAT NULL, humidity INT NULL, sunset DATETIME NULL, sunset_str VARCHAR(45) NULL, PRIMARY KEY (wid))")
    cursor.execute(weather_table)
    database.commit()

    add_weather = ("INSERT IGNORE INTO weather (name, country, weather_desc, temp, temp_min, temp_max, humidity, sunset, sunset_str) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)")

    r = response.json()
    data = toDatabase(r)
    cursor.execute(add_weather,data)
    database.commit()
    cursor.close()
    database.close()

if __name__ == "__main__":
    main()


scheduler = BackgroundScheduler()
job = scheduler.add_job(main,'cron', day_of_week ='mon-sun', hour=8, minute=00)
scheduler.start()