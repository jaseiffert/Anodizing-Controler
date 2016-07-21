dofile("sd:/lib/buses/onewire/onewire.nut");
dofile("sd:/lib/sensors/ds18b20/ds18b20.nut");
dofile("sd:/Common/Utilities.nut");
 
const TempProbeSN0 = "\x28\xc6\x4a\x2e\x07\x00\x00\x78";
const TempProbeSN1 = "\x28\xe7\xdf\x93\x06\x00\x00\x3b";
const TempProbeSN2 = "\x28\xb7\xb0\x93\x06\x00\x00\x6b";
const TempProbeSN3 = "\x28\x67\x6d\x8d\x06\x00\x00\x30";
const TempProbeSN4 = "\x28\xd8\x81\x8d\x06\x00\x00\xe8";
const TempProbeSN5 = "\x28\x8b\x8d\x93\x06\x00\x00\x93";
const TempProbeSN6 = "\x28\x11\x25\xd8\x06\x00\x00\x94";
const TempProbeSN7 = "\x28\x46\x9e\x2f\x07\x00\x00\x5c";
const TempProbeSN8 = "";
const TempProbeSN10 = "\x28\x36\xb2\x2d\x07\x00\x00\x1a";

/* Create a _onewire instance on UART1 */
onewire <- Onewire(1);
//
// /* Search for the DS18B20 on the bus */
rom <- onewire.searchRomFamily(0x28);
if (!rom)
	throw("DS18B20 not found");

// Create the DS18B20 instance
//ds18b20 <- DS18B20(onewire, rom);

// Saved serial code for DS18B20 sensor 1
tempSensor1 <- blob();
tempSensor1.writestr(TempProbeSN2);

// Create DS18B20 Probe List
probe1 <- DS18B20(onewire, tempSensor1);


local now = millis();
print(CtoF(probe1.readT(), false));
local time = now - millis();
print("\r\n" + time + "\r\n");

/*
while(true){
    
    print(CtoF(probe1.readT(), false));
    print("\r\n");
    delay(2000);
        
}
*/
/* Create the DS18B20 instance */
// ds18b20 <- DS18B20(onewire, rom);
//
// /* Read the current temperature (/
// temp <- ds18b20.readT();
// print("temp = " + temp + "\n");


