/**
 * User: neste
 * Date: 1/15/13
 */
package com.scifi.view.screens.game
{

	import com.scifi.view.chat.ChatView;
	import com.scifi.view.chat.roster.RosterButtonView;

	import feathers.controls.Button;
	import feathers.controls.ButtonGroup;
	import feathers.controls.LayoutGroup;
	import feathers.controls.TextInput;
	import feathers.skins.IStyleProvider;

	import org.as3commons.logging.api.ILogger;
	import org.as3commons.logging.api.getLogger;

	public class GameView extends LayoutGroup
{
	private static const log:ILogger = getLogger(GameView);

	private var _chatView:ChatView = new ChatView();
	private var _rosterView:RosterButtonView = new RosterButtonView();
	private var _userInput:TextInput = new TextInput();
	private var _passwordInput:TextInput = new TextInput();
	private var _enterButton:Button = new Button();

	public static var globalStyleProvider:IStyleProvider;
	private var _loginButtons:ButtonGroup = new ButtonGroup();

	override protected function get defaultStyleProvider():IStyleProvider
	{
		return globalStyleProvider;
	}

	override protected function initialize():void
	{
		passwordInput.displayAsPassword = true;
//		addChild(userInput);
//		addChild(passwordInput);
//		addChild(enterButton);
		addChild(loginButtons);
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

	public function get userInput():TextInput {
		return _userInput;
	}

	public function get passwordInput():TextInput {
		return _passwordInput;
	}

	public function get enterButton():Button {
		return _enterButton;
	}
}
}
