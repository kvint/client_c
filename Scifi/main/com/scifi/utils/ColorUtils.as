/**
 * Created by kuts on 3/10/14.
 */
package com.scifi.utils {

public class ColorUtils {

	public static function RGBToCSS(r:int, g:int, b:int):String
	{
		var hex:uint = r << 16 | g << 8 | b;
		return "#" + hex.toString(16).toUpperCase();
	}

	public static function HEXToCSS(hex:uint):String
	{
		return "#" + hex.toString(16).toUpperCase();
	}

}
}
