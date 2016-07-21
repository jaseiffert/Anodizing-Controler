

// Convert Temperature F to C, C to F
function convert(tempValue, tempFormat, round) {
    newTemp = 0;
    if (tempFormat == "F") {
        newTemp = tempValue * 9 / 5 + 32;
    } 
    else if (tempFormat == "C")	{
        newTemp = (tempValue -32) * 5 / 9;
    } 
    else {
        newTemp = 0;
    }
    
    if(round){
        newTemp = Math.round(newTemp);
    }
    
    return newTemp;
}


// add a 0 to a number < 10 to pad it.
function padZero(n){return n<10 ? '0'+n : n}

// get memory usage from Esquilo
function checkMemory(){
    $(".memory").text = "hello";
     erpc("eosMem", null, function (result) {
        if (result) {
            memory = result;
            $(".memory").text = memory;
        }
     }, function(errorMsg){
		$(".error").text(errorMsg);
        //setTimeout(loadTanks, 3000);
        //setTimeout(checkMemory, 5000);
    });
}

(function(){

    /**
     * Decimal adjustment of a number.
     *
     * @param   {String}    type    The type of adjustment.
     * @param   {Number}    value   The number.
     * @param   {Integer}   exp     The exponent (the 10 logarithm of the adjustment base).
     * @returns {Number}            The adjusted value.
     */
    function decimalAdjust(type, value, exp) {
        // If the exp is undefined or zero...
        if (typeof exp === 'undefined' || +exp === 0) {
            return Math[type](value);
        }
        value = +value;
        exp = +exp;
        // If the value is not a number or the exp is not an integer...
        if (isNaN(value) || !(typeof exp === 'number' && exp % 1 === 0)) {
            return NaN;
        }
        // Shift
        value = value.toString().split('e');
        value = Math[type](+(value[0] + 'e' + (value[1] ? (+value[1] - exp) : -exp)));
        // Shift back
        value = value.toString().split('e');
        return +(value[0] + 'e' + (value[1] ? (+value[1] + exp) : exp));
    }

    // Decimal round
    if (!Math.round10) {
        Math.round10 = function(value, exp) {
            return decimalAdjust('round', value, exp);
        };
    }
    // Decimal floor
    if (!Math.floor10) {
        Math.floor10 = function(value, exp) {
            return decimalAdjust('floor', value, exp);
        };
    }
    // Decimal ceil
    if (!Math.ceil10) {
        Math.ceil10 = function(value, exp) {
            return decimalAdjust('ceil', value, exp);
        };
    }

})();

