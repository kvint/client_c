/**
 * Created by kuts on 11/11/14.
 */
package com.scifi.view.chat.communicator.types.muc.users
{
import com.chat.utils.providers.IViewDataProvider;
import com.chat.utils.providers.ViewDataProvider;
import com.scifi.view.chat.communicator.ICommunicatorView;

import feathers.controls.ToggleButton;

public class MUCUsersButtonView extends ToggleButton implements ICommunicatorView
{
	private var _provider:IViewDataProvider = new ViewDataProvider();

	public function get provider():IViewDataProvider
	{
		return _provider;
	}

}
}
