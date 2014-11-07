/**
 * User: Neste
 * Date: 06.12.12
 */
package com.scifi.view.screens.game {

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

	override public function initializeComplete():void
	{
		view.layout = new AnchorLayout();

		var chatView:AnchorLayoutData = new AnchorLayoutData();

		chatView.percentWidth = 100;
		chatView.bottom = 0;

		view.chatView.layoutData = chatView;

		setActions();
	}

	private function setActions():void
	{
		var collection:ListCollection = new ListCollection([
			{ label: "A1", triggered: a1 }
		]);

		view.actionsButtons.dataProvider = collection;
	}

	private function a1():void
	{
		var q =1;
	}


}
}
