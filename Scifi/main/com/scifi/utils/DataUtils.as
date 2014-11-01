/*
 * User: kuts
 * Date: 3/20/13
 */
package com.scifi.utils {

import flash.utils.Dictionary;


public class DataUtils {
	public static function cloneDict(source:Dictionary):Dictionary
	{
		var result:Dictionary = new Dictionary();
		for (var key:Object in source)
			result[key] = source[key];
		return result;
	}

	public static function getVarsByField(source:Object, field:String):Array
	{
		var vars:Array = [];

		if (source is Vector.<*>)
			for each(var item:* in source)
				if (item[field])
					vars.push(item[field]);
				else
					vars.push(null);

		return vars;
	}

}

}
