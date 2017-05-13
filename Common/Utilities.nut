require("math");

// Convert Celicus to F
function CtoF(temp, roundOff){
    
    if(temp > 0 && roundOff){
        temp = round(((temp * 9) / 5) + 32,2); 
    }
    else
    {
        if(temp > 0 && !roundOff){
        	temp = ((temp * 9) / 5) + 32; 
        }
            else {
        		temp = 0;
    		}
    } 
    return temp;
}

// Rounds a Float to two decimal places
function Round(val, decimalPoints) {
    local f = pow(10, decimalPoints) * 1.0;
    local newVal = val * f;
    newVal = floor(newVal + 0.5)
    newVal = (newVal * 1.0) / f;
 
   return newVal;
}

// Returns the Date and time
function DateTimeFormat() {
    local t = date();
    return format("%02d-%02d-%04d %02d:%02d:%02d", (t.month + 1), t.day, t.year, t.hour, t.min, t.sec);
}

// Returns the Date
function DateFormat() {
    local t = date();
    return format("%02d_%02d_%04d", (t.month + 1), t.day, t.year);
}

// Returns Date Time format for log
function LogDateTimeFormat() {
    local t = date();
    return format("[%04d-%02d-%02d %02d:%02d:%02d] ", t.year, (t.month + 1), t.day, t.hour, t.min, t.sec);
}

// Returns the Date format for the log file
function FileDateFormat() {
    local t = date();
    return format("%04d_%02d_%02d", t.year, (t.month + 1), t.day);
}


// Prints a line with Carriage Return
function printLn(data) {
	print(data + "\r\n");   
}

