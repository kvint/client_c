/**
 * User: neste
 * Date: 1/15/13
 */
package com.scifi.view.screens.game
{

import com.scifi.view.chat.ChatView;
import com.scifi.view.chat.roster.RosterButtonView;
import com.scifi.view.chat.roster.RosterView;

import feathers.controls.ButtonGroup;
import feathers.controls.LayoutGroup;
import feathers.skins.IStyleProvider;

import org.as3commons.logging.api.ILogger;
import org.as3commons.logging.api.getLogger;

public class GameView extends LayoutGroup
{
	private static const log:ILogger = getLogger(GameView);

	private var _chatView:ChatView = new ChatView();
	private var _rosterView:RosterButtonView = new RosterButtonView();

	public static var globalStyleProvider:IStyleProvider;
	private var _loginButtons:ButtonGroup = new ButtonGroup();

	override protected function get defaultStyleProvider():IStyleProvider
	{
		return globalStyleProvider;
	}

	override protected function initialize():void
	{
		addChild(chatView);
		addChild(loginButtons);
		addChild(rosterView);
	}

	public function get rosterView():RosterButtonView
	{
		return _rosterView;
	}

	public function get chatView():ChatView
	{
		return _chatView;
	}

	public function get loginButtons():ButtonGroup
	{
		return _loginButtons;
	}

}
}
