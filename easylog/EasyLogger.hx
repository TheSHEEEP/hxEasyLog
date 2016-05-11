package easylog;

import haxe.ds.StringMap;

/**
 * The main logger class, not a singleton to allow multiple instances.
 * @type {[type]}
 */
class EasyLogger
{
	public static inline var	Error	   	: String = "Error";
	public static inline var	Warning		: String = "Warning";
	public static inline var	Info		: String = "Info";
	public static inline var	Debug	   	: String = "Debug";
	public static inline var	Verbose	 	: String = "Verbose";

	// If the EasyLogger will append to already existing log files of the same name instead of creating new ones.
	public var append(default, set) : Bool = true;

	// If the EasyLogger will also write logs to the console
	public var consoleOutput(default, set) : Bool = false;

	private var logs	: StringMap<InternalLogger> = null; //< Has all the internal logs that do the actual writing

	/**
	 * Constructor.
	 * @param  {String} p_fileName  The name of the files the logs will be saved to.
	 *							  May be "" for logging only to console.
	 *							  May contain "[logType]" to allow logging to multiple types.
	 * @return {[type]}
	 */
	public function new(p_fileName : String)
	{
		logs = new StringMap<InternalLogger>();

		// TODO: create logs
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

		// TODO: Apply to each InternalLogger

		return consoleOutput;
	}
}
