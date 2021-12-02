from newsapi import NewsApiClient
import mysql.connector
from apscheduler.schedulers.background import BackgroundScheduler

# cursor.execute("DROP TABLE IF EXISTS news")
# database.commit()
# newstable = ("CREATE TABLE news(newsid INT AUTO_INCREMENT PRIMARY KEY, category VARCHAR(20) NOT NULL, title VARCHAR(550) NOT NULL UNIQUE, url VARCHAR(500) NOT NULL, description VARCHAR(500) NOT NULL, country VARCHAR(50) NOT NULL)")
# cursor.execute(newstable)
# database.commit()
def toJson():
    json = []
    mydb = mysql.connector.connect(
        host="localhost",
        user="",
        password="",
        database="cs4471"
)
    mycursor = mydb.cursor()
    mycursor.execute("SELECT * FROM news")
    myresult = mycursor.fetchall()
    for x in myresult:
        s = {'category':x[0],'title':x[1],'url':x[2],'description':x[3],'country':x[4]}
        json.append(s)
    return json
def addNews(headlines,category,country,cs,db,query):
    for news in headlines:
        title = news['title']
        desc = news['description']
        url = news['url']
        article = (category, title, desc, url, country)
        cs.execute(query, article)
        db.commit()

def main():
    newsapi = NewsApiClient(api_key='6584b8e077ca4cb198ab9d6d38ad12f8')

    database = mysql.connector.connect(
        host="localhost",
        user="",
        password="",
        database="cs4471"
    )
    cursor = database.cursor()
    add_news = ("INSERT IGNORE INTO news (category,title,url,description,country) VALUES (%s, %s, %s, %s, %s)")


    business_headlines = newsapi.get_top_headlines(language='en', category='business', country='ca')
    et_headlines = newsapi.get_top_headlines(language='en', category='entertainment', country='ca')
    gen_headlines = newsapi.get_top_headlines(language='en', category='general', country='ca')
    heal_headlines = newsapi.get_top_headlines(language='en', category='health', country='ca')
    sci_headlines = newsapi.get_top_headlines(language='en', category='science', country='ca')
    spts_headlines = newsapi.get_top_headlines(language='en', category='sports', country='ca')
    tech_headlines = newsapi.get_top_headlines(language='en', category='technology', country='ca')


    business = business_headlines['articles']
    addNews(business,'Business','Canada',cursor,database,add_news)
    entertainment = et_headlines['articles']
    addNews(entertainment,'Entertainment','Canada',cursor,database,add_news)
    general = gen_headlines['articles']
    addNews(general,'General','Canada',cursor,database,add_news)
    health = heal_headlines['articles']
    addNews(health,'Health','Canada',cursor,database,add_news)
    science = sci_headlines['articles']
    addNews(science,'Science','Canada',cursor,database,add_news)
    sports = spts_headlines['articles']
    addNews(sports,'Sports','Canada',cursor,database,add_news)
    technology = tech_headlines['articles']
    addNews(technology,'Technology','Canada',cursor,database,add_news)
    
 
    business_headlines = newsapi.get_top_headlines(language='en', category='business', country='us')
    et_headlines = newsapi.get_top_headlines(language='en', category='entertainment', country='us')
    gen_headlines = newsapi.get_top_headlines(language='en', category='general', country='us')
    heal_headlines = newsapi.get_top_headlines(language='en', category='health', country='us')
    sci_headlines = newsapi.get_top_headlines(language='en', category='science', country='us')
    spts_headlines = newsapi.get_top_headlines(language='en', category='sports', country='us')
    tech_headlines = newsapi.get_top_headlines(language='en', category='technology', country='us')

    business = business_headlines['articles']
    addNews(business,'Business','USA',cursor,database,add_news)
    entertainment = et_headlines['articles']
    addNews(entertainment,'Entertainment','USA',cursor,database,add_news)
    general = gen_headlines['articles']
    addNews(general,'General','USA',cursor,database,add_news)
    health = heal_headlines['articles']
    addNews(health,'Health','USA',cursor,database,add_news)
    science = sci_headlines['articles']
    addNews(science,'Science','USA',cursor,database,add_news)
    sports = spts_headlines['articles']
    addNews(sports,'Sports','USA',cursor,database,add_news)
    technology = tech_headlines['articles']
    addNews(technology,'Technology','USA',cursor,database,add_news)
    
    cursor.close()
    database.close()

scheduler = BackgroundScheduler()
job = scheduler.add_job(main,'cron', day_of_week ='mon-sun', hour=8, minute=00)
scheduler.start()
