
// Open a log file on the micro SD
const LOG_FOLDER = "sd:/Logs/";

local pidLogFileName = "PidLog_" + FileDateFormat() + ".log";
local sysLogFileName = "SysLog_" + FileDateFormat() + ".log";

try {
    // If the file already exists, open for append
    pidLogFile <- file(LOG_FOLDER + pidLogFileName, "r+");
    pidLogFile.seek(0, 'e');
} catch (error) {
    // if it doesn't exist, create and open for write
    pidLogFile <- file(LOG_FOLDER + pidLogFileName, "w+");
}

pidLogFile.writestr("Start Loggging PID " + DateTimeFormat() + "\r\n");
pidLogFile.flush();


try {
    // If the file already exists, open for append
    sysLogFile <- file(LOG_FOLDER + sysLogFileName, "r+");
    sysLogFile.seek(0, 'e');
} catch (error) {
    // if it doesn't exist, create and open for write
    sysLogFile <- file(LOG_FOLDER + sysLogFileName, "w+");
}

sysLogFile.writestr("Start Loggging System " + DateTimeFormat() + "\r\n");
sysLogFile.flush();


