/**
 * Created by mikhailkuts on 22.04.14.
 */
package com.scifi.view.screens.managers.data {

import com.scifi.view.ui.components.popup.components.Window;
import com.scifi.view.ui.states.window.IWindowState;
import starling.display.DisplayObject;

public class ScreenWindowData {

	private var _window		:Window 		= null;
	private var _overlay	:DisplayObject 	= null;
	private var _state		:IWindowState 	= null;

	public function ScreenWindowData(window:Window = null, overlay:DisplayObject = null)
	{
		_window = window;
		_overlay = overlay;
	}

	public function get overlay():DisplayObject
	{
		return _overlay;
	}

	public function set overlay(value:DisplayObject):void
	{
		_overlay = value;
	}

	public function get window():Window
	{
		return _window;
	}

	public function set window(value:Window):void
	{
		_window = value;
	}

	public function get state():IWindowState
	{
		return _state;
	}

	public function set state(value:IWindowState):void
	{
		_state = value;
	}
}
}
