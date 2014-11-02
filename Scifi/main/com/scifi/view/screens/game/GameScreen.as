/**
 * Created with IntelliJ IDEA.
 * User: Neste
 * Date: 13.12.12
 * Time: 14:23
 * To change this template use File | Settings | File Templates.
 */

package com.scifi.view.screens.game
{

import feathers.controls.Button;
import feathers.controls.Screen;
import org.as3commons.logging.api.ILogger;
import org.as3commons.logging.api.getLogger;

	import view.ChatView;

	public class GameScreen extends Screen
{
	private static const log		:ILogger 		= getLogger(GameScreen);

	public static const NAME		:String 		= 'LoginScreen';

	private var _chatView			:ChatView 		= ChatService.instance.view

	override protected function initialize():void
	{
		addChild(chatView);
	}

		public function get chatView():ChatView {
			return _chatView;
		}
	}
}
