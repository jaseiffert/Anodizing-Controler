

// Tank Timers
local timerTbl = {timerSoak = 0, timerAnodize = 0, timerSeal = 0};

function StartTimer(timerId){
    switch (timerId) {
        case "soakTimer":
        	timerTbl.timerSoak <- millis();
        	break;
        case "anodizeTimer":
        	timerTbl.timerAnodize <- millis();
        	break;
        case "sealTimer":
        	timerTbl.timerSeal <- millis();
        	break;
    }
}

function EndTimer(timerId){
    switch (timerId) {
        case "soakTimer":
        	timerTbl.timerSoak <- 0;
        	break;
        case "anodizeTimer":
        	timerTbl.timerAnodize <- 0;
        	break;
        case "sealTimer":
        	timerTbl.timerSeal <- 0;
        	break;
    }
}
 
function GetTimer(){
    local soak = 0;
    local anodize = 0;
    local seal = 0;
    
    if(timerTbl.timerSoak > 0){ 
        soak = millis() - timerTbl.timerSoak;
    }
    
    if(timerTbl.timerAnodize > 0){
    	anodize = millis() - timerTbl.timerAnodize;
    }
    
    if(timerTbl.timerSeal > 0){
    	seal = millis() - timerTbl.timerSeal;
    }
    
   return { soakTime = soak, anodizeTime = anodize, sealTime = seal};
}
 
while(true){
    delay(5000);
    //print((timerTbl.timerSoak - millis()).tostring() + " - " + (timerTbl.timerAnodize - millis()).tostring() + " - " + (timerTbl.timerSeal - millis()).tostring() + "\r\n");
    
}