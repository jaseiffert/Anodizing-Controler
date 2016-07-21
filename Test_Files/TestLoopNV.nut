require("nv");


tankList <- nv.AnodizingTanks;

// print(tankList);
local count = 0;
local listOfTanks = array(tankList.len());

foreach(key, value in tankList){
	print("\r\n");
   print("Key: " + key);
    listOfTanks[count] = key;
    
     
    /*      
    foreach(key, value in value){
        
        print("Key: " + key + " - " + "Value: " + value);
        print("\r\n");
        
    }
    */
    print("\r\n");
    print(listOfTanks[count]);
    count++;
}