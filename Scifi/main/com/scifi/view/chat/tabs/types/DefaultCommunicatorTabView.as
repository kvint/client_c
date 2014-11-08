/**
 * Created by kuts on 11/8/14.
 */
package com.scifi.view.chat.tabs.types
{
import com.scifi.view.chat.communicator.ICommunicatorView;

import feathers.controls.ToggleButton;
import feathers.skins.IStyleProvider;

import utils.providers.IViewDataProvider;
import utils.providers.ViewDataProvider;

public class DefaultCommunicatorTabView extends ToggleButton implements ICommunicatorView
{
	private var _provider:IViewDataProvider = new ViewDataProvider();

	public static var globalStyleProvider:IStyleProvider;

	override protected function get defaultStyleProvider():IStyleProvider
	{
		return globalStyleProvider;
	}

	public function get provider():IViewDataProvider
	{
		return _provider;
	}

}
}
