/**
 * User: neste
 * Date: 1/15/13
 */
package com.scifi.view.screens.game {

	import com.scifi.view.chat.ChatView;
	import com.scifi.view.chat.roster.RosterView;

	import feathers.controls.ButtonGroup;
	import feathers.controls.LayoutGroup;
	import feathers.skins.IStyleProvider;

	import org.as3commons.logging.api.ILogger;
	import org.as3commons.logging.api.getLogger;

	public class GameView extends LayoutGroup {

	private static const log			:ILogger 		= getLogger(GameView);

	private var _chatView				:ChatView 		= new ChatView();
	private var _rosterView				:RosterView 	= new RosterView();

	public static var globalStyleProvider:IStyleProvider;
	private var _actionsButtons:ButtonGroup = new ButtonGroup();

	override protected function get defaultStyleProvider():IStyleProvider
	{
	    return globalStyleProvider;
	}

	override protected function initialize():void
	{
		addChild(chatView);
		addChild(actionsButtons);
		addChild(rosterView);
	}

	public function get rosterView():RosterView {
		return _rosterView;
	}

	public function get chatView():ChatView
	{
		return _chatView;
	}

		public function get actionsButtons():ButtonGroup {
			return _actionsButtons;
		}
	}
}
