/**
 * User: neste
 * Date: 1/15/13
 */
package com.scifi.view.screens.game {

import com.scifi.view.screens.game.overlay.ContentLayerView;
import feathers.controls.LayoutGroup;
import org.as3commons.logging.api.ILogger;
import org.as3commons.logging.api.getLogger;

public class GameView extends LayoutGroup {

	private static const log			:ILogger 				= getLogger(GameView);

	public static const NAME			:String 				= "GameView";

	private var _contentLayer			:ContentLayerView 		= new ContentLayerView();

	override protected function initialize():void
	{
		addChild(contentLayer);
	}

	public function get contentLayer():ContentLayerView
	{
		return _contentLayer;
	}

}
}
