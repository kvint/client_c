/**
 * Created by kuts on 9/10/14.
 */
package com.scifi.controller {

import com.scifi.model.ModelEvent;
import com.scifi.view.assets.Assets;
import com.scifi.view.config.Screens;
import com.scifi.view.screens.game.GameScreen;
import com.scifi.view.screens.managers.ScreensManager;
import com.scifi.view.theme.UITheme;

import feathers.controls.ScreenNavigatorItem;
import feathers.core.FocusManager;

import flash.events.IEventDispatcher;

import org.as3commons.logging.api.ILogger;
import org.as3commons.logging.api.getLogger;

import robotlegs.bender.bundles.mvcs.Command;

public class StartApp extends Command {

	private static const log			:ILogger 		= getLogger(StartApp);

	[Inject]
	public var eventDispatcher			:IEventDispatcher;

	[Inject]
	public var event					:ModelEvent;

	[Inject]
	public var screens					:ScreensManager;

	[Inject]
	public var theme					:UITheme;

	override public function execute():void
	{
		FocusManager.isEnabled = false;

		loadAssets();
		setScreens();
	}

	private function loadAssets():void
	{
		Assets.loadAssets(
			[
				"../../../assets/scifi.png",
				"../../../assets/scifi.xml",
			],
			onAssetsLoaded
		);
	}

	protected function setScreens():void
	{
		screens.addScreen(Screens.GAME, 					new ScreenNavigatorItem(GameScreen));
	}

	private function onAssetsLoaded():void
	{
		theme.init();

		eventDispatcher.dispatchEvent(new ModelEvent(ModelEvent.APP_START));

		screens.showScreen(Screens.GAME);
	}

}
}
