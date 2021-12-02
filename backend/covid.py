import requests
import mysql.connector
import datetime
from apscheduler.schedulers.background import BackgroundScheduler

def toDatabase(cases):
    current = cases['active_cases']
    t_case = cases['cases']
    total = cases['cumulative_cases']
    vaccine = cases['cumulative_cvaccine']
    total_death = cases['cumulative_deaths']
    death = cases['deaths']
    d = cases['date']
    date = datetime.datetime.strptime(d, "%d-%m-%Y").strftime("%Y-%m-%d")
    province = cases['province']
    case = (current,t_case,total,vaccine,total_death,death,date,province)
    return case
def main():
    response = requests.get("https://api.opencovid.ca/")
    response2 = requests.get("https://api.opencovid.ca/summary")
    database = mysql.connector.connect(
      host="localhost",
      user="",
      password="",
      database="cs4471"
)
    cursor = database.cursor()
    add_covid = ("INSERT IGNORE INTO covid (active_case,cases,cumulative_cases,cumulative_vaccine,cumulative_death,death,date,province) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)")

    r = response.json()
    summary = r['summary']
    cases = summary[0]
    data = toDatabase(cases)
    cursor.execute(add_covid,data)
    database.commit()
    byProvince = response2.json()
    province = byProvince['summary']
   
    for p in province:
        if p['province'] != "Repatriated":
            d = toDatabase(p)
            cursor.execute(add_covid,d)
            database.commit()
    cursor.close()
    database.close()


scheduler = BackgroundScheduler()
job = scheduler.add_job(main,'cron', day_of_week ='mon-sun', hour=8, minute=00)
scheduler.start()
