
// Open a log file on the micro SD
const PID_LOG_FILE = "sd:/AnodizingController/PidLog.log";
//const SYS_LOG_FILE = "sd:/AnodizingController/SysLog.log";

try {
   // If the file already exists, open for append
    pidLogFile <- file(PID_LOG_FILE, "r+");
    pidLogFile.seek(0, 'e');
} catch (error) {
    // if it doesn't exist, create and open for write
    pidLogFile <- file(PID_LOG_FILE, "w+");
}
