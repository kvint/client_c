/**
 * Created by kuts on 12/2/14.
 */
package com.scifi.view.chat.conversations
{
import feathers.controls.LayoutGroup;
import feathers.controls.List;
import feathers.skins.IStyleProvider;

public class ConversationsView extends LayoutGroup
{
	private var _conversationsList:List = new List();

	public static var globalStyleProvider:IStyleProvider;

	override protected function get defaultStyleProvider():IStyleProvider
	{
	    return globalStyleProvider;
	}

	override protected function initialize():void
	{
		super.initialize();

		addChild(conversationsList);
	}

	public function get conversationsList():List
	{
		return _conversationsList;
	}
}
}
