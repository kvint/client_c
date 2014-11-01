/**
 * Created by kuts on 5/7/14.
 */
package com.scifi {

import com.scifi.model.ModelEvent;

import flash.events.Event;
import flash.events.IEventDispatcher;
import robotlegs.bender.framework.impl.Context;

public class GameContext extends Context {

	private static var _instance		:GameContext;

	public function GameContext():void
	{
		super();

		_instance = this;
	}

	public static function get instance():GameContext
	{
		return _instance;
	}

	public function get eventDispatcher():IEventDispatcher
	{
		return injector.getInstance(IEventDispatcher) as IEventDispatcher;
	}

	public function dispatch(event:Event):Boolean
	{
		return eventDispatcher.dispatchEvent(event);
	}

	public function dispatchModelEvent(type:String, emitter:Object = null, data:Object = null):Boolean
	{
		return dispatch(new ModelEvent(type, emitter, data));
	}

}
}
