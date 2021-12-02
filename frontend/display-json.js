var display_services=function (data){
	var socketInput = JSON.parse(data)
	var services = socketInput.services;
	var str = '<ul>';
	services.forEach(function(service) {
		str += '<li><button type="button" class="sub-button">'+ service + '</button></li>';
	}); 
	str += '</ul>';
	document.getElementById("subscribe").innerHTML = str;
}

var display_sub = function(data){
	var socketInput = JSON.parse(data)
	var subbed = socketInput.subscriptions;
	var subbed_list = subbed.split(",");
	var subscription_topic = "Canada";
	var sub_info = "blah blah blah";
	var sub_str = '';
	subbed_list.forEach(function(subscription) {
		
		sub_str += '<div class="byte"><h1>'+subscription+'</h1><h2>'+subscription_topic+'</h2><br><p>'+sub_info+'</p></div><hr>';
		}); 

	document.getElementById("feed").innerHTML = sub_str;
}
