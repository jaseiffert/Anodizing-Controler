// Contol SSRs for Heaters

local pidTable = { Kp = 1500, Ki = 0.0, Kd = 0.0};
WindowSize <- 6500;
windowStartTime <- 0;

/* Initalize PID settings */
pidHeater1 <- Pid(pidTable.Kp, pidTable.Ki, pidTable.Kd, Pid.DIRECT);
pidHeater2 <- Pid(pidTable.Kp, pidTable.Ki, pidTable.Kd, Pid.DIRECT);
pidHeater3 <- Pid(pidTable.Kp, pidTable.Ki, pidTable.Kd, Pid.DIRECT);
pidHeater4 <- Pid(pidTable.Kp, pidTable.Ki, pidTable.Kd, Pid.DIRECT);
pidHeater5 <- Pid(pidTable.Kp, pidTable.Ki, pidTable.Kd, Pid.DIRECT);
pidHeater6 <- Pid(pidTable.Kp, pidTable.Ki, pidTable.Kd, Pid.DIRECT);


/* set Output Limits  */
pidHeater1.SetOutputLimits(0, WindowSize);
pidHeater2.SetOutputLimits(0, WindowSize);
pidHeater3.SetOutputLimits(0, WindowSize);
pidHeater4.SetOutputLimits(0, WindowSize);
pidHeater5.SetOutputLimits(0, WindowSize);
pidHeater6.SetOutputLimits(0, WindowSize);


// Set Mode
pidHeater1.SetMode(Pid.AUTOMATIC);
pidHeater2.SetMode(Pid.AUTOMATIC);
pidHeater3.SetMode(Pid.AUTOMATIC);
pidHeater4.SetMode(Pid.AUTOMATIC);
pidHeater5.SetMode(Pid.AUTOMATIC);
pidHeater6.SetMode(Pid.AUTOMATIC);


pidHeaterList <- [ pidHeater1, pidHeater2, pidHeater3, pidHeater4, pidHeater5, pidHeater6];


//Initalize PID Info

function InitalizePID() {
    
	foreach (tank in tankList){
        if(tank.HeaterId > -1) {
            	pidHeaterList[tank.HeaterId].Setpoint = tank.SetTemp;
            	pidHeaterList[tank.HeaterId].Input = tank.Temp;
        }
    }
    
    
} // function InitalizePID()
        
function UpdateTempPID() {
    
	foreach (tank in tankList){
        
        local t = date();
        local logEntry = "";
        if(logPID) {
			logEntry += "Time Stamp, Heater Id, Input, Output, Setpoint, now, windowStartTime, diff, Heater On/Off \r\n";
        }
        
        // Get Temperature of tank
        tank.Temp = CtoF(probeList[tank.Probe].readT(), false);
        
        // if a heated tank then run the Pid
        if(tank.HeaterId > -1) {
            if(tank.HeaterEnabled && tank.Temp > 0){
                if(tank.Temp > tank.MaxTemp){
                    logEntry += LogDateTimeFormat();
                	logEntry += tank.Id + ", " + tank.Temp + " degrees, " + tank.HeaterId;
    				heaterList[tank.HeaterId].low();
                    logEntry += ", Turned OFF OverTemp \r\n";
                }
                else {
                
                if(windowStartTime < 1) {
                    windowStartTime <- millis();
                    
                }
            	pidHeaterList[tank.HeaterId].Input = tank.Temp;
                pidHeaterList[tank.HeaterId].Compute();
                
                now <- millis();
                local diff = now - windowStartTime;
                
                if(logPID) {
					logEntry += LogDateTimeFormat();
                	logEntry += tank.HeaterId + ", " + pidHeaterList[tank.HeaterId].Input + " - " + pidHeaterList[tank.HeaterId].Output + ", " + pidHeaterList[tank.HeaterId].Setpoint + ", " + (pidHeaterList[tank.HeaterId].Setpoint - pidHeaterList[tank.HeaterId].Input).tostring() + ", " + now + ", " + windowStartTime + ", " + diff;
                    
                }
    			
                if(now - windowStartTime > WindowSize){ 
                    //time to shift the Relay Window
                    windowStartTime += WindowSize;
                }
                
                if(pidHeaterList[tank.HeaterId].Output > now - windowStartTime){ 
                    heaterList[tank.HeaterId].high();
                    if(logPID) {
                        logEntry += ", ON \r\n";
                    }
                }
                else {
                    heaterList[tank.HeaterId].low();
                    if(logPID) {
                        logEntry += ", OFF \r\n";
                    }
                }
                }
             } // (tank.HeaterEnabled)
            else {
                if(!tank.HeaterEnabled){
					logEntry += LogDateTimeFormat();
                	logEntry += tank.Id + ", " + tank.Temp + " degrees, " + tank.HeaterId;
    				heaterList[tank.HeaterId].low();
                    logEntry += ", Turned OFF \r\n";
                }
            }
            pidLogFile.writestr(logEntry);
        } // if(tank.HeaterId > -1)
    } // foreach (tank in tankList)

    // Flush to the SD 
    pidLogFile.flush();
} // function UpdateTempPID()
        


