// JavaScript source code
// High Temperature Sensor

var sensorlist = [];
var alert;
var errorCount = 0;

const UpArrow = "&#8593";
const DnArrow = "&#8595";

/*
$('.timer').click(function(){			
			var target = $(this).attr("id");			
			alert(target);
		});
*/

function initControls() {
    //
    // Init controls
    //
	
	
}

/* --------------------------------------------
// Initial loading of tank information


*/

function loadTanks()
{
    // Call ERPC getTempSensors() to retrieve all of the Sensors
    erpc("GetTanks", null, function (result) {
        if (result) {
            tankList = result;
            
            
            $.each( tankList, function( key, value ) {
  				tank = key;
                tankTemp = 0;
                tankMin = 0;
                tankMax = 0;
                tankAlarm = 0;
                tankLastTemp = 0;
                tempF = false;

              
						
                $.each( value, function( key, value ) {
                    if(key == "Temp"){
                        // get last temp
                        tankLastTemp = parseFloat($("." + tank + " .tank" + key).text());
                        
                        // set current temp
                        if(tempF)
						{
							tankTemp = Math.round10(value * 1.8 + 32, -2);
						}
						else
						{
							tankTemp = Math.round10(value, -2);
						}
                        $("." + tank + " .tank" + key).text(tankTemp);
                    }
                    else
                    {
                        if(key == "HeaterEnabled") {
                            $("." + tank + " .tank" + key).prop('checked', value);
                            if(value) {
                            	$("." + tank + " .heaterText").removeClass("red");
                            	$("." + tank + " .heaterText").addClass("green");  
                            }
                            else {
                                $("." + tank + " .tank" + key).prop('checked', value);
                                $("." + tank + " .heaterText").removeClass("green");
                                $("." + tank + " .heaterText").addClass("red");
                            }
                        }
	                    $("." + tank + " .tank" + key).text(value);
                    }
                    
                    if(key == "MinTemp"){
                        tankMin = value;
                    }
                    if(key == "MaxTemp"){
                        tankMax = value;
                    }
                    
                    if(key == "HeaterId"){
                        $("." + tank + " .heaterText").text(" Heater " + (parseInt(value) + 1).toString());
                    }
                }); // $.each( value, function( key, value )
                
                // if temperature out of range then color temperature red
                // up arrow &#8593;
				// down arrow &#8595;
                $("." + tank + " div.temp").removeClass("red yellow green");
                    if(tankTemp < tankMin){
                        $("." + tank + " div.temp").addClass("yellow");
                    }
                    else if(tankTemp > tankMax){
                        $("." + tank + " div.temp").addClass("red");
                    }
                    else if(tankTemp < tankMin && tankTemp > tankMax) {
                    	$("." + tank + " div.temp").addClass("green");
                    }
                
                if(tankTemp < tankMin || tankTemp > tankMax){
                    
                }
                else
                {
                    $("." + tank + " div.temp").removeClass("alarm-active");
                }
                
                // is temp going up or down
                if(tankTemp > tankLastTemp){
                    $("." + tank + " .tankTempUD").html(UpArrow);
                    $("." + tank + " .tankTempUD").addClass("tempUp");
                }
                else if(tankTemp < tankLastTemp){
                    $("." + tank + " .tankTempUD").html(DnArrow);
                    $("." + tank + " .tankTempUD").addClass("tempDown");
                }
                else {
                    $("." + tank + " .tankTempUD").html("&ndash;");
                }
                    
                
			}); // $.each( tankList, function( key, value ) {
           
           setTimeout(loadTanks, 5000);
           $(".error").text("");
        }
	}, function(errorMsg){
		$(".error").text(errorMsg);
        errorCount ++;
        if(errorCount < 5){
           setTimeout(loadTanks, 5000);
        }
        else {
            $(".error").text(errorMsg + " To many errors, Please refresh the browser to continue.");
        }

    });
}

// Updates Temperatures every so often
function getTemps()
{
    erpc("GetTankTemps", null, function (result) {
        
        $(".Anodizing .tankTemp").text(result[0]);
        $(".Cleaner740 .tankTemp").text(result[1]);
        $(".SealantMTL .tankTemp").text(result[2]);
        $(".SoakClean .tankTemp").text(result[3]);
        $(".Dye .tankTemp").text(result[4]);
        $(".WarmRinse .tankTemp").text(result[5]);
        
        //setTimeout(getTemps, 1000);
    });
}

/* -----------------------------------------------------
// Timer Functions


*/

