// Required Libraries
require("string");

dofile("sd:/Lib/Buses/OneWire/OneWire.nut");


/* Create a _onewire instance on UART1 */
onewire <- Onewire(1);

for (local rom = onewire.searchRomFirst(); rom != null; rom = onewire.searchRomNext())
{
    print("Found device: ");
    for (local i = 0; i < rom.len(); i++)
        print(format("\\x%02x", rom[i]));
    print("\n");
}
 