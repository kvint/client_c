/**
 * User: neste
 * Date: 1/15/13
 */
package com.scifi.view.screens.game {

import feathers.controls.LayoutGroup;
import feathers.skins.IStyleProvider;

import org.as3commons.logging.api.ILogger;
import org.as3commons.logging.api.getLogger;

import view.chat.ChatView;
import view.chat.roster.RosterView;

public class GameView extends LayoutGroup {

	private static const log			:ILogger 		= getLogger(GameView);

	public static const NAME			:String 		= "GameView";

	private var _chatView				:ChatView 		= ChatClient.instance.view;
	private var _rosterView				:RosterView 	= new RosterView();

	public static var globalStyleProvider:IStyleProvider;

	override protected function get defaultStyleProvider():IStyleProvider
	{
	    return globalStyleProvider;
	}

	override protected function initialize():void
	{
		addChild(chatView);
//		addChild(rosterView);
	}

	public function get rosterView():RosterView
	{
		return _rosterView;
	}

	public function get chatView():ChatView
	{
		return _chatView;
	}
}
}
