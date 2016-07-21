// Required Libraries
require(["GPIO", "UART", "string", "system"]);

//Enable or Disable display of LCD
local lcdEnable = false;
// Enable or Disable Logging
logPID <- false;

dofile("sd:/AnodizingController/HardwareConfig.nut");
dofile("sd:/AnodizingController/TempProbe.nut");
dofile("sd:/AnodizingController/Tanks.nut");
dofile("sd:/AnodizingController/PID_Library.nut");
dofile("sd:/AnodizingController/TankTimers.nut");
dofile("sd:/AnodizingController/LogFiles.nut");
dofile("sd:/AnodizingController/HeaterControl.nut");
dofile("sd:/Common/Utilities.nut");

if(lcdEnable){
	dofile("sd:/AnodizingController/LcdDisplay.nut");
}

listOfTanks <- [];

foreach (index, value in AnodizingTanks)
    listOfTanks.append(index);

tankList <- AnodizingTanks;

// Function: GetTankTemps
// Description: Get all the temperatures and put in tank information
// Returns: 
//
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

//
// Web interface ERPC functions
// ---------------------------------------------------------------------------------------    
//
// Function: GetTanks
// Description: Get all the tanks information
// Returns:     array of tanks
//
function GetTanks()
{
    return tankList;
}

// Changes the HeaterEnabled setting in the tankList
function HeaterOnOff(params){
	local heaterId = params.id;
    local status = params.status;
    
    tankList[params.id].HeaterEnabled = params.status;
}

// Turns all heaters off
function AllHeatersOff() {
    print("------------------ All Heaters Off -------------------");
	foreach (tank in tankList){
        if(tank.HeaterId > -1) {
            	tank.HeaterEnabled = false;
        }
    }
}

//
// End of Web interface ERPC functions
// ---------------------------------------------------------------------------------------    



GetTankTemps();
InitalizePID();

// Create a timer instance to call checkSensor()
//sensorTimer <- Timer(GetTankTemps);

// Call checkSensor() evey 5 seconds
//sensorTimer.interval(5 * 1000);


// Initialize the 20x4 serial LCD using UART0
if(lcdEnable){
    lcd<-Lcd(20, 4, UART(0));
    lcd.on();

}
	local startTank = 0;
	local dsplyLines = 4;

// Main Loop
while (true){
        
    // Blink LED to show program is running
   if(ledAlertHigh.ishigh()){
       ledAlertHigh.low();
   }
   else {
      	ledAlertHigh.high();
   }
   
    
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
    
    UpdateTempPID();
    
} // while (true)
