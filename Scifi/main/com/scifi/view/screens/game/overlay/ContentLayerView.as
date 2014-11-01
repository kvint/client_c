/**
 * Created by mikhailkuts on 21.08.14.
 */
package com.scifi.view.screens.game.overlay {

import com.scifi.view.screens.managers.ScreensManagerImpl;

import feathers.controls.LayoutGroup;

public class ContentLayerView extends LayoutGroup {

	private var _screensManager		:ScreensManagerImpl	= ScreensManagerImpl.instance;
	private var _topBarView			:TopBarView 		= new TopBarView();
	private var _bottomBarView		:BottomBarView 		= new BottomBarView();

	override protected function initialize():void
	{
		addChild(screensManager);
		addChild(topBarView);
		addChild(bottomBarView);
	}

	public function get topBarView():TopBarView
	{
		return _topBarView;
	}

	public function get bottomBarView():BottomBarView
	{
		return _bottomBarView;
	}

	public function get screensManager():ScreensManagerImpl
	{
		return _screensManager;
	}
}
}
