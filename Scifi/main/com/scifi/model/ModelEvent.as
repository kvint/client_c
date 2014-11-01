/*
 * User: kuts
 * Date: 4/9/13
 */
package com.scifi.model {

import mx.events.DynamicEvent;

public dynamic class ModelEvent extends DynamicEvent
{
	public static const	NAME								:String	= "ModelEvent";

	public static const APP									:String	= "App";

	public static const APP_INITIALIZE						:String	= APP + "Initialize";
	public static const APP_START							:String	= APP + "Start";

	private var _emitter									:Object;

	public function ModelEvent(type:String, emitter:Object = null, params:Object = null)
	{
		super(type, false, false);

		_emitter = emitter;

		if (params != null)
			for (var key:String in params)
				this[key] = params[key];
	}

}
}
