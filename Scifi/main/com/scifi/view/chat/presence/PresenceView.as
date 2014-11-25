/**
 * Created by kuts on 11/25/14.
 */
package com.scifi.view.chat.presence
{
import com.chat.utils.providers.IViewDataProvider;
import com.chat.utils.providers.ViewDataProvider;

import feathers.controls.LayoutGroup;
import feathers.skins.IStyleProvider;

import starling.display.Quad;

public class PresenceView extends LayoutGroup
{
	private var _statusProvider:IViewDataProvider = new ViewDataProvider();

	private var _quad:Quad = new Quad(10, 10, 0xFFFFFF);

	override protected function initialize():void
	{
		super.initialize();

		addChild(quad);
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

	public function get quad():Quad
	{
		return _quad;
	}
}
}
