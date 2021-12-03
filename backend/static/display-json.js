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

var displayServices = function (serviceData){
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
					token: localStorage.getItem("token"),
					service: service
				}
				fetch(url+"/subscribe", {
					method: 'POST',
					mode: 'cors',
					headers: {
						'Content-Type': 'application/json',
					},
					body: JSON.stringify(input),
				})
				element.innerHTML = '<li><button type="button" class="sub-button">'+ service + '(subbed)</button></li>';
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
