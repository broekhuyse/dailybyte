function display(evt){
	
	/*
	const socketInput = {"subbed": ["news"], services: ["news", "covid", "stock", 'weather"]}
	const info = json.parse(socketInput);
	var subbed = info.subbed;
	var services = info.services;
	var service_list = services.split(",");
	*/
	
	const service_list = ["News","Weather","Covid","Stonks"];
	var str = '<ul>';
	service_list.forEach(function(service) {
		str += '<li><button type="button" class="sub-button">'+ service + '</button></li>';
	}); 
	str += '</ul>';
	document.getElementById("subscribe").innerHTML = str;
	

	
	
	const subbed_list = ["News","Stonks"];
	var subscription_topic = "Canada";
	var sub_info = "blah blah blah";
	var sub_str = '';
	subbed_list.forEach(function(subscription) {
		
		sub_str += '<div class="byte"><h1>'+subscription+'</h1><h2>'+subscription_topic+'</h2><br><p>'+sub_info+'</p></div><hr>';
		}); 

	document.getElementById("feed").innerHTML = sub_str;
}