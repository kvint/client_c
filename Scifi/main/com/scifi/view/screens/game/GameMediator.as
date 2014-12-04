/**
 * User: Neste
 * Date: 06.12.12
 */
package com.scifi.view.screens.game {

	import com.chat.IChat;
	import com.chat.controller.BaseChatController;

	import feathers.data.ListCollection;
	import feathers.events.FeathersEventType;

	import flash.events.IEventDispatcher;

	import org.as3commons.logging.api.ILogger;
	import org.as3commons.logging.api.getLogger;
	import org.igniterealtime.xiff.events.LoginEvent;

	import robotlegs.extensions.starlingFeathers.impl.FeathersMediator;

	import starling.events.Event;

// WARNING! in mediators 2 types of events are intersecting
public class GameMediator extends FeathersMediator {

	private static const log			:ILogger = getLogger(GameMediator);

	public static const NAME			:String = 'GameMediator';

	[Inject]
	public var view						:GameView;

	[Inject]
	public var chat:IChat;

	override public function initializeComplete():void
	{
		view.enterButton.label = "Enter";

		addContextListener(LoginEvent.LOGIN, onLogin);

		mapStarlingEvent(view.enterButton, Event.TRIGGERED, onEnter);
		mapStarlingEvent(view.userInput, FeathersEventType.ENTER, onEnter);
		mapStarlingEvent(view.passwordInput, FeathersEventType.ENTER, onEnter);

		setActions();

//		BaseChatController.serverName = "10.0.1.4";
		BaseChatController.serverName = "localhost";
	}

	private function onLogin(e:LoginEvent):void {
		view.currentUserLabel.text = chat.model.currentUser.displayName;
		view.addChild(view.currentUserLabel);
	}

	private function onEnter():void {
		chat.controller.connect(view.userInput.text, view.passwordInput.text);

//		view.userInput.removeFromParent(true);
//		view.passwordInput.removeFromParent(true);
//		view.enterButton.removeFromParent(true);

//		view.addChild(view.chatView);
//		view.addChild(view.rosterView);
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
	private function initView():void {
		view.loginButtons.removeFromParent();
		view.addChild(view.chatClient);
		view.addChild(view.chatBar);
	}

	private function a1(event:Event):void {
		chat.controller.connect("t1000@localhost", "2gret37nidro");
		initView();
	}

	private function a2(event:Event):void {
		chat.controller.connect("bob@localhost", "2gret37nidro");
		initView();
	}

	private function a3(event:Event):void {
		chat.controller.connect("joe@localhost", "2gret37nidro");
		initView();
	}
	private function a4(event:Event):void {
		chat.controller.connect("azik@localhost", "xf3z54dlc");
		initView();
	}
	private function a5(event:Event):void {
		//chat.controller.test();
	}


}
}
