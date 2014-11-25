/**
 * Created by kuts on 11/25/14.
 */
package com.scifi.view.chat.user.presence
{
import com.chat.utils.providers.IViewDataProvider;
import com.chat.utils.providers.ViewDataProvider;

import feathers.controls.LayoutGroup;
import feathers.skins.IStyleProvider;

import flash.utils.Dictionary;

import starling.display.Quad;

public class PresenceView extends LayoutGroup
{
	private var _statusProvider:IViewDataProvider = new ViewDataProvider();
	private var _statusQuad:Quad = new Quad(1, 1)
	private var _statusColors:Dictionary;

	override protected function initialize():void
	{
		super.initialize();

		addChild(statusQuad);
	}

	override protected function draw():void
	{
		super.draw();

		statusQuad.width = actualWidth;
		statusQuad.height = actualHeight;
	}

	public function get statusProvider():IViewDataProvider
	{
		return _statusProvider;
	}

	public static var globalStyleProvider:IStyleProvider;

	override protected function get defaultStyleProvider():IStyleProvider
	{
	    return globalStyleProvider;
	}

	public function set statusColors(statusColors:Dictionary):void
	{
		_statusColors = statusColors;
	}

	public function get statusQuad():Quad
	{
		return _statusQuad;
	}

	public function get statusColors():Dictionary
	{
		return _statusColors;
	}
}
}
