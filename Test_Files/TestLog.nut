delay(500);
dofile("sd:/lib/sensors/tsl2561/tsl2561.nut");

digitalLightSensor <- TSL2561(I2C(0));
digitalLightSensor.setGain(TSL2561_GAIN_16X);
analogLightSensor <- ADC(0);

// Open a log file on the micro SD
const LUX_LOG_FILE = "sd:/lux.log";
try {
   // If the file already exists, open for append
    luxLogFile <- file(LUX_LOG_FILE, "r+");
    luxLogFile.seek(0, 'e');
} catch (error) {
    // if it doesn't exist, create and open for write
    luxLogFile <- file(LUX_LOG_FILE, "w+");
}

local lastMin = 0;

while (true) {
    // Get readings from both the I2C and analog sensors
    local lux = digitalLightSensor.getLux();
    local lightV = analogLightSensor.readv(0);
    
    // Get the current local date/time
	local t = date();
        
    // Write the sample to the file with format: [<timestamp>] <digital sensor lux>, <analog sensor Voltage>
    local logEntry = format("[%04d-%02d-%02d %02d:%02d:%02d] %0.6f, %0.6f\n",
                                t.year, t.month, t.day, t.hour, t.min, t.sec, lux, lightV);
    //print(logEntry);
    
    luxLogFile.writestr(logEntry);
    
    // Flush to the SD every minute
    if (t.min > lastMin)
        luxLogFile.flush();
    
    lastMin = t.min;
    delay(30000);
}