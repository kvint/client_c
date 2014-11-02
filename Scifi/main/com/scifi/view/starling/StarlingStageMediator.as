/**
 * Created by kuts on 8/21/14.
 */
package com.scifi.view.starling {

import com.scifi.model.ModelEvent;
import org.as3commons.logging.api.ILogger;
import org.as3commons.logging.api.getLogger;
import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;
import starling.core.Starling;
import starling.events.Event;

public class StarlingStageMediator extends StarlingMediator {

	private static const log	:ILogger 				= getLogger(StarlingStageMediator);

	[Inject]
	public var view				:StarlingStageView;

	override public function initialize():void
	{
		addContextListener(ModelEvent.APP_START, app_onStarted);

		mapStarlingEvent(Starling.current.stage, Event.RESIZE, stage_onResize);

		fitViewToScreen();
	}

	private function fitViewToScreen():void
	{
		view.gameView.width = Starling.current.stage.stageWidth;
		view.gameView.height = Starling.current.stage.stageHeight;
	}

	private function app_onStarted(event:ModelEvent):void
	{
		view.init();

		fitViewToScreen();
	}

	private function stage_onResize(event:Event):void
	{
		fitViewToScreen();
	}

}
}
