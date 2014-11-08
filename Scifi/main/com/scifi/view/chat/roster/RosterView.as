/**
 * Created by AlexanderSla on 03.11.2014.
 */
package com.scifi.view.chat.roster
{
import feathers.controls.LayoutGroup;
import feathers.controls.List;
import feathers.skins.IStyleProvider;

public class RosterView extends LayoutGroup
{
	private var _list:List = new List();

	public static var globalStyleProvider:IStyleProvider;

	override protected function get defaultStyleProvider():IStyleProvider
	{
	    return globalStyleProvider;
	}

	override protected function initialize():void
	{
		addChild(list);
	}

	public function get list():List
	{
		return _list;
	}
}
}
