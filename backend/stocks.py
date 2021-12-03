import requests
import mysql.connector
import os
def toJson():
    json = []
    mydb = mysql.connector.connect(
        host=os.environ['DB_HOST'],
        user=os.environ['DB_USER'],
        password=os.environ['DB_PASSWORD'],
        database="cs4471"
)
    mycursor = mydb.cursor()
    mycursor.execute("SELECT name, symbol, ask, bid FROM stock")
    myresult = mycursor.fetchall()
    for x in myresult:
        s = {'name':x[0],'symbol':x[1],'ask':x[2],'bid':x[3]}
        json.append(s)
    mycursor.close()
    mydb.close()

    return json

def toDatabase(result,cs,db,query):
    for s in result:
        a = s['ask']
        b = s['bid']
        symbol = s['symbol']
        name = s['displayName']
        stock = (name,symbol,a,b)
        cs.execute(query,stock)
        db.commit()



def main():

    url = "https://yfapi.net/v6/finance/quote"
    querystring = {"symbols":"AAPL,MSFT,AMZN,FB,TSLA"}

    headers = {
        'x-api-key': "WlUJfHQDGiaczhnIzv7US8NZWSPZdCo31OWrgj6m"
    }
    response = requests.request("GET", url, headers=headers, params=querystring)
    database = mysql.connector.connect(
      host=os.environ['DB_HOST'],
      user=os.environ['DB_USER'],
      password=os.environ['DB_PASSWORD'],
      database="cs4471"
)
    query = ("INSERT IGNORE INTO stock (name,symbol,ask,bid) VALUES (%s, %s, %s, %s)")
    cursor = database.cursor()
    r = response.json()
    stock = []
    r2 = r['quoteResponse']
    apple = r2['result'][0]
    micro = r2['result'][1]
    amazon = r2['result'][2]
    fb = r2['result'][3]
    tsl = r2['result'][4]
    stock.append(apple)
    stock.append(micro)
    stock.append(amazon)
    stock.append(fb)
    stock.append(tsl)
    for a in stock:
        toDatabase(a,cursor,database,query)
    cursor.close()
    database.close()
