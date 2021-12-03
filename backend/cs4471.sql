DROP DATABASE IF EXISTS cs4471;
CREATE DATABASE cs4471;
USE cs4471;

CREATE TABLE user (
	id INT AUTO_INCREMENT PRIMARY KEY,
	email VARCHAR(255) NOT NULL UNIQUE,
	password VARCHAR(255) NOT NULL,
	token VARCHAR(255) UNIQUE
);

CREATE TABLE service (
	service_id VARCHAR(20) PRIMARY KEY
);

CREATE TABLE subscription (
	user_id INT NOT NULL,
	service_id VARCHAR(20) NOT NULL,
	FOREIGN KEY (user_id) REFERENCES user(id),
	FOREIGN KEY (service_id) REFERENCES service(service_id)
);

CREATE TABLE news (
	newsid INT AUTO_INCREMENT PRIMARY KEY, 
	category VARCHAR(20) NOT NULL,
	title VARCHAR(550) NOT NULL UNIQUE, 
	description VARCHAR(500) NOT NULL, 
	url VARCHAR(500) NOT NULL, 
	country VARCHAR(50) NOT NULL
);
CREATE TABLE stock (
	sid INT AUTO_INCREMENT PRIMARY KEY, 
	name VARCHAR(30) NOT NULL,
	symbol VARCHAR(30) NOT NULL UNIQUE, 
	ask INT,
	bid INT
);
CREATE TABLE covid(
	cid INT AUTO_INCREMENT PRIMARY KEY,
	active_case INT,
	cases INT,
	cumulative_cases INT NOT NULL,
	cumulative_vaccine INT NOT NULL,
	cumulative_death INT NOT NULL,
	death INT, 
	date date NOT NULL,
	province VARCHAR(40) NOT NULL
);
CREATE TABLE weather (
	wid INT NOT NULL AUTO_INCREMENT, 
	name VARCHAR(45) NULL, 
	country VARCHAR(45) NULL, 
	weather_desc VARCHAR(45) NULL,
	temp FLOAT NULL, 
	temp_min FLOAT NULL, 
	temp_max FLOAT NULL, 
	humidity INT NULL, 
	sunset DATETIME NULL, 
	sunset_str VARCHAR(45) NULL, 
	PRIMARY KEY (wid)
);

INSERT INTO service (service_id) VALUES ("news");
INSERT INTO service (service_id) VALUES ("covid");
INSERT INTO service (service_id) VALUES ("weather");
INSERT INTO service (service_id) VALUES ("stocks");

INSERT IGNORE INTO weather(wid, name, country, weather_desc, temp, temp_min, temp_max, humidity, sunset, sunset_str) VALUES ('1', 'Toronto', 'CA', 'overcast clouds', '3.45', '2.15', '4.56', '71', '2021-12-02 16:41:50', '16:41');

