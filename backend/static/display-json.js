var displayServices = function (serviceData){
	let token = localStorage.getItem("token")
	document.getElementById("subscribe").innerHTML = null;
	let str = '<ul>';
	serviceData.services.forEach(function(service) {
		if (serviceData.subscriptions.indexOf(service) == -1){
			str += '<li><button type="button" class="sub-button" id="' + service + '-button">'+ service + '(unsubbed)</button></li>';
		} else {
			str += '<li><button type="button" class="sub-button">'+ service + '(subbed)</button></li>';
		}
		
	}); 
	str += '</ul>';
	document.getElementById("subscribe").innerHTML = str;
	serviceData.services.forEach(function(service) {
		let element = document.getElementById(service+"-button");
		if (element != null) {
			element.onclick = function() {
				let input = {
					token: token,
					service: service
				}
				console.log(input);
				fetch(url+"/subscribe", {
					method: 'POST',
					mode: 'cors',
					headers: {
						'Content-Type': 'application/json',
					},
					body: JSON.stringify(input),
				})
			};
		}
		
	}); 
	
}
let url = "http://127.0.0.1:5000";

var displayCovid = function(covidData){
	document.getElementById("covid").innerHTML = null;
	let str = '<h1>Covid 19</h1>';
	for (let i = 0; i < covidData.length; i++) {
		str += '<ul>';
		str += '<h2>' + covidData[i]["province"] + '</h2>';
		for (const key in covidData[i]) {
			str += '<li>'+key + ': ' + covidData[i][key] + '</li>';
		}
		str += '</ul>';
	}
	document.getElementById("covid").innerHTML = str;
}

var displayNews = function(newsData){
	document.getElementById("news").innerHTML = null;
	let str = '<h1>News</h1>';
	
	for (let i = 0; i < newsData.length; i++) { 
		str += '<ul>';
		str += '<h2>' + newsData[i]["title"] + '</h2>';
		for (const key in newsData[i]) {
			str += '<li>'+key + ': ' + newsData[i][key] + '</li>';
		}
		str += '</ul>';
	}
	document.getElementById("news").innerHTML = str;
}

var displayStocks = function(stocksData){
	document.getElementById("stocks").innerHTML = null;
	let str = '<h1>Stocks</h1>';
	
	for (let i = 0; i < stocksData.length; i++) { 
		str += '<ul>';
		str += '<h2>' + stocksData[i]["name"] + '</h2>';
		for (const key in stocksData[i]) {
			str += '<li>'+key + ': ' + stocksData[i][key] + '</li>';
		}
		str += '</ul>';
	}
	document.getElementById("stocks").innerHTML = str;
}


var displayWeather = function(weatherData){
	document.getElementById("weather").innerHTML = null;
	let str = '<h1>Weather</h1>';
	
	for (let i = 0; i < weatherData.length; i++) { 
		str += '<ul>';
		str += '<h2>' + weatherData[i]["name"] + '</h2>';
		for (const key in weatherData[i]) {
			str += '<li>'+key + ': ' + weatherData[i][key] + '</li>';
		}
		str += '</ul>';
	}
	document.getElementById("weather").innerHTML = str;
}
