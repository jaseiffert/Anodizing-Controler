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



