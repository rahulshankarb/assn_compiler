
$(document).ready(function(){



	$( "#contest_start_date" ).datetimepicker({ 

		dateFormat:"yy-mm-dd",
		minDate: 0
		} );

	$("#contest_problem_ids").chosen();
	//$("#contest_user_ids").chosen();

	
	$('#local_time').text(moment().format('MMMM Do YYYY, h:mm:ss a')) ;    //first call
	

	
	setInterval("updateTime()", 1000); //update every 1000 ms

/**

		$('#contest_file_size_val').hide();
		$('#contest_memory_used_val').hide();
		$('#contest_run_time_val').hide();

		$('#contest_file_size').bind('click', function() {
			$('#contest_file_size_val').toggle();  		
		});
		$('#contest_memory_used').bind('click', function() {
			$('#contest_memory_used_val').toggle();  		
		});
		$('#contest_run_time').bind('click', function() {
			$('#contest_run_time_val').toggle();  		
		});


**/
	 
		$('#custom_options').hide(); // default options is ACM
		// shows the custom optiosn when radio Custom is selected	
		$('.maraton_type').bind('click', function() {
			if ($("#contest_acm_true").attr("checked") == "checked"){
				$('#custom_options').hide();
				$('#acm_options').show();
			}				
			else{
				$('#custom_options').show();
				$('#acm_options').hide();			
			}
				
		});
	

	$('#startBtn').bind('click', function() {
		$('#startBtn').fadeOut('slow');
		$('#finalizeBtn').fadeIn('slow');  		
	});
	$('#finalizeBtn').bind('click', function() {
  		
	});
	$('#new_contest').submit(function(e){
		//e.preventDefault();
		var sum = checkPercentages ();
		if(sum==100){
			//$('#new_contest').submit();
			return true;
		}else{
			alert("The sum of the percenages is "+sum+" make sure it's exactly 100")
			return false;
		}

	});



	start_date = $('#start_date').val(); //fecha de ruby
	duration = $('#duration').val(); //integer 

	

	var remaining = Number($('#remaining').val());

	//$('#remaining_time').text(remaining);


	//alert(remaining);

	var untilT = new Date();
	
	untilT.setSeconds(untilT.getSeconds() + remaining);
	$('#remaining_time').countdown({until:untilT , format: 'dHMS'});



 });

	function updateTime () {		
		$('#local_time').text(moment().format('MMMM Do YYYY, h:mm:ss a')) ;    
	};

	function checkPercentages () {		
		var contest_file_size_val = Number($('#contest_file_size_val').val());
		//var contest_memory_used_val= Number($('#contest_memory_used_val').val());
		var contest_run_time_val= Number($('#contest_run_time_val').val());
		var contest_validate_val= Number($('#contest_validate_val').val());
		var sum = contest_file_size_val+contest_run_time_val+contest_validate_val;

		return sum;

	};






