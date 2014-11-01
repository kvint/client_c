/*
 * User: kuts
 * Date: 3/19/13
 */
package com.scifi.utils
{

public class StringUtils
{
	public static function getStringByObjectFields(object:*, fields:Array):String
	{
		var text:String = "";

		for (var index:uint = 0; index < fields.length; index++) {
			text += fields[index] + ": ";
			text += String(object[fields[index]]);
			text += index != fields.length - 1 ? ", " : "";
		}

		return text;
	}

	public static function splitFilePath(fullPath: String):Array
	{
		var fSlash: int = fullPath.lastIndexOf("/");
		var bSlash: int = fullPath.lastIndexOf("\\"); // reason for the double slash is just to escape the slash so it doesn't escape the quote!!!
		var slashIndex: int = fSlash > bSlash ? fSlash : bSlash;
		return [fullPath.substr(0,slashIndex+1), fullPath.substr(slashIndex + 1)];
	}

}
}
