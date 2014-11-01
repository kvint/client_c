/**
 * Created with IntelliJ IDEA.
 * User: kuts
 * Date: 10/9/13
 * Time: 4:31 PM
 * To change this template use File | Settings | File Templates.
 */
package com.scifi.view.theme {
import feathers.controls.text.TextFieldTextRenderer;
import feathers.system.DeviceCapabilities;

import flash.text.AntiAliasType;

public class ThemeUtils {

	public static function fontEmbeddingWrap(labelProps:Object):void
	{
		labelProps.embedFonts = true;

		if (labelProps is TextFieldTextRenderer)
		{
			labelProps.thickness = ThemeStyles.CUSTOM_FONT_THICKNESS;
			labelProps.sharpness = ThemeStyles.CUSTOM_FONT_SHARPNESS;
			labelProps.antiAliasType = AntiAliasType.ADVANCED;
		}
	}

	public static function get originalDPI():int
	{
		return DeviceCapabilities.dpi;
	}
}
}