INSERT IGNORE INTO news (category,title,url,description,country) VALUES ('Entertainment', 'The Young and the Restless Spoilers: Week of December 6 – Sally’s Mission for Adam – Chance’s Traum... - Celebrity Dirty Laundry', 'The Young and the Restless (Y&R) spoilers for the week of December 6-10 tease that Sally Spectra (Courtney Hope) will carry out a mission for Adam Newman (Mark Grossman) while Chance Chancellor (Conner Floyd) deals with his trauma. Jack Abbott (Peter Bergman)…', 'https://www.celebdirtylaundry.com/2021/the-young-and-the-restless-spoilers-week-of-december-6-sallys-mission-for-adam-chances-trauma-jack-phyllis-start-anew/', 'Canada');
INSERT IGNORE INTO news (category,title,url,description,country) VALUES ('Entertainment', 'Tom Ford Opens Up About Life After Losing Husband Richard Buckley: ‘It’s Been Hard After 35 Years’ - ETCanada.com', 'Life goes on for Tom Ford, but it\'s not easy. In September, the famous fashion designer lost his husband Richard Buckley, who died at 72 after a long illness. In a new interview with WSJ. Magazine, Ford opened up about the loss. [readmore label="READ MORE: " …', 'https://etcanada.com/news/843576/tom-ford-opens-up-about-life-after-losing-husband-richard-buckley-its-been-hard-after-35-years/', 'Canada');
INSERT IGNORE INTO news (category,title,url,description,country) VALUES ('Entertainment', 'Watch Dave Grohl sing "Copacabana," "Blitzkreig Bop," and "Jump" for Hanukkah (and yes, they\'re all terrific) - Boing Boing', 'For the third night of The Hanukkah Sessions 2021, Dave Grohl and Foo Fighters producer Greg Kurstin performed “Copacabana” by the great Barry Pincus, aka Barry Manilow! Grohl’s h…', 'https://boingboing.net/2021/12/02/watch-dave-grohl-sing-copacabana-blitzkreig-bop-and-jump-for-hanukkah-and-yes-theyre-all-terrific.html', 'Canada');
INSERT IGNORE INTO news (category,title,url,description,country) VALUES ('Entertainment', 'HBO Spent $30 Million On Game Of Thrones Spinoff Before Cancelling It - GameSpot', "It's revealed in a new book that HBO spent $30 million on the pilot before canceling the show.", 'https://www.gamespot.com/articles/hbo-spent-30-million-on-game-of-thrones-spinoff-before-cancelling-it/1100-6498512/', 'Canada');
INSERT IGNORE INTO news (category,title,url,description,country) VALUES ('Entertainment', 'Duchess of Sussex letter lawsuit: Meghan wins her appeal - CTV News', 'The Duchess of Sussex on Thursday won the latest stage in her long-running privacy lawsuit against a British newspaper publisher over its publication of parts of a letter she wrote to her estranged father.', 'https://www.ctvnews.ca/world/meghan-wins-appeal-in-privacy-dispute-with-u-k-publisher-1.5690335', 'Canada');
INSERT IGNORE INTO news (category,title,url,description,country) VALUES ('Entertainment', 'Nutcracker returns for Christmas — without most of the kids - CBC.ca', "The pitter-patter of little feet will be mostly missing from\xa0the Royal Winnipeg Ballet's (RWB)\xa0Nutcracker when it returns to Ottawa on Friday\xa0after a two-year absence.", 'https://www.cbc.ca/news/canada/ottawa/nutcracker-ballet-covid-children-1.6268358', 'Canada');
INSERT IGNORE INTO news (category,title,url,description,country) VALUES ('General', 'Major highway reopens as rains ease in southern B.C., but flood warnings remain in place for many - CBC.ca', 'British Columbia is set to begin rebuilding from extensive flooding and mudslides after the last of three major storms eased off on Wednesday evening, but flood warnings remain in place for large parts of the province.', 'https://www.cbc.ca/news/canada/british-columbia/wyntk-bc-floods-dec-2-1.6270645', 'Canada');
INSERT IGNORE INTO news (category,title,url,description,country) VALUES ('General', 'B.C. government monitoring deer for COVID-19 virus after 3 infected in Quebec - CTV Edmonton', "British Columbia's Ministry of Forests, Lands and Natural Resources is monitoring the province's deer population for the presence of the virus that causes COVID-19, but says no wildlife cases have been detected so far.", 'https://vancouverisland.ctvnews.ca/b-c-government-monitoring-deer-for-covid-19-virus-after-3-infected-in-quebec-1.5691425', 'Canada');
INSERT IGNORE INTO news (category,title,url,description,country) VALUES ('General', 'Ontario extends COVID-19 booster shots to those 50 and older - Toronto Star', 'Booster shots will be available to Ontarians over 50 starting Dec. 13 as the province steps up the fight against COVID-19 with the advent of the Omicr...', 'https://www.thestar.com/politics/provincial/2021/12/02/ontario-extends-covid-19-booster-shots-to-those-50-and-older.html', 'Canada');
INSERT IGNORE INTO news (category,title,url,description,country) VALUES ('General', "Spacewalking astronauts replace antenna after debris scare - CP24 Toronto's Breaking News", "Spacewalking astronauts replaced a broken antenna outside the International Space Station on Thursday after getting NASA's all-clear for orbiting debris.", 'https://www.cp24.com/world/spacewalking-astronauts-replace-antenna-after-debris-scare-1.5691398', 'Canada');
INSERT IGNORE INTO news (category,title,url,description,country) VALUES ('General', 'Baby identified as victim of house fire near Westport - CBC.ca', 'A baby girl died in a house fire near Westport, Ont., earlier this week, OPP\xa0have confirmed.', 'https://www.cbc.ca/news/canada/ottawa/baby-house-fire-westport-1.6257742', 'Canada');
INSERT IGNORE INTO news (category,title,url,description,country) VALUES ('General', 'How northeastern Ontario became a surprise COVID-19 hotspot - TVO', 'Sudbury. Algoma. Timiskaming. Each is facing increased cases — and its own challenges in overcoming them.', 'https://www.tvo.org/article/how-northeastern-ontario-became-a-surprise-covid-19-hotspot', 'Canada');
INSERT IGNORE INTO news (category,title,url,description,country) VALUES ('General', 'Canadians, other foreigners will need COVID-19 test a day before flights to U.S. - CBC.ca', 'The U.S. will be requiring Canadians and other foreign visitors who arrive by air to get a COVID-19 test no later than 24 hours before their departure, down from a 72-hour window.', 'https://www.cbc.ca/news/world/biden-travel-rules-covid-19-1.6271072', 'Canada');
INSERT IGNORE INTO news (category,title,url,description,country) VALUES ('General', 'Freeland to deliver fiscal update Dec. 14 amid B.C. flooding, U.S. trade woes, record inflation - CBC.ca', 'Finance Minister Chrystia Freeland will release her fall economic and fiscal update on Dec. 14.', 'https://www.cbc.ca/news/politics/freeland-fall-economic-update-1.6271065', 'Canada');
INSERT IGNORE INTO news (category,title,url,description,country) VALUES ('General', 'Canadian sportscaster Brian Williams retires following distinguished 50-year career - CBC.ca', "Veteran sports broadcaster Brian Williams has announced his retirement, ending a five-decade career that saw him rise to prominence as one of Canada's leading authorities on the Olympic Games.", 'https://www.cbc.ca/sports/brian-williams-retires-broadcast-career-1.6271079', 'Canada');
INSERT IGNORE INTO news (category,title,url,description,country) VALUES ('General', 'Ontario reports 761 schools with COVID cases, 7 LTC homes now in outbreak - Toronto Star', 'The province says 10 schools have closed due to outbreaks or operational considerations. Since the start of the school year, there have been 7,922 sch...', 'https://www.thestar.com/news/gta/2021/12/02/ontario-reports-761-schools-with-covid-cases-7-ltc-homes-now-in-outbreak.html', 'Canada');
INSERT IGNORE INTO news (category,title,url,description,country) VALUES ('General', 'Combined COVID-19 and Influenza vaccine clinic being offered on Friday - CKPGToday.ca', 'PRINCE GEORGE- A drop-in COVID-19 and Flu vaccine clinic is being offered by Carrier Sekani Family Services an...', 'https://ckpgtoday.ca/2021/12/02/combined-covid-19-and-influenza-vaccine-clinic-being-offered-on-friday/', 'Canada');
INSERT IGNORE INTO news (category,title,url,description,country) VALUES ('General', 'Michigan school shooting suspect made videos about killing students: lawyers - Globalnews.ca', 'The suspect, Ethan Crumbley, also had two meetings with teachers hours before the shootings to discuss some behavioural concerns.', 'https://globalnews.ca/news/8420298/ethan-crumbley-michigan-school-shooting-videos/', 'Canada');
INSERT IGNORE INTO news (category,title,url,description,country) VALUES ('Science', 'Physicists Finally Observe an Exotic State of Matter First Predicted in 1973 - Gizmodo', 'Quantum spin liquids have been studied for years, but only now have researchers finally seen one in the atomic flesh.', 'https://gizmodo.com/physicists-finally-observe-an-exotic-state-of-matter-fi-1848145197', 'Canada');
INSERT IGNORE INTO news (category,title,url,description,country) VALUES ('Science', 'SpaceX to launch its next Starlink fleet and 2 BlackSky satellites tonight. Watch it live! - Space.com', 'SpaceX will launch its next stack of Starlink satellites from the East Coast tonight (Dec. 2) as part of a rideshare mission, and you can watch the action live online.', 'https://www.space.com/spacex-starlink-launch-webcast-december-2021', 'Canada');
INSERT IGNORE INTO news (category,title,url,description,country) VALUES ('Science', "'Mega asteroid' will pass by close to Earth next week l ABC7 - ABC7", "A sizable asteroid is going to make a close pass to Earth next week, scientists say, but there's no need to panic. The asteroid known as 4660 Nereus will com...", 'https://www.youtube.com/watch?v=Uc7KUNXzT8Y', 'Canada');
INSERT IGNORE INTO news (category,title,url,description,country) VALUES ('Science', "Researcher outlines how whales' sensory systems have evolved through imaging technology - Phys.Org", "If you've ever had an ear infection that made you dizzy or unbalanced, the infection likely was affecting your vestibular complex—part of the intricate system of hard and soft tissues that make up the inner ear. Knowledge of this structure has been made possi…", 'https://phys.org/news/2021-12-outlines-whales-sensory-evolved-imaging.html', 'Canada');
INSERT IGNORE INTO news (category,title,url,description,country) VALUES ('Science', 'One of the best meteor showers of the year will be visible in Canada this month - Curiocity', "It's known for having more meteors per hour than any others.", 'https://curiocity.com/one-of-the-best-meteor-showers-of-the-year-will-be-visible-in-canada-this-month/', 'Canada');
INSERT IGNORE INTO news (category,title,url,description,country) VALUES ('Science', 'Researchers Suggest New Theoretical Model of Supercapacitors - AZoM', 'Scientists from HSE Moscow Institute of Electronics and Mathematics (HSE MIEM) and the Institute of Non-Classical Chemistry in Leipzig have suggested a new theoretical model of supercapacitors that considers the properties of a cation. This significantly affe…', 'https://www.azom.com/news.aspx?newsID=57547', 'Canada');
INSERT IGNORE INTO news (category,title,url,description,country) VALUES ('Science', 'A dinosaur trove in Italy rewrites the history, geography and evolution of the ancient Mediterranean area - Phys.Org', 'Italy is not exactly renowned for dinosaurs. In comparison to its excellent artistic and archaeological heritage, dinosaur fossils are very rare. Not surprisingly, the discovery of the first isolated dinosaurs in the early 1990s generated excitement, but are …', 'https://phys.org/news/2021-12-dinosaur-trove-italy-rewrites-history.html', 'Canada');
INSERT IGNORE INTO news (category,title,url,description,country) VALUES ('Science', '50 years ago, Russia landed on Mars for 15 seconds — and taught America a lesson - Inverse', 'Mars 3 accomplished the first soft landing on Mars. Then it died. It carried aboard it a rover, Prop-M, that would have been the first on another planet.', 'https://www.inverse.com/science/mars-3-anniversary', 'Canada');
INSERT IGNORE INTO news (category,title,url,description,country) VALUES ('Science', 'Three-dimensional imaging with optical frequency combs - Phys.Org', 'Holography is a powerful technique of photography of a light field without a lens for 3D imaging and display. Now, scientists at the Max-Planck Institute of Quantum Optics are moving holography forward by implementing it with optical frequency combs. Thousand…', 'https://phys.org/news/2021-12-three-dimensional-imaging-optical-frequency.html', 'Canada');
INSERT IGNORE INTO news (category,title,url,description,country) VALUES ('Science', "This 130 million-year-old ichthyosaur was a 'hypercarnivore' with knife-like teeth - Livescience.com", 'The ichthyosaur had evolved to chomp large prey.', 'https://www.livescience.com/extinct-ichthyosaur-was-hypercarnivore-knife-teeth', 'Canada');
INSERT IGNORE INTO news (category,title,url,description,country) VALUES ('Science', 'World\'s first living robots "Xenobots" can now reproduce - Engadget', 'Get More Engadget: • Like us on Facebook: http://www.facebook.com/engadget• Follow us on Twitter: http://www.twitter.com/engadget• Follow us on Instagram: ht...', 'https://www.youtube.com/watch?v=kQ9cciBx_oU', 'Canada');
INSERT IGNORE INTO news (category,title,url,description,country) VALUES ('Science', 'What is It Like to Land on Mars? NASA Scientist Explains - News18', 'Scientists had installed a set of temperature and pressure sensors, called MEDLI2, across the inside of the heat shield to measure the extreme conditions under which the landing was taking place.', 'https://www.news18.com/news/buzz/what-is-it-like-to-land-on-mars-nasa-scientist-explains-4509881.html', 'Canada');
INSERT IGNORE INTO news (category,title,url,description,country) VALUES ('Science', "The brightest comet of the year, Leonard, is approaching Earth. Here's how to see it. - USA TODAY", "A comet that hasn't been near Earth in over 70,000 years can be seen now all the way until Christmas. Here's how to see it before it's gone forever.", 'https://www.usatoday.com/story/news/nation/2021/12/02/comet-leonard-brightest-comet-2021-december/8811373002/', 'Canada');
INSERT IGNORE INTO news (category,title,url,description,country) VALUES ('Sports', 'Woj updates the status of Karl-Anthony Towns and Damian Lillard | NBA Today - ESPN', 'Adrian Wojnarowski joins Malika Andrews on NBA Today to discuss Karl-Anthony Towns’ status and suffering a hard fall in the fourth quarter of the Minnesota T...', 'https://www.youtube.com/watch?v=FAbFxJB2HBM', 'Canada');
INSERT IGNORE INTO news (category,title,url,description,country) VALUES ('Sports', "Olympic boycott: Feds will 'respect' athletes' decision - CTV News", "Canada's new Minister of Sport Pascale St-Onge says she respects the decision of Canadian athletes to attend the Beijing Olympics amid calls for some version of a boycott.", 'https://www.ctvnews.ca/politics/sport-minister-will-respect-decision-of-canadian-athletes-to-attend-beijing-olympics-1.5691263', 'Canada');
INSERT IGNORE INTO news (category,title,url,description,country) VALUES ('Sports', 'Canadian sportscaster Brian Williams retires following distinguished 50-year career - CBC.ca', "Veteran sports broadcaster Brian Williams has announced his retirement, ending a five-decade career that saw him rise to prominence as one of Canada's leading authorities on the Olympic Games.", 'https://www.cbc.ca/sports/brian-williams-retires-broadcast-career-1.6271079', 'Canada');
INSERT IGNORE INTO news (category,title,url,description,country) VALUES ('Sports', 'Pros react to UFC President Dana White’s positive COVID-19 test - MMA Fighting', 'See how fighters reacted to the news that UFC boss Dana White’s brush with COVID-19.', 'https://www.mmafighting.com/2021/12/2/22812961/pros-react-to-ufc-president-dana-whites-positive-covid-19-test', 'Canada');
INSERT IGNORE INTO news (category,title,url,description,country) VALUES ('Sports', 'Josh Giddey Wins Western Conference Kia Rookie Of The Month! - NBA', 'Stream More Live Games With NBA LEAGUE PASS: https://app.link.nba.com/e/subscribe_nowSubscribe to the NBA: https://on.nba.com/2JX5gSN#KIAROTM', 'https://www.youtube.com/watch?v=mlsdZxNpd1Y', 'Canada');
INSERT IGNORE INTO news (category,title,url,description,country) VALUES ('Sports', 'The CFL is worth fighting for, and these steps to save it should be explored - Sportsnet.ca', 'The CFL, while stronger in many areas than it was decades ago when stadiums were crumbling, has many serious issues – and it’s high time the league takes a good look in the mirror. With that in mind, here are five ideas the league should explore this off-seas…', 'https://www.sportsnet.ca/cfl/article/5-steps-the-cfl-should-explore-to-address-league-issues/', 'Canada');
INSERT IGNORE INTO news (category,title,url,description,country) VALUES ('Sports', 'Sabres acquire goaltender Malcolm Subban from Blackhawks - The Athletic', 'The Sabres haven’t been able to get solid goaltending since 40-year-old Craig Anderson was injured.', 'https://theathletic.com/news/sabres-acquire-goaltender-malcolm-subban-from-blackhawks/7ddd5LJHAGzd/', 'Canada');
INSERT IGNORE INTO news (category,title,url,description,country) VALUES ('Sports', 'NHL Power Rankings: Bounce-back players edition - Sportsnet.ca', "It takes strength and resiliency to dust yourself off after a down season (whether injury-induced or just plain old off-pace play) and regain old form, and many of the players highlighted in this week's power rankings are doing exactly that.", 'https://www.sportsnet.ca/nhl/article/nhl-power-rankings-bounce-back-players-edition/', 'Canada');
INSERT IGNORE INTO news (category,title,url,description,country) VALUES ('Technology', "MacOS Monterey 'Tap to Click' Trackpad Issue Fixed in Latest Beta - iPhone in Canada", 'The issue appears to have affected a variety of Macs.', 'https://www.iphoneincanada.ca/news/macos-12-1-tap-to-click-problem-fix/', 'Canada');
INSERT IGNORE INTO news (category,title,url,description,country) VALUES ('Technology', "How to Fix Your Pixel 6's Connectivity Issues - Lifehacker", 'If your Pixel 6 or Pixel 6 Pro is dropping its connection to your network, try these fixes.', 'https://lifehacker.com/how-to-fix-your-pixel-6s-connectivity-issues-1848149259', 'Canada');
INSERT IGNORE INTO news (category,title,url,description,country) VALUES ('Technology', 'Meta’s NPE team takes a global focus with seed-stage investments, offices in emerging markets - TechCrunch', 'Meta’s (formerly, Facebook’s) experimental app division, the NPE team, is shifting gears. The group, which first launched in mid-2019, has been focused on building consumer-facing apps that would allow the company to test out new social features and gauge peo…', 'http://techcrunch.com/2021/12/02/metas-npe-team-takes-a-global-focus-with-seed-stage-investments-offices-in-emerging-markets/', 'Canada');
INSERT IGNORE INTO news (category,title,url,description,country) VALUES ('Technology', '‘Moss: Book II’ will launch in Spring 2022 - NME.com', 'The sequel to the PSVR game, Moss, will launch in Spring 2022.', 'https://www.nme.com/news/gaming-news/moss-book-ii-will-launch-in-spring-2022-3109722', 'Canada');
INSERT IGNORE INTO news (category,title,url,description,country) VALUES ('Technology', 'Tears of Joy Remained Most Used Emoji in 2021 - MacRumors', "Tears of Joy continued to be one of the most popular emoji used worldwide in 2021, according to the Unicode Consortium's list of the top emoji...", 'https://www.macrumors.com/2021/12/02/most-popular-emoji-2021/', 'Canada');
INSERT IGNORE INTO news (category,title,url,description,country) VALUES ('Technology', '‘Final Fantasy 14: Endwalker’ gets a music video from Sia - NME.com', "Square Enix released a 'Final Fantasy 14: Endwalker' trailer, featuring music dedicated by Sia.", 'https://www.nme.com/news/gaming-news/final-fantasy-14-endwalker-gets-a-music-video-from-sia-3109843', 'Canada');
INSERT IGNORE INTO news (category,title,url,description,country) VALUES ('Technology', 'Battlefield Franchise Undergoes Major Shake-Up - GameSpot', 'EA announces a restructuring of its development teams as it looks to grow Battlefield.', 'https://www.gamespot.com/articles/battlefield-franchise-undergoes-major-shake-up/1100-6498521/', 'Canada');
INSERT IGNORE INTO news (category,title,url,description,country) VALUES ('Technology', 'Luna Display’s latest update lets you use a Mac as a second PC display - The Verge', 'Luna Display’s latest software update adds support for using a Mac desktop or laptop as a second display for a Windows PC, making it perfect for extending a Windows computer to an M1 iMac.', 'https://www.theverge.com/2021/12/2/22813992/luna-display-update-pc-mac-second-display-4k-5k-imac-m1', 'Canada');
INSERT IGNORE INTO news (category,title,url,description,country) VALUES ('Technology', "Seven amazing indie PC games you can't miss in December - PCGamesN", 'A fresh batch of indie gaming goodies, just in time for the holiday season', 'https://www.pcgamesn.com/fights-in-tight-spaces/december-games-2021', 'Canada');
INSERT IGNORE INTO news (category,title,url,description,country) VALUES ('Technology', 'Break Arts II - Launch Trailer | PS4 - PlayStation Universe', "Break Arts II - The robot customization battle racing game that let's you customize your own robot freely and battle race against rivals.Available on PS4 on ...", 'https://www.youtube.com/watch?v=66LqfaeYwok', 'Canada');
INSERT IGNORE INTO news (category,title,url,description,country) VALUES ('Technology', 'Terminator: Resistance - Annihilation Line DLC Gameplay Trailer | PS5 - PlayStation Universe', 'Get a look at the new DLC campaign for Terminator: Resistance in action! Annihilation Line will be available to purchase digitally for PlayStation®5 on Decem...', 'https://www.youtube.com/watch?v=l6pbseSQsz8', 'Canada');
INSERT IGNORE INTO news (category,title,url,description,country) VALUES ('Technology', 'PS Plus Games For December Are Great, But There’s A Catch - Forbes', 'Godfall on PS Plus is a major disappointment in an otherwise great month of free games.', 'https://www.forbes.com/sites/erikkain/2021/12/02/ps-plus-games-for-december-are-great-but-theres-a-catch/', 'Canada');
INSERT IGNORE INTO news (category,title,url,description,country) VALUES ('Technology', 'How Qualcomm’s Handheld Gaming Console Could Challenge Nintendo Switch - Forbes', 'The just-announced processor from Qualcomm is designed to play Xbox and Steam games as well as Android.', 'https://www.forbes.com/sites/davidphelan/2021/12/02/how-qualcomms-handheld-gaming-console-could-challenge-nintendo-switch-xbox/', 'Canada');
INSERT IGNORE INTO covid (active_case,cases,cumulative_cases,cumulative_vaccine,cumulative_death,death,date,province) VALUES (26053, 3286, 1803063, 29035530.0, 29644.0, 23.0, '2021-12-01', 'Canada');
INSERT IGNORE INTO covid (active_case,cases,cumulative_cases,cumulative_vaccine,cumulative_death,death,date,province) VALUES (4621, 430, 335677, 3158027.0, 3253.0, 7.0, '2021-12-01', 'Alberta');
INSERT IGNORE INTO covid (active_case,cases,cumulative_cases,cumulative_vaccine,cumulative_death,death,date,province) VALUES (3078, 386, 218812, 4058944.0, 2340.0, 7.0, '2021-12-01', 'BC');
INSERT IGNORE INTO covid (active_case,cases,cumulative_cases,cumulative_vaccine,cumulative_death,death,date,province) VALUES (1383, 122, 67999, 1025129.0, 1321.0, 2.0, '2021-12-01', 'Manitoba');
INSERT IGNORE INTO covid (active_case,cases,cumulative_cases,cumulative_vaccine,cumulative_death,death,date,province) VALUES (677, 93, 8411, 613664.0, 128.0, 3.0, '2021-12-01', 'New Brunswick');
INSERT IGNORE INTO covid (active_case,cases,cumulative_cases,cumulative_vaccine,cumulative_death,death,date,province) VALUES (29, 2, 2059, 439047.0, 18.0, 0.0, '2021-12-01', 'NL');
INSERT IGNORE INTO covid (active_case,cases,cumulative_cases,cumulative_vaccine,cumulative_death,death,date,province) VALUES (203, 34, 8322, 791542.0, 110.0, 0.0, '2021-12-01', 'Nova Scotia');
INSERT IGNORE INTO covid (active_case,cases,cumulative_cases,cumulative_vaccine,cumulative_death,death,date,province) VALUES (0, 0, 674, 24037.0, 4.0, 0.0, '2021-12-01', 'Nunavut');
INSERT IGNORE INTO covid (active_case,cases,cumulative_cases,cumulative_vaccine,cumulative_death,death,date,province) VALUES (18, 0, 2060, 36187.0, 12.0, 0.0, '2021-12-01', 'NWT');
INSERT IGNORE INTO covid (active_case,cases,cumulative_cases,cumulative_vaccine,cumulative_death,death,date,province) VALUES (6774, 936, 626704, 11259729.0, 9938.0, 1.0, '2021-12-01', 'Ontario');
INSERT IGNORE INTO covid (active_case,cases,cumulative_cases,cumulative_vaccine,cumulative_death,death,date,province) VALUES (29, 0, 372, 132385.0, 0.0, 0.0, '2021-12-01', 'PEI');
INSERT IGNORE INTO covid (active_case,cases,cumulative_cases,cumulative_vaccine,cumulative_death,death,date,province) VALUES (8447, 1196, 449367, 6627017.0, 11581.0, 2.0, '2021-12-01', 'Quebec');
INSERT IGNORE INTO covid (active_case,cases,cumulative_cases,cumulative_vaccine,cumulative_death,death,date,province) VALUES (736, 82, 81074, 836064.0, 926.0, 1.0, '2021-12-01', 'Saskatchewan');
INSERT IGNORE INTO covid (active_case,cases,cumulative_cases,cumulative_vaccine,cumulative_death,death,date,province) VALUES (58, 5, 1519, 33758.0, 13.0, 0.0, '2021-12-01', 'Yukon');

INSERT INTO stock (name, symbol, ask, bid) VALUES ('Apple', 'AAPL', 162.32, 162.55);
INSERT INTO stock (name, symbol, ask, bid) VALUES ('Microsoft', 'MSFT', 328.93, 328.35);
INSERT INTO stock (name, symbol, ask, bid) VALUES ('Amazon.com', 'AMZN', 3436.0, 3431.0);
INSERT INTO stock (name, symbol, ask, bid) VALUES ('Meta Platforms', 'FB', 309.9, 309.7);
INSERT INTO stock (name, symbol, ask, bid) VALUES ('Tesla', 'TSLA', 1083.4, 1073.5);
