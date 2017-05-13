// Write table to SD card
function WriteConfigSD(sdFile, data){

    try {
       // If the file already exists, open for append
        configFile <- file(sdFile, "r+");
        configFile.seek(0, 'e');
    } catch (error) {
        // if it doesn't exist, create and open for write
        configFile <- file(sdFile, "w+");
    }
    
    configFile.writestr(data);
    configFile.flush();
    
}

// Read table to SD card
function ReadConfigSD(){
    
}


local config = {
  id = 1,
  name = "Anodizing",
  minTemp = 25,
  maxTemp = 72
}

WriteConfigSD("sd:/config.txt", config);

