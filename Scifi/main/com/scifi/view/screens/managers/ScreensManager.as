/**
 * Created by kuts on 4/23/14.
 */
package com.scifi.view.screens.managers {

import feathers.controls.ScreenNavigatorItem;
import feathers.core.IFeathersEventDispatcher;
import starling.display.DisplayObject;

public interface ScreensManager extends IFeathersEventDispatcher{

	function addScreen(id:String, item:ScreenNavigatorItem)			:void;
	function showScreen(id:String, transition:Function = null)		:DisplayObject;
	function showPreviousScreen()									:void;
	function clearScreen(transition:Function = null)				:void;

	function get activeScreenID()									:String;
	function get previousActiveScreenID()							:String;
	function get activeScreen()										:DisplayObject;

}
}
