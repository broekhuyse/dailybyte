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

var display_services = function (data){
	let services = serviceData.services;
	let str = '<ul>';
	services.forEach(function(service) {
		if (serviceData.subscriptions.indexOf("turtles") == -1){
			str += '<li><button type="button" class="sub-button">'+ service + '(unsubbed)</button></li>';
		} else {
			str += '<li><button type="button" class="sub-button">'+ service + '(subbed)</button></li>';
		}
		
	}); 
	str += '</ul>';
	document.getElementById("subscribe").innerHTML = str;
}

var display_sub = function(){
	let subbed_list = serviceData.subscriptions;
	let subscription_topic = "Canada";
	let sub_info = "blah blah blah";
	let sub_str = '';
	subbed_list.forEach(function(subscription) {
		
		sub_str += '<div class="byte"><h1>'+subscription+'</h1><h2>'+subscription_topic+'</h2><br><p>'+sub_info+'</p></div><hr>';
		}); 

	document.getElementById("feed").innerHTML = sub_str;
}
