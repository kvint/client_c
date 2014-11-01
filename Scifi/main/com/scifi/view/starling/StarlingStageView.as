/**
 * Created by kuts on 8/21/14.
 */
package com.scifi.view.starling {

import com.scifi.view.screens.game.GameView;
import starling.display.Sprite;

public class StarlingStageView extends Sprite {

	private var _gameView		:GameView 		= new GameView();

	public function init():void
	{
		addChild(gameView);
	}

	public function get gameView():GameView
	{
		return _gameView;
	}
}
}
