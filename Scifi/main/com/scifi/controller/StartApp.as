/**
 * Created by kuts on 9/10/14.
 */
package com.scifi.controller {

import com.scifi.model.ModelEvent;
import com.scifi.view.theme.ChatTheme;

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

	override public function execute():void
	{
		eventDispatcher.dispatchEvent(new ModelEvent(ModelEvent.APP_START));
	}

}
}
