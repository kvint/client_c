/**
 * Created with IntelliJ IDEA.
 * User: kuts
 * Date: 10/9/13
 * Time: 4:26 PM
 * To change this template use File | Settings | File Templates.
 */
package com.scifi.view.theme {

import com.scifi.model.logic.Position;

import flash.text.TextFormat;

import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import flash.utils.Dictionary;

import org.as3commons.lang.StringUtils;

public class ThemeStyles
{
	public static const APP_BACKGROUND_COLOR				:uint 				= 0x000000;

	public static const DEFAULT_FONT_NAME					:String 			= "MisoT";

	public static const CUSTOM_FONT_THICKNESS				:uint 				= 250;
	public static const CUSTOM_FONT_SHARPNESS				:uint 				= 50;

	public static const SMALL								:String 			= "small";
	public static const MEDIUM								:String 			= "medium";
	public static const LARGE								:String 			= "large";
	public static const EXTRA								:String 			= "extra";
	public static const DEFAULT								:String 			= "default";

	public static const TEXT_TYPE_PLANE						:uint 				= 0;
	public static const TEXT_TYPE_INTERACTIVE_DEFAULT		:uint 				= 1;
	public static const TEXT_TYPE_INTERACTIVE_HOVERED		:uint 				= 2;
	public static const TEXT_TYPE_INTERACTIVE_DOWN 			:uint 				= 3;
	public static const TEXT_TYPE_INTERACTIVE_SELECTED		:uint 				= 4;
	public static const TEXT_TYPE_INTERACTIVE_DISABLED		:uint 				= 5;
	public static const TEXT_TYPE_MODULE_HEADER 			:uint 				= 6;
	public static const TEXT_TYPE_SCREEN_HEADER 			:uint 				= 7;
	public static const TEXT_TYPE_COORDINATES_INFO 			:uint 				= 8;
	public static const TEXT_TYPE_ENGAGING 					:uint 				= 9;
	public static const TEXT_TYPE_DEBUG 					:uint 				= 10;
	public static const TEXT_TYPE_DEFAULT 					:uint 				= 11;

	private static const TEXT_SIZE							:Dictionary 		= new Dictionary();
	{
		TEXT_SIZE[SMALL] 														= 12;
		TEXT_SIZE[MEDIUM] 														= 14;
		TEXT_SIZE[LARGE] 														= 16;
		TEXT_SIZE[EXTRA] 														= 20;
		TEXT_SIZE[DEFAULT] 														= TEXT_SIZE[SMALL];
	}

	private static const TEXT_COLOR							:Dictionary 		= new Dictionary();
	{
		TEXT_COLOR[TEXT_TYPE_PLANE] 											= 0x829897;
		TEXT_COLOR[TEXT_TYPE_INTERACTIVE_DEFAULT] 								= 0x829897;
		TEXT_COLOR[TEXT_TYPE_INTERACTIVE_HOVERED] 								= 0xFFFFFF;
		TEXT_COLOR[TEXT_TYPE_INTERACTIVE_SELECTED] 								= 0xFFFFFF;
		TEXT_COLOR[TEXT_TYPE_INTERACTIVE_DOWN] 									= 0x000000;
		TEXT_COLOR[TEXT_TYPE_INTERACTIVE_DISABLED] 								= 0x4B5857;
		TEXT_COLOR[TEXT_TYPE_MODULE_HEADER] 									= 0xEB8C80;
		TEXT_COLOR[TEXT_TYPE_SCREEN_HEADER] 									= 0xEB8C80;
		TEXT_COLOR[TEXT_TYPE_COORDINATES_INFO] 									= 0xF9FBDC;
		TEXT_COLOR[TEXT_TYPE_ENGAGING] 											= 0xff4040;
		TEXT_COLOR[TEXT_TYPE_DEBUG] 											= 0x000000;
		TEXT_COLOR[TEXT_TYPE_DEFAULT] 											= TEXT_COLOR[TEXT_TYPE_PLANE];
	}

	private static const LINE_SPACING						:Dictionary 		= new Dictionary();
	{
		LINE_SPACING[SMALL] 													= 0; //12;
		LINE_SPACING[MEDIUM] 													= 0; //16;
		LINE_SPACING[LARGE] 													= 0; //16;
		LINE_SPACING[DEFAULT] 													= LINE_SPACING[MEDIUM];
	}

	public static function getTextFormat(destination:uint = TEXT_TYPE_DEFAULT, sizeType:String = DEFAULT):TextFormat
	{
		var format:TextFormat = new TextFormat(DEFAULT_FONT_NAME);

		format.size = TEXT_SIZE[sizeType];
		format.leading = LINE_SPACING[sizeType];
		format.color = TEXT_COLOR[destination];
		format.align = TextFormatAlign.LEFT;

		return format;
	}

	public static function createTextFormat(sizeType:String = DEFAULT, color:uint = 0xFFFFFF):TextFormat
	{
		var format:TextFormat = new TextFormat(DEFAULT_FONT_NAME);

		format.size = TEXT_SIZE[sizeType];
		format.leading = LINE_SPACING[sizeType];
		format.color = color;

		return format;
	}

	protected static function getFormatId(destination:uint, sizeType:String):String
	{
		return StringUtils.substitute("{0}{1}", destination, sizeType);
	}

	public static function getTextColor(destination:uint = TEXT_TYPE_DEFAULT):uint
	{
		return TEXT_COLOR[destination];
	}

	public static function getTextSize(sizeType:String = DEFAULT):Number
	{
		return TEXT_SIZE[sizeType];
	}

}
}