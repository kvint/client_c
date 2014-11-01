/**
 * Created by kuts on 12/12/13.
 */
package com.scifi.view.utils {
import flash.utils.getTimer;

import org.as3commons.lang.DateUtils;
import org.as3commons.lang.StringUtils;

public class TimeUtils {

	private static var lastFrame:int = 0;
	private static var currFrame:int;
	private static var dT:Number;
	private static var fR:Number;

	public static function getDeltaTime():Number
	{
		currFrame = getTimer();
		dT = currFrame - lastFrame;
		lastFrame = currFrame;
		return dT;
	}

	public static function getFrameRate():Number
	{
		fR = 1 / dT;
		return fR;
	}

	public static function getMSTime(millisecond:Number):String
	{
		var m:int = millisecond / 1000 / DateUtils.SECONDS_PER_MINUTE;
		var s:int = millisecond / 1000 % DateUtils.SECONDS_PER_MINUTE;

		return StringUtils.substitute("{0}:{1}", normalize(m, 2), normalize(s, 2));
	}

	public static function encodeHMS(millisecond:Number):String
	{
		if (millisecond <= 0)
			return getFormattedTime("--", "--", "--");

		var sec:int = millisecond / 1000 % 60;
		var min:int = millisecond / 1000 / 60 % 60;
		var hor:int = millisecond / 1000 / 60 / 60;

		function getFormattedTime(h:String, m:String, s:String):String
		{
			return StringUtils.substitute("{0}:{1}:{2}", h, m, s);
		}

		return getFormattedTime(normalize(hor, 2), normalize(min, 2), normalize(sec, 2));
	}

	public static function decode(string:String):Number
	{
		var parts:Array = string.split(":");

		var seconds:Number = parts[2];
		var minutes:Number = parts[1];
		var hours:Number = parts[0];

		return seconds + 60 * minutes + 60 * 60 * hours;
	}

	private static function normalize(_int:int, _size:int):String
	{
		var temp:String = String(_int);

		for (var i:int = 1; i < _size; i++) {
			if (_int < Math.pow(10, i)) {
				temp = "0" + temp;
			}
		}
		return temp;
	}

}
}