/**
 * User: Neste
 * Date: 06.12.12
 */
package com.scifi.view.screens.game {

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

	}

}
}