/* sets the button text to start and the start button color.
	also sets the time but that is just a visual for the user.
*/
    function SetBtnStart(id){
         $("#" + id ).val("Start");
         $("#" + id ).removeClass("btn-danger");
         $("#" + id ).removeClass("btn-warning");
         $("#" + id ).addClass("btn-primary");

        switch(id) {
            case "SoakTimer":
                $(".soakTime").text("15:00");
            	break;
            case "AnodizeTimer":
                $(".anodizeTime").text("42:00");
                break;
            case "AnodizeTimerII":
                $(".anodizeTimeII").text("42:00");
                break;
            case "SealTimer":
                $(".sealTime").text("12:00");
                break;
        }
    }
    
	// Sets the button text to Stop and sets the button color
    function SetBtnStop(id){
        $("#" + id ).val("Stop");
        $("#" + id ).removeClass("btn-primary");
        $("#" + id ).removeClass("btn-warning");
        $("#" + id ).addClass("btn-danger");
    }
    
// Starts the timer on the Esquilo which is just a global variable that keeps
// the miliseconds from the millis() function. Sends timer id.
function StartTimer(id){
    erpc("StartTimer", id);
    SetBtnStop(id);
}

// Ends the timer, sets time to zero
function EndTimer(id) {
    erpc("EndTimer", id);
    SetBtnStart(id);
}
    
// Creates a click event for the timer buttons
function timerClick(event){
    if($("#" + this.id ).val() == "Start"){
        StartTimer(this.id);   
    }
    else {
        EndTimer(this.id);
    }
}

/* Gets the current millis() from the Esquilo and calculates time.
if on another browers than the one that started the timer is sets the button to Start
and displays the current time.
*/
function getTimer(){
    erpc("GetTimer", null, function(status) {
        if(status.soakTime > 0){
            var id = "SoakTimer";
            var ms = 900000 - (status.soakTime);
            var timer = new Date(ms);
            $(".soakTime").text(padZero(timer.getMinutes()) + ":" + padZero(timer.getSeconds()));

            if($("#" + id ).val() == "Start") {
                SetBtnStop(id);
            }

            if(status.soakTime > 0 && status.soakTime > 120000) {
                $("#" + id ).removeClass("btn-danger");
                $("#" + id ).addClass("btn-warning");

            }
        }
        else {
            if(status.soakTime == 0){
                var id = "SoakTimer";
                if($("#" + id ).val() == "Stop") {
                    SetBtnStart(id);
                }	   
            }
        }
        if(status.anodizeTime > 0){
            var id = "AnodizingTimer";
            var ms = 2520000 - (status.anodizeTime);
            var timer = new Date(ms);
            $(".anodizeTime").text(timer.getMinutes() + ":" + timer.getSeconds());
            if($("#" + id ).val() == "Start") {
                SetBtnStop(id);
            }
        }
        else {
			if(status.anodizeTime == 0){
                var id = "AnodizingTimer";
                if($("#" + id ).val() == "Stop") {
                    SetBtnStart(id);
                }
            }
        }
        if(status.anodizeTimeII > 0){
            var id = "AnodizingTimerII";
            var ms = 2520000 - (status.anodizeTimeII);
            var timer = new Date(ms);
            $(".anodizeTimeII").text(timer.getMinutes() + ":" + timer.getSeconds());
            if($("#" + id ).val() == "Start") {
                SetBtnStop(id);
            }
        }
        else {
			if(status.anodizeTimeII == 0){
                var id = "AnodizingTimerII";
                if($("#" + id ).val() == "Stop") {
                    SetBtnStart(id);
                }
            }
        }
        if(status.sealTime > 0){
            var id = "SealTimer";
            var ms = 720000 - (status.sealTime);
            var timer = new Date(ms);
            $(".sealTime").text(timer.getMinutes() + ":" + timer.getSeconds());
            if($("#" + id ).val() == "Start") {
                SetBtnStop(id);
            }
        }
        else {
             if(status.sealTime == 0){
                 var id = "SealTimer";
                 if($("#" + id ).val() == "Stop") {
                     SetBtnStart(id);
            	 }  
             }

        }


    }, function(errorMsg){
		$(".error").text(errorMsg);
        errorCount ++;
        if(errorCount > 4){
           
        }
        else {
        	setTimeout(loadTanks, 5000);
        }
    });
    
	setTimeout(getTimer, 3000);    
        
}
// End Timer Functions


// Start of Heater Functions

// Creates a click event for heater checkbox
function heaterClick(event){
    var id = this.id;
    id = id.replace("Heater","");
    erpc("HeaterOnOff", { id: id, status: $("#" + this.id ).is(':checked') });
   
}

// Creates a click event for heater checkbox
function allHeaterClick(event){
    erpc("AllHeatersOff");
}




