require("nv");


function createAnodizingTanks(){

    nv.AnodizingTanks <- {
        // Anodizing Config
        Anodizing = {
            Id = 0,
            Name = "Anodizing",
            ShortName = "Anodizing",
            Temp = 0,
            Probe = 0,
            SetTemp = 70,
            MinTemp = 65,
            MaxTemp = 72,
            TempFC = "F"
        },
            // 740 Cleaner Config
            Cleaner740 = {
            Id = 1,
            Name = "740 Cleaner",
            ShortName = "740 Cleaner",
            Temp = 0,
            Probe = 1,
            SetTemp = 140,
            MinTemp = 130,
            MaxTemp = 160,
            TempFC = "F"
        },
            // SealantMTL Config
            SealantMTL = {
            Id = 2,
            Name = "Sealant MTL",
            ShortName = "Sealant MTL",
            Temp = 0,
            Probe = 2,
            SetTemp = 180,
            MinTemp = 180,
            MaxTemp = 190,
            TempFC = "F"
        },
            // SoakClean Config
            SoakClean = {
            Id = 3,
            Name = "Soak Clean",
            ShortName = "Soak Clean",
            Temp = 0,
            Probe = 4,
            SetTemp = 140,
            MinTemp = 135,
            MaxTemp = 150,
            TempFC = "F"
        },
            // Dye Config
            Dye = {
            Id = 4,
            Name = "Dye-Blue",
            ShortName = "Dye-Blue",
            Temp = 0,
            Probe = 3,
            SetTemp = 140,
            MinTemp = 135,
            MaxTemp = 145,
            TempFC = "F"
        },
            // 835 Etch Config
            Etch = {
            Id = 5,
            Name = "Alkaline Etch",
            ShortName = "Etch",
            Temp = 0,
            Probe = 5,
            SetTemp = 140,
            MinTemp = 130,
            MaxTemp = 150,
            TempFC = "F"
        },
            // Chiller Config
            Chill = {
            Id = 6,
            Name = "Chiller",
            ShortName = "Chiller",
            Temp = 0,
            Probe = 6,
            SetTemp = 0,
            MinTemp = 65,
            MaxTemp = 72,
            TempFC = "F"
        },
            // Second Anodizing Tank
            AnodizingII = {
            Id = 7,
            Name = "Anodizing II",
            ShortName = "AnodizingII",
            Temp = 0,
            Probe = 7,
            SetTemp = 70,
            MinTemp = 65,
            MaxTemp = 72,
            TempFC = "F"
        }
        //
    };

    // Save the nv table
    nvsave();
}

function createConfig(){

    nv.pgmConfig <- {
        // Anodizing Config
        Config = {
            
        }   
 	}            
}

function removeNv(nvName){
    delete nv[nvName];
    nvsave();
}

// -----------------------------------------------------------------

createAnodizingTanks();


//removeNv("AnodizingTanks");


print("---------------------------------------\n");
print("AnodizingTanks" in nv);
print("\n---------------------------------------\n");





