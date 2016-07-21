// Tank Timers

local timerTbl = {timerSoak = 0, timerAnodize = 0, timerAnodizeII = 0, timerSeal = 0};

function StartTimer(timerId){
    switch (timerId) {
        case "SoakTimer":
        	timerTbl.timerSoak <- millis();
        	break;
        case "AnodizeTimer":
        	timerTbl.timerAnodize <- millis();
        	break;
        case "AnodizeTimerII":
        	timerTbl.timerAnodizeII <- millis();
        	break;
        case "SealTimer":
        	timerTbl.timerSeal <- millis();
        	break;
    }
}

function EndTimer(timerId){
    switch (timerId) {
        case "SoakTimer":
        	timerTbl.timerSoak <- 0;
        	break;
        case "AnodizeTimer":
        	timerTbl.timerAnodize <- 0;
        	break;
        case "AnodizeTimerII":
        	timerTbl.timerAnodizeII <- 0;
        	break;
        case "SealTimer":
        	timerTbl.timerSeal <- 0;
        	break;
    }
}
 
function GetTimer(){
    local soak = 0;
    local anodize = 0;
    local anodizeII = 0;
    local seal = 0;
    
    if(timerTbl.timerSoak > 0){ 
        soak = millis() - timerTbl.timerSoak;
    }
    
    if(timerTbl.timerAnodize > 0){
    	anodize = millis() - timerTbl.timerAnodize;
    }
    
    if(timerTbl.timerAnodizeII > 0){
    	anodizeII = millis() - timerTbl.timerAnodizeII;
    }
    
    if(timerTbl.timerSeal > 0){
    	seal = millis() - timerTbl.timerSeal;
    }
    
   return { soakTime = soak, anodizeTime = anodize, anodizeTimeII = anodizeII, sealTime = seal};
}


