require("system");

//system("time set 2016-09-10T16:09:30")

// Get the current local date/time
local t = date(time(),'l');

print("Squirrel Time\n");
print("-------------------\n");
// Print the date
print("Date: " + t.year + "-" + (t.month + 1) + "-" + t.day + "\n");

// Print the time
print("Time: " + t.hour + ":" + t.min + ":" + t.sec + "\n");

print("-------------------\n");
print("System Time\n");
print(system("time") + "\n");
