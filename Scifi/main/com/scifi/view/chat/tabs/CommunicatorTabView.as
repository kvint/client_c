/**
 * Created by kvint on 02.11.14.
 */
package com.scifi.view.chat.tabs
{
import feathers.controls.ToggleButton;

import utils.providers.IViewDataProvider;
import utils.providers.ViewDataProvider;

public class CommunicatorTabView extends ToggleButton
{

	private var _provider:IViewDataProvider = new ViewDataProvider();

	public function CommunicatorTabView()
	{
		super();
	}

	public function get provider():IViewDataProvider
	{
		return _provider;
	}
}
}
