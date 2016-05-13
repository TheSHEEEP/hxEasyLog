package easylog;

#if (cpp || neko || php)
	import sys.io.File;
	import sys.io.FileOutput;
#end
import haxe.PosInfos;

/**
 * easylog's internal logger class.
 * This is what does the actual writing and printing.
 * @type {[type]}
 */
class InternalLogger
{
	public var consoleOutput	: Bool = false;

	#if (cpp || neko || php)
		private var _file	: FileOutput = null;
	#end
	private var _type	: String = "";

	//------------------------------------------------------------------------------------------------------------------
	/**
	 * Constructor
	 * @param  {String} p_filePath      The path of the file to write to.
	 * @param  {String} p_type      	The type of this logger.
	 * @param  {Bool}   p_append        If the logs should be appended to an already existing file.
	 * @param  {Bool}   p_consoleOutput If the logs should also be written to the output.
	 * @return {[type]}
	 */
	public function new(p_filePath : String, p_type : String, p_append : Bool, p_consoleOutput : Bool)
	{
		consoleOutput = p_consoleOutput;
		_type = p_type;

		// Create the link to the file
		#if (cpp || neko || php)
			if (p_filePath != "")
			{
				_file = p_append ? File.append(p_filePath, false) : File.write(p_filePath, false);
			}
		#end
	}

	//------------------------------------------------------------------------------------------------------------------
	/**
	 * Log the message.
	 * @param  {String}   p_message The message to log.
	 * @param  {PosInfos} p_posInfo Information about the original caller.
	 * @return {Void}
	 */
	public function log(p_message : String, p_posInfo : PosInfos) : Void
	{
		// Create the message "header"
		var fullMessage : String = "[" + Date.now().toString() + "] "
			+ p_posInfo.className + "." + p_posInfo.methodName + ":" + p_posInfo.lineNumber
			+ " - " + _type + "\n";

		// Split the original message into lines, and add some space before each for readability
		var messageLines : Array<String> = p_message.split("\n");
		for (line in messageLines)
		{
			fullMessage += "    " + line + "\n";
		}

		// Log to file
		#if (cpp || neko || php)
			if (_file != null)
			{
				_file.writeString(fullMessage);
				_file.flush();
				_file.flush();
			}
		#end

		// Also log to console
		if (consoleOutput)
		{
			#if (cpp || cs || java || neko || php || python)
				Sys.print(fullMessage);
			#else
				trace(fullMessage);
			#end
		}
	}
}
