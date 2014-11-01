/**
 * Created by mikhailkuts on 21.08.14.
 */
package com.scifi.view.screens.game.overlay {

import com.scifi.model.ModelEvent;
import org.as3commons.logging.api.ILogger;
import org.as3commons.logging.api.getLogger;
import robotlegs.extensions.starlingFeathers.impl.FeathersMediator;

public class BottomBarMediator extends FeathersMediator {

	private static const log	:ILogger = getLogger(BottomBarMediator);

	[Inject]
	public var view				:BottomBarView;

	override public function initializeComplete():void
	{
		addContextListener(ModelEvent.USER_INITIALIZED, user_onInitialized);
	}

	private function user_onInitialized(event:ModelEvent):void
	{
		view.addIm();
	}

}
}
