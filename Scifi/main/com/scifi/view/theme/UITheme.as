/**
 * Created by kuts on 3/11/14.
 */
package com.scifi.view.theme {

import com.scifi.view.screens.game.GameScreen;
import com.scifi.view.screens.game.GameView;
import com.scifi.view.screens.game.overlay.ContentLayerView;

import feathers.layout.AnchorLayout;
import feathers.layout.AnchorLayoutData;

import starling.core.Starling;

	import view.tabs.ChatTabView;

	import view.tabs.ChatTabsView;

	public class UITheme extends ComponentsTheme {

	private static var _instance		:UITheme;

	static public function get instance():UITheme
	{
		return _instance ||= new UITheme();
	}

	override public function init():void
	{
		super.init();

		Starling.current.nativeStage.color = ThemeStyles.APP_BACKGROUND_COLOR;

		root.stage.color = ThemeStyles.APP_BACKGROUND_COLOR;

		setTextures();
		setInitializers();
	}

	override protected function setInitializers():void
	{
		super.setInitializers();

		setInitializerForClass(GameView, gameViewInitializer);
		setInitializerForClass(ContentLayerView, contentLayerViewInitializer);
		setInitializerForClass(GameScreen, gameScreenViewInitializer);

		setInitializerForClass(ChatTabView, chatTabViewInitializer);
	}

	private function gameViewInitializer(view:GameView):void
	{
		view.layout = new AnchorLayout();

		var contentLayer:AnchorLayoutData = new AnchorLayoutData();

		contentLayer.percentWidth = 100;
		contentLayer.percentHeight = 100;

		view.contentLayer.layoutData = contentLayer;
	}

	private function contentLayerViewInitializer(view:ContentLayerView):void
	{
		view.layout = new AnchorLayout();

		var screensManager:AnchorLayoutData = new AnchorLayoutData();

		screensManager.percentWidth = 100;
		screensManager.percentHeight = 100;

		view.screensManager.layoutData = screensManager;
	}

	private function gameScreenViewInitializer(screen:GameScreen):void
	{

	}

	private function chatTabViewInitializer(view:ChatTabView):void
	{
		tabInitializer(view);
	}

}
}
