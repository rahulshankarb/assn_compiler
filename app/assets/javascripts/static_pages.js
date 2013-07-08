 
$(document).ready(function(){
	var remaining = Number($('#remaining').val());
	var untilT = new Date();	
	untilT.setSeconds(untilT.getSeconds() + remaining);
	$('#remaining_time').countdown({until:untilT , format: 'HMS'});
 });