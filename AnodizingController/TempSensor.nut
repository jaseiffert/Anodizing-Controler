// Required Libraries
require(["GPIO", "UART", "string"]);

//Enable or Disable display of LCD
local lcdEnable = true;

if(lcdEnable){
	dofile("sd:/AnodizingController/LcdDisplay.nut");
}

dofile("sd:/AnodizingController/HardwareConfig.nut");
dofile("sd:/AnodizingController/TempProbe.nut");
//dofile("sd:/AnodizingController/Tanks.nut");
dofile("sd:/Common/Utilities.nut");
dofile("sd:/AnodizingController/TanksConfig.nut");

local tankList = {};
listOfTanks <- ["Anodizing", "Cleaner740", "SealantMTL", "SoakClean", "Dye", "Etch", "Chiller", "AnodizingII"];

tankList = AnodizingTanks;
 
//print(tankList[listOfTanks[0]].tankName);

// Function: GetTanks
// Description: Get all the tanks information
// Returns:     array of tanks
//
function GetTanks()
{
    return tankList;
}

function GetTankTemps()
{
    foreach (tank in tankList){
        if(tank.TempFC == "C") {
            tank.Temp = probeList[tank.Probe].readT();
        }
        else
        {
            tank.Temp = CtoF(probeList[tank.Probe].readT(), false);
        }
    }
}

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


GetTankTemps();

// Initialize the 20x4 serial LCD using UART0
if(lcdEnable){
    lcd<-Lcd(20, 4, UART(0));
    lcd.on();

}
	local startTank = 0;
	local dsplyLines = 4;

//local ledBlink = 0;

while (true){
    
    // Blink LED to show program is running
   if(ledAlertHigh.ishigh()){
       ledAlertHigh.low();
   }
   else
   {
      	ledAlertHigh.high();
   	}
   
    
    GetTankTemps();
    
    if(lcdEnable){
        for(local row = 0; row < 4; row++) {

            lcd.setCursor(0,row);
            lcd.print(tankList[listOfTanks[row + startTank]].ShortName.tostring());
            lcd.setCursor(15,row);
            lcd.print(format("%.2f",tankList[listOfTanks[row + startTank]].Temp));
        } // for(local row = 0; row < 4; row++)


        local count = 0;
        while (count < 1000) {         
            if(btnDown.ishigh()){
                if(startTank < 2){
                    startTank++;
                    lcd.clear();
                    break;
                }
            }

            if(btnUp.ishigh()){
                if(startTank > 0){
                    startTank--;
                    lcd.clear();
                    break;
                }
            }
            delay(2);
            count++;
    	}
    }

	//ledBlink++;

} // while (true){
