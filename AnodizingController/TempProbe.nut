
dofile("sd:/Lib/Buses/OneWire/OneWire.nut");
dofile("sd:/Lib/Sensors/DS18B20/DS18B20.nut");


const TempProbeSN0 = "\x28\xc6\x4a\x2e\x07\x00\x00\x78";
const TempProbeSN1 = "\x28\x3d\xea\x2f\x07\x00\x00\x4e";
const TempProbeSN2 = "\x28\xb7\xb0\x93\x06\x00\x00\x6b";
const TempProbeSN3 = "\x28\x67\x6d\x8d\x06\x00\x00\x30";
const TempProbeSN4 = "\x28\x12\x03\xb5\x07\x00\x00\x0f";
const TempProbeSN5 = "\x28\x8b\x8d\x93\x06\x00\x00\x93";
const TempProbeSN6 = "\x28\x36\xb2\x2d\x07\x00\x00\x1a";
const TempProbeSN7 = "\x28\x46\x9e\x2f\x07\x00\x00\x5c";
const TempProbeSN8 = "";


/* Create a _onewire instance on UART1 */
onewire <- Onewire(1);

// /* Search for the DS18B20 on the bus */
rom <- onewire.searchRomFamily(0x28);
if (!rom)
	throw("DS18B20 not found");

// Create the DS18B20 instance
//ds18b20 <- DS18B20(onewire, rom);

// Saved serial code for DS18B20 sensor 1
tempSensor1 <- blob();
tempSensor1.writestr(TempProbeSN0);

// Saved serial code for DS18B20 sensor 2
tempSensor2 <- blob();
tempSensor2.writestr(TempProbeSN1);

// Saved serial code for DS18B20 sensor 3
tempSensor3 <- blob();
tempSensor3.writestr(TempProbeSN2);

// Saved serial code for DS18B20 sensor 4
tempSensor4 <- blob();
tempSensor4.writestr(TempProbeSN3);

// Saved serial code for DS18B20 sensor 5
tempSensor5 <- blob();
tempSensor5.writestr(TempProbeSN4);

// Saved serial code for DS18B20 sensor 6
tempSensor6 <- blob();
tempSensor6.writestr(TempProbeSN5);

// Saved serial code for DS18B20 sensor 7
tempSensor7 <- blob();
tempSensor7.writestr(TempProbeSN6);


// Saved serial code for DS18B20 sensor 8
tempSensor8 <- blob();
tempSensor8.writestr(TempProbeSN7);

/* Saved serial code for DS18B20 sensor 8
tempSensor9 <- blob();
tempSensor9.writestr(TempProbeSN8);
*/
// Create DS18B20 Probe List
probeList <-[
    DS18B20(onewire, tempSensor1),
	DS18B20(onewire, tempSensor2),
	DS18B20(onewire, tempSensor3),
	DS18B20(onewire, tempSensor4),
	DS18B20(onewire, tempSensor5),
	DS18B20(onewire, tempSensor6),
    DS18B20(onewire, tempSensor7),
    DS18B20(onewire, tempSensor8)
];


// bad const TempProbeSN0 = "\x28\x46\x52\x8e\x06\x00\x00\xd2";
//const TempProbeSN0 = "\x28\x24\xb3\xd7\x06\x00\x00\x23";
// const TempProbeSN1 = "\x28\xe7\xdf\x93\x06\x00\x00\x3b"; bad #2
