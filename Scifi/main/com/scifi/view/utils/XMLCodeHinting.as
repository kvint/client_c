/*

 Copyright (c) 2010 Comment Creative (commentcreative.com)

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.

 Usage:

 XMLCodeHinting.defaultFormat   = 0x000000;
 XMLCodeHinting.commentFormat   = 0x999999;
 XMLCodeHinting.tagFormat       = 0xCC0000;
 XMLCodeHinting.cdataFormat     = 0x00CC00;
 XMLCodeHinting.attributeFormat = 0x0000CC;

 XMLCodeHinting.colorize(xmlTextField);

 */

package com.scifi.view.utils {
import flash.text.*;

public class XMLCodeHinting {

	// defaults if none are given
	private static var textColor:TextFormat = new TextFormat('Courier New', 14, 0x000000);
	private static var commentColor:TextFormat = new TextFormat(null, null, 0x999999);
	private static var tagColor:TextFormat = new TextFormat(null, null, 0xCC0000);
	private static var cdataColor:TextFormat = new TextFormat(null, null, 0x00CC00);
	private static var attColor:TextFormat = new TextFormat(null, null, 0x0000CC);

	// the default regular expressions to use
	private static var tagExp:RegExp = /(<[^<!]).*?>/gs;
	private static var cdataStartExp:RegExp = /<!\[CDATA\[/g;
	private static var cdataEndExp:RegExp = /\]\]>/g;
	private static var quoteExp:RegExp = /[a-z0-9_]*=".*?"|[a-z0-9_]*='.*?'/gi;
	private static var mCommentExp:RegExp = /<!--.*?(-->)/gs;

	// sets the format for normal text in the XML
	public static function set defaultFormat(val:*):void
	{
		if (val is TextFormat) {
			textColor = val as TextFormat;
			return;
		}

		textColor.color = val;
	}

	public static function get defaultFormat():TextFormat
	{
		return textColor;
	}

	// sets the format for comment text in the XML
	public static function set commentFormat(val:*):void
	{
		if (val is TextFormat) {
			commentColor = val as TextFormat;
			return;
		}

		commentColor.color = val;
	}

	public static function get commentFormat():TextFormat
	{
		return commentColor;
	}

	// sets the format for tags in the XML
	public static function set tagFormat(val:*):void
	{
		if (val is TextFormat) {
			tagColor = val as TextFormat;
			return;
		}

		tagColor.color = val;
	}

	public static function get tagFormat():TextFormat
	{
		return tagColor;
	}

	// sets the format for CDATA tags in the XML
	public static function set cdataFormat(val:*):void
	{
		if (val is TextFormat) {
			cdataColor = val as TextFormat;
			return;
		}

		cdataColor.color = val;
	}

	public static function get cdataFormat():TextFormat
	{
		return cdataColor;
	}

	// sets the format for CDATA tags in the XML
	public static function set attributeFormat(val:*):void
	{
		if (val is TextFormat) {
			attColor = val as TextFormat;
			return;
		}

		attColor.color = val;
	}

	public static function get attributeFormat():TextFormat
	{
		return attColor;
	}

	public static function colorize(_txt:TextField):void
	{
		_txt.setTextFormat(textColor);
		var txt:String = _txt.text;
		var match:Object;

		// this colors tags
		match = tagExp.exec(txt);
		while (match != null) {
			_txt.setTextFormat(tagColor, match.index, match.index + match[0].length);
			match = tagExp.exec(txt);
		}

		// this colors CDATA start tags
		match = cdataStartExp.exec(txt);
		while (match != null) {
			_txt.setTextFormat(cdataColor, match.index, match.index + match[0].length);
			match = cdataStartExp.exec(txt);
		}

		// this colors CDATA end tags
		match = cdataEndExp.exec(txt);
		while (match != null) {
			_txt.setTextFormat(cdataColor, match.index, match.index + match[0].length);
			match = cdataEndExp.exec(txt);
		}

		// this colors attributes
		match = quoteExp.exec(txt);
		while (match != null) {
			_txt.setTextFormat(attColor, match.index, match.index + match[0].length);
			match = quoteExp.exec(txt);
		}

		// this colors multi-line comments
		match = mCommentExp.exec(txt);
		while (match != null) {
			_txt.setTextFormat(commentColor, match.index, match.index + match[0].length);
			match = mCommentExp.exec(txt);
		}
	}

}
}