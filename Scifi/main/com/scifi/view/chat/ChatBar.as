/**
 * Created by kuts on 12/2/14.
 */
package com.scifi.view.chat
{
import com.scifi.view.chat.conversations.ConversationsBar;
import com.scifi.view.chat.roster.RosterBar;

import feathers.controls.LayoutGroup;
import feathers.skins.IStyleProvider;

public class ChatBar extends LayoutGroup
{
	private var _rosterBar:RosterBar = new RosterBar();
	private var _conversationsBar:ConversationsBar = new ConversationsBar();

	public static var globalStyleProvider:IStyleProvider;

	override protected function get defaultStyleProvider():IStyleProvider
	{
	    return globalStyleProvider;
	}

	override protected function initialize():void
	{
		super.initialize();

		addChild(rosterBar);
		addChild(conversationsBar);
	}

	public function get conversationsBar():ConversationsBar
	{
		return _conversationsBar;
	}

	public function get rosterBar():RosterBar
	{
		return _rosterBar;
	}
}
}
