require("ADC");

// Create an instance for ADC1
adc <- ADC(0);

// Use 16-bit resolution
adc.resolution(16);

 
print("Voltage - Current\r\n");    
for(local i = 0; i < 25; i++){
    
    local volts = adc.read(0)/12.99/100;
    local amps = adc.read(1)/3.7/100;
    
    print(volts + " - " + amps + "\r\n");
    delay(500);
}
 