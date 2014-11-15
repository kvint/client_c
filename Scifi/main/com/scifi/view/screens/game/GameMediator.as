/**
 * User: Neste
 * Date: 06.12.12
 */
package com.scifi.view.screens.game {

import com.chat.Chat;
import com.chat.controller.BaseChatController;

import feathers.controls.Button;
import feathers.data.ListCollection;
import feathers.layout.AnchorLayout;
import feathers.layout.AnchorLayoutData;

import org.as3commons.logging.api.ILogger;
import org.as3commons.logging.api.getLogger;

import robotlegs.extensions.starlingFeathers.impl.FeathersMediator;

import starling.events.Event;

// WARNING! in mediators 2 types of events are intersecting
public class GameMediator extends FeathersMediator {

	private static const log			:ILogger = getLogger(GameMediator);

	public static const NAME			:String = 'GameMediator';

	[Inject]
	public var view						:GameView;

	[Inject]
	public var chat:Chat;

	override public function initializeComplete():void
	{
		setActions();

//		BaseChatController.serverName = "10.0.1.4";
		BaseChatController.serverName = "localhost";
	}

	private function setActions():void
	{
		var collection:ListCollection = new ListCollection([
			{ label: "T1000", triggered: a1 },
			{ label: "bob", triggered: a2, isEnabled:true },
			{ label: "joe", triggered: a3, isEnabled:true },
			{ label: "azik", triggered: a4, isEnabled:true },
			{ label: "history", triggered: a5, isEnabled:false }
		]);

		view.loginButtons.dataProvider = collection;
	}
	private function disableButtons(target:Button):void {
		for (var i:int = 0; i < view.loginButtons.dataProvider.length; i++) {
			var btn:Object = view.loginButtons.dataProvider.getItemAt(i);
			//if(btn.label == target.label) continue;
			btn.isEnabled = false;
			view.loginButtons.dataProvider.updateItemAt(i);
		}
	}

	private function a1(event:Event):void {
		chat.controller.connect("t1000@localhost", "2gret37nidro");
		disableButtons(event.currentTarget as Button);
	}

	private function a2(event:Event):void {
		chat.controller.connect("bob@localhost", "2gret37nidro");
		disableButtons(event.currentTarget as Button);
	}
	private function a3(event:Event):void {
		chat.controller.connect("joe@localhost", "2gret37nidro");
		disableButtons(event.currentTarget as Button);
	}
	private function a4(event:Event):void {
		chat.controller.connect("azik@localhost", "xf3z54dlc");
		disableButtons(event.currentTarget as Button);
	}
	private function a5(event:Event):void {
		chat.controller.test();
	}


}
}
