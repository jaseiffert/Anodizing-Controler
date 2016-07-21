
// Initalize Buttons
btnDown <- GPIO(3); 
btnUp <- GPIO(5);

// Configure pins as a digital input
btnDown.input();
btnUp.input();

// Initalize LED's
ledAlertHigh <- GPIO(2);
ledAlertLow <- GPIO(4);

// Configure pins as a digital output
ledAlertHigh.output();
ledAlertLow.output();

// Initalize SSR Controllers
    heater1 <- GPIO(6);
    heater2 <- GPIO(7);
    heater3 <- GPIO(8);
    heater4 <- GPIO(9);
    heater5 <- GPIO(10);
    heater6 <- GPIO(11);


    // Set as Output pins
    heater1.output();
    heater2.output();
    heater3.output();
    heater4.output();
    heater5.output();
    heater6.output();


    // set to low to make sure nothing comes on.
    heater1.low();
    heater2.low();
    heater3.low();
    heater4.low();
    heater5.low();
    heater6.low();

    heaterList <- [
        heater1,
    	heater2,
        heater3,
        heater4,
        heater5,
        heater6
    ];
    