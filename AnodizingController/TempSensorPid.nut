// Required Libraries
require(["UART", "nv", "string"]);
dofile("sd:/LIB/algorithms/Pid/PID.NUT");


//Enable or Disable display of LCD
local lcdEnable = true;

if(lcdEnable){
	dofile("sd:/HighTemperatureSensor/LcdDisplay.nut");
}

dofile("sd:/HighTemperatureSensor/HardwareConfig.nut");
dofile("sd:/HighTemperatureSensor/TempProbe.nut");
//dofile("sd:/HighTemperatureSensor/Tanks.nut");
dofile("sd:/Common/Utilities.nut");

local tankList = {};
listOfTanks <- ["Anodizing", "Cleaner740", "SealantMTL", "SoakClean", "Dye", "Etch", "Chiller"];

tankList = nv.AnodizingTanks;
 


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

GetTankTemps();

/* PID Controller */

pid <- Pid(Kp, Ki, Kd, ControllerDirection);
 
// /* set Output Limits  */
// pid.setOutputLimits(100,100);
//
// /* Set the ControllerDirection to reverse*/
pid.setControllerDirection(pid.REVERSE);


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
