package easylog;

import haxe.PosInfos;
import haxe.ds.StringMap;

/**
 * The main logger class, not a singleton to allow multiple instances.
 * @type {[type]}
 */
class EasyLogger
{
	// Some default logging levels
	public static inline var	Error	   	: String = "Error";
	public static inline var	Warning		: String = "Warning";
	public static inline var	Info		: String = "Info";
	public static inline var	Debug	   	: String = "Debug";
	public static inline var	Verbose	 	: String = "Verbose";

	// If the EasyLogger will append to already existing log files of the same name instead of creating new ones.
	public var append(default, set) : Bool = true;

	// If the EasyLogger will also write logs to the console
	public var consoleOutput(default, set) : Bool = false;

	private var _logs			: StringMap<InternalLogger> = null; //< Has all the internal logs that do the actual writing
	private var _logFileString 	: String = "";						//< The string used as the filepath for all logs
	private var _singleLogFile	: Bool = false;						//< If there is only a single log file


	//------------------------------------------------------------------------------------------------------------------
	/**
	 * Constructor.
	 * @param  {String} p_fileName  The name of the files the logs will be saved to.
	 *							  May be "" for logging only to console.
	 *							  May contain "[logType]" to allow logging to multiple types.
	 * @return {[type]}
	 */
	public function new(p_fileName : String)
	{
		_logs = new StringMap<InternalLogger>();

		_logFileString = p_fileName;
		if (_logFileString != "" && _logFileString.indexOf("[logType]") == -1)
		{
			_singleLogFile = true;
		}
	}

	//------------------------------------------------------------------------------------------------------------------
	/**
	 * Logs the passed messages.
	 * @param  {String} p_type    The type/category of the message.
	 * @param  {String} p_message The message to log.
	 * @return {Void}
	 */
	public function log(p_type : String, p_message : String, ?p_posInfo : PosInfos) : Void
	{
		// Make sure there is an internal logger for that type
		if (!_logs.exists(p_type))
		{
			var filePath : String = _logFileString;
			filePath = StringTools.replace(filePath, "[logType]", p_type);

			// If we are in single logfile mode, only the first log inherits the append setting, all others must apped
			if (_singleLogFile)
			{
				if (Lambda.count(_logs) == 0)
				{
					_logs.set(p_type, new InternalLogger(filePath, p_type, append, consoleOutput));
				}
				else
				{
					_logs.set(p_type, new InternalLogger(filePath, p_type, true, consoleOutput));
				}
			}
			else
			{
				_logs.set(p_type, new InternalLogger(filePath, p_type, append, consoleOutput));
			}
		}

		// Log!
		_logs.get(p_type).log(p_message, p_posInfo);
	}

	/**
	 * Append Setter.
	 * @param  {Bool} p_append The new append value.
	 * @return {Bool}
	 */
	public function set_append(p_append : Bool) : Bool
	{
		return append = p_append;
	}

	/**
	 * Append Setter.
	 * @param  {Bool} p_output The new consoleOutput value.
	 * @return {Bool}
	 */
	public function set_consoleOutput(p_output : Bool) : Bool
	{
		consoleOutput = p_output;

		for (logger in _logs)
		{
			logger.consoleOutput = consoleOutput;
		}

		return consoleOutput;
	}
}
