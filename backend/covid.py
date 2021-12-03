import requests
import mysql.connector
import datetime
import os

def toJson():
    json = {}
    mydb = mysql.connector.connect(
        host=os.environ['DB_HOST'],
        user=os.environ['DB_USER'],
        password=os.environ['DB_PASSWORD'],
        database="cs4471"
    )
    mycursor = mydb.cursor()
    mycursor.execute("SELECT * FROM covid")
    myresult = mycursor.fetchall()
    for x in myresult:
        s = {'active_cases':x[0],'cases':x[1],'total':x[2],'cumulative_cvaccine':x[3],'cumulative_deaths':x[4],'deaths':x[5],'date':x[6],'province':x[7]}
        json[x[7]]=s
    mycursor.close()
    mydb.close()
    return json
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
      host=os.environ['DB_HOST'],
      user=os.environ['DB_USER'],
      password=os.environ['DB_PASSWORD'],
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

    cursor.execute("DROP TABLE IF EXISTS covid")
    database.commit()
    covidtable = ("CREATE TABLE covid(cid INT AUTO_INCREMENT PRIMARY KEY,active_case INT,active_cases_change INT,cumulative_cases INT NOT NULL,cumulative_vaccine INT NOT NULL,cumulative_death INT NOT NULL,death INT, date DATE NOT NULL,province VARCHAR(40) NOT NULL)")
    cursor.execute(covidtable)
    database.commit()
   
    for p in province:
        if p['province'] != "Repatriated":
            d = toDatabase(p)
            cursor.execute(add_covid,d)
            database.commit()
    cursor.close()
    database.close()
  


