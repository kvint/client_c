/**
 * User: Neste
 * Date: 06.12.12
 */
package com.scifi.view.screens.game {

	import controller.BaseChatController;

	import feathers.data.ListCollection;
import feathers.layout.AnchorLayout;
import feathers.layout.AnchorLayoutData;

import org.as3commons.logging.api.ILogger;
import org.as3commons.logging.api.getLogger;
import robotlegs.extensions.starlingFeathers.impl.FeathersMediator;

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
		view.layout = new AnchorLayout();

		var chatView:AnchorLayoutData = new AnchorLayoutData();

		chatView.percentWidth = 100;
		chatView.bottom = 0;

		view.chatView.layoutData = chatView;

		setActions();

		BaseChatController.serverName = "10.0.1.4";
	}

	private function setActions():void
	{
		var collection:ListCollection = new ListCollection([
			{ label: "external", triggered: a1 },
			{ label: "bob", triggered: a2 },
			{ label: "joe", triggered: a3 },
			{ label: "history", triggered: a4 }
		]);

		view.loginButtons.dataProvider = collection;
	}

	private function a1():void {
		chat.controller.connect("external", "2gret37nidro");
	}
	private function a2():void {
		chat.controller.connect("bob", "2gret37nidro");
	}
	private function a3():void {
		chat.controller.connect("joe", "2gret37nidro");
	}
	private function a4():void {
		chat.controller.test();
	}


}
}
