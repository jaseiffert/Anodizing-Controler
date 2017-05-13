///////////////////////////////////////////////////////////////////////////////
// Welcome to the Esquilo boot nut!
//
// The Esquilo boot nut is a squirrel nut that your Esquilo can execute every
// time it boots.  It is stored in a special area of flash inside of the ARM
// processor so it is available even if there is no micro SD card.  You can
// change the boot nut setting either from the Esquilo IDE under the system
// menu or with the "sq boot <true|false> command from an EOS shell.
//
// What you do with the boot nut is up to you.  You can write your entire
// application in the boot.nut or you can use it as a springboard to a nut
// stored elsewhere.
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// Run a nut on the micro SD card
///////////////////////////////////////////////////////////////////////////////
require("system");

delay(5000);

// Wait till the Date is updated with the time server
local t = date();
local today = (t.month +1) + "-" + t.day + "-" + t.year;

while(today == "7-5-2016") {
    delay(1000);
    t = date();
	today = (t.month +1) + "-" + t.day + "-" + t.year;
}
print(today + "\n");

dofile("sd:/AnodizingController/AnodizingController.nut");

