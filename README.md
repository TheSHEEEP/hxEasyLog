[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](license.md) [![Haxelib Version](https://img.shields.io/github/release/thesheeep/hxeasylog.svg?style=flat&label=haxelib)](http://lib.haxe.org/p/hxeasylog)

# easylog

Easy to use logging tool that allows different logging types as well as logging to different files.  

Obviously, logging to files will only work on platforms allowing that to begin with (cpp, neko, php as this is using haxe's own sys.io.File).  
Easylog **does** work on other platforms as well - only file operations are disabled, then.


## How To Use

Using easylog is - you might have guessed - easy.  
All that needs to be done is to create your instance of the Logger (it's **not** a singleton!) and log away.
```
import easylog.EasyLogger;

var myLogger : EasyLogger = new EasyLogger("app_[logType].log");
myLogger.log(EasyLogger.Error, "Uh oh!");
myLogger.log("CustomLogType", "Custom log types are allowed, too!");
```


### Message Layout

Log messages will print the date, the class, function and line they were called at - and of course the message itself.  
The format is the following:
```
[YYYY-MM-DD HH:MM:SS] ClassName.FunctionName:LineNumber - LogType
    Lines of the message
	Preceded by "    " for readability

Example:
[2016-05-13 11:45:33] MyClass.main:36 - Error
    The logged message
    Another line
```


## Logging To Files

EasyLog will log to either one, multiple or no files, depending on how you called the Logger constructor.  
All the file paths/names given to the constructor are considered relative to the working directory.


### Logging To One File

When you log to one file, all the logs, no matter what type, will appear in that file - of course marked with their type to be able to distinguish them. All you need to do for this is giving a simple file name to the constructor.
```
var myLogger : EasyLogger = new EasyLogger("../../logs/MyLog.log");
```


### Logging To Multiple Files

When you log to multiple files, each log type will be written to its own file. To enable this functionality, you must pass a file name to the Logger constructor containing `[logType]`.
```
// This will create log files named MyLog_Error.log, MyLog_Warning.log, etc.
var myLogger : EasyLogger = new EasyLogger("../../logs/MyLog_[logType].log");
```

Note that the full name of the type will be placed in the fill name. Thus, be careful about using spaces and special characters here.


### Logging To No File

If you do not want to log to any files, just pass an empty string to the constructor.
```
// No file will be written to - make sure to enable console output if you want any output at all
var myLogger : EasyLogger = new EasyLogger("");
```


### Override vs. Append

By default, easylog will always append to already existing logs.  
You can prevent that - instead creating a new log file with each application start - by setting:
```
myLogger.append = false;
```
Note that this must be set before the first log is written.


### Console Output

Printing logs to console can be enabled/disabled at any time by:
```
myLogger.consoleOutput = true; // or false
```
By default, console output is disabled.


### Thread Safety

Writing to the same log file from multiple threads is not safe - it might lead to mixed up logs.  
Writing to one log per thread should be safe.  
Writing to the console from multiple threads is not safe - it might lead to mixed up logs.


## License

It is MIT!
So... enjoy ;)
