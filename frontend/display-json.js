/*
function display(data){
	data = '{"services":["covid","news"]}'
	var socketInput = JSON.parse(data)
	var services = socketInput.services;
	var str = '<ul>';
	services.forEach(function(service) {
		str += '<li><button type="button" class="sub-button">'+ service + '</button></li>';
	}); 
	str += '</ul>';
	document.getElementById("subscribe").innerHTML = str;
}
*/
var serviceData = null;
var covidData = null;
var newsData = null;
var weatherData = null;
var stockData = null;

var displayServices = function (data){
	document.getElementById("subscribe").innerHTML = null;
	let str = '<ul>';
	serviceData.services.forEach(function(service) {
		if (serviceData.subscriptions.indexOf(service) == -1){
			str += '<li><button type="button" class="sub-button">'+ service + '(unsubbed)</button></li>';
		} else {
			str += '<li><button type="button" class="sub-button">'+ service + '(subbed)</button></li>';
		}
		
	}); 
	str += '</ul>';
	document.getElementById("subscribe").innerHTML = str;
}

var displayCovid = function(){
	document.getElementById("covid").innerHTML = null;
	let str = '<h1>Covid 19</h1>';
	
	for (let i = 0; i < covidData.length; i++) { 
		str += '</ul>';
		for (const key in covidData[i]) {
			str += '<li>'+key + ': ' + covidData[i][key] + '</li>';
		}
	}
	document.getElementById("covid").innerHTML = str;
}

var displayNews = function(){
	document.getElementById("news").innerHTML = null;
	let str = '<h1>News</h1>';
	
	for (let i = 0; i < newsData.length; i++) { 
		str += '</ul>';
		for (const key in newsData[i]) {
			str += '<li>'+key + ': ' + newsData[i][key] + '</li>';
		}
	}
	document.getElementById("news").innerHTML = str;
}
