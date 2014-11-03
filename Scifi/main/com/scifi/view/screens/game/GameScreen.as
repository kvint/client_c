/**
 * Created with IntelliJ IDEA.
 * User: Neste
 * Date: 13.12.12
 * Time: 14:23
 * To change this template use File | Settings | File Templates.
 */

package com.scifi.view.screens.game {

	import feathers.controls.Button;
	import feathers.controls.Screen;

	import org.as3commons.logging.api.ILogger;
	import org.as3commons.logging.api.getLogger;

	import view.ChatView;
	import view.roster.RosterView;

	public class GameScreen extends Screen {
		private static const log:ILogger = getLogger(GameScreen);

		public static const NAME:String = 'LoginScreen';

		private var _chatView:ChatView = ChatService.instance.view;
		private var _rosterView:RosterView = new RosterView();
		private var _btn1:Button = new Button();
		private var _btn2:Button = new Button();
		private var _btn3:Button = new Button();

		override protected function initialize():void {
			btn1.label = "kvinty";
			btn2.label = "external";
			btn3.label = "kvinty2";
			addChild(btn1);
			addChild(btn2);
			addChild(btn3);
			addChild(rosterView);
		}

		public function get chatView():ChatView {
			return _chatView;
		}

		public function get btn1():Button {
			return _btn1;
		}

		public function get btn2():Button {
			return _btn2;
		}

		public function get btn3():Button {
			return _btn3;
		}

		public function get rosterView():RosterView {
			return _rosterView;
		}
	}
}
