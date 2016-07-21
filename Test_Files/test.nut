require(["nv"]);
dofile("sd:/Common/Utilities.nut");

local floatValue = 26.309999;


print(Round(floatValue, 2));


delete nv.current;
//delete nv.Zone;
nvsave();