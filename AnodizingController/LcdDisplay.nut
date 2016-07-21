// Remote LCD Demo
//
// See README.md for more information.
//
// This work is released under the Creative Commons Zero (CC0) license.
// See http://creativecommons.org/publicdomain/zero/1.0/

// Required Libraries
require("UART");


dofile("sd:/lib/displays/NHDSerial/NHDSerial.nut");

// LCD Class
//
// Manages a Newhaven serial LCD module controlled with a UART.

class Lcd
{
    // Function:    Class Constructor
    // Description: Create
    // Arguments:   uart - UART object to control the display
    //             
	constructor(columns, rows, uart)
    {
	    _maxColumn = columns - 1;
	    _maxRow = rows - 1;
        _nhd = NHDSerial(uart);
    }

    _nhd = null;
    _onState = false;
    _row = 0;
    _column = 0;
    _maxColumn = 0;
    _maxRow = 0;

    // Function:    on
    // Description: Turns display on
    function on()
    {
        _onState = true;
        _nhd.on();
        delay(1);
    }

    // Function:    off
    // Description: Turns display off
    function off()
    {
        _onState = false;
        _nhd.off();
        delay(1);
    }
    
    // Function:    isOn
    // Description: Query display state
    // Returns:     true
    function isOn()
    {
        return _onState;
    }

    // Function:    clear
    // Description: Clear text from the LCD display
    function clear()
    {
        _row = 0;
        _column = 0;
        _nhd.clear();
        delay(10);
    }

    // Function:    setCursor
    // Description: Sets the cursor position on the display
    // Arguments:   position - The position to move the cursor on the 2-row
    //                         display.
    //                           0x00 - 0x0f: row 1, column 1 - 16
    //                           0x40 - 0x4f: row 2, column 1 - 16
    function setCursor(column, row)
    {
        if (column < 0 || column > _maxColumn || row < 0 || row > _maxRow)
            throw("invalid cursor position");
        
        _column = column;
        _row = row;
        _nhd.setCursor(column, row);
        delay(1);
    }

    // Function:    setContrast
    // Description: Sets the display contrast
    // Arguments:   level - The contrast level to set the display to (0 - 50)
    function setContrast(level)
    {
        if (level < 0 || level > 50)
            throw("invalid contrast");

        _nhd.setContrast(level);
        delay(1);
    }

    // Function:    print
    // Description: Prints a string to the display, starting at the current
    //              cursor position.
    // Arguments:   s - The string to print
    function print(s)
    {
        for (local i = 0; i < s.len(); i++) {
            local c = s[i].tochar();
            if ((c == "\n" || _column > _maxColumn) && _row < _maxRow ) {
                _row++;
                _column = 0;
                _nhd.setCursor(_column, _row);
            }
            if (c != "\n") {
            	_nhd.write(c);
            	_column++;
            }
        }
    }
}

