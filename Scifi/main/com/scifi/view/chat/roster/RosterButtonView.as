/**
 * Created by kuts on 11/13/14.
 */
package com.scifi.view.chat.roster
{
import com.chat.utils.providers.IViewDataProvider;
import com.chat.utils.providers.ViewDataProvider;

import feathers.controls.ToggleButton;

public class RosterButtonView extends ToggleButton
{
	private var _provider:IViewDataProvider = new ViewDataProvider();

	public function get provider():IViewDataProvider
	{
		return _provider;
	}
}
}
