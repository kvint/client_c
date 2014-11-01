/*
 * User: kuts
 * Date: 4/2/13
 */
package com.scifi.utils {
import com.scifi.view.theme.ThemeStyles;

import org.as3commons.lang.StringUtils;

public class HtmlUtils {

	public static function setHtmlFormat(text:String, size:uint = 14, color:uint = 0x000000, bold:Boolean = false):String
	{
		var result:String = org.as3commons.lang.StringUtils.substitute("<font face='{3}' color='#{2}' size='{1}'>{0}</font>", text, size, color.toString(16), ThemeStyles.DEFAULT_FONT_NAME);

		if (bold)
			return org.as3commons.lang.StringUtils.substitute("<b>{0}</b>", result);
		else
			return result;
	}

}
}
