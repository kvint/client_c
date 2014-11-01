/**
 * Created with IntelliJ IDEA.
 * User: kuts
 * Date: 12/6/13
 * Time: 7:30 PM
 * To change this template use File | Settings | File Templates.
 */
package com.scifi.view.screens.managers {

import feathers.controls.ScreenNavigator;
import org.as3commons.logging.api.ILogger;
import org.as3commons.logging.api.getLogger;
import starling.display.DisplayObject;
import starling.events.Event;

public class ScreensManagerImpl extends ScreenNavigator implements ScreensManager{

	private static const log				:ILogger 	= getLogger(ScreensManagerImpl);

	public static const NAME				:String 	= "ScreensManagerImpl";

	public static var instance				:ScreensManagerImpl = new ScreensManagerImpl();

	public static var SCREEN_CHANGED		:String 	= NAME + "ScreenChanged";

	private var _previousActiveScreenID		:String		= null;
	private var _screenID					:String		= null;

	public function ScreensManagerImpl()
	{
		super();
	}

	override public function showScreen(id:String):DisplayObject
	{
		if (activeScreenID == id)
			return activeScreen;

		_previousActiveScreenID = activeScreenID;

		super.clearScreen();

		_screenID = id;

		super.showScreen(id);
		dispatchEvent(new Event(SCREEN_CHANGED));
		return activeScreen;
	}

	public function showPreviousScreen():void
	{
		if (_previousActiveScreenID != null)
			showScreen(_previousActiveScreenID);
	}

	override public function get activeScreenID():String
	{
		return _screenID;
	}

	public function get previousActiveScreenID():String
	{
		return _previousActiveScreenID;
	}
}
}
