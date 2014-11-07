/**
 * Created by kuts on 9/10/14.
 */
package com.scifi.controller {

import com.scifi.model.ModelEvent;
import com.scifi.view.config.Screens;
import com.scifi.view.screens.game.GameScreen;
import com.scifi.view.screens.managers.ScreensManager;
import com.scifi.view.theme.ChatTheme;

import feathers.controls.ScreenNavigatorItem;

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

	override public function execute():void
	{
		new ChatTheme();

		screens.addScreen(Screens.GAME, new ScreenNavigatorItem(GameScreen));

		eventDispatcher.dispatchEvent(new ModelEvent(ModelEvent.APP_START));
		screens.showScreen(Screens.GAME);
	}

}
}
