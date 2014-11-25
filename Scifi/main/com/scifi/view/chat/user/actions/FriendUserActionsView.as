/**
 * Created by kuts on 11/25/14.
 */
package com.scifi.view.chat.user.actions
{
import com.scifi.view.chat.user.presence.PresenceView;

public class FriendUserActionsView extends UserActionsView
{
	private var _presenceView:PresenceView = new PresenceView();

	private var _data:Object;

	public function FriendUserActionsView(data:Object)
	{
		_data = data;
	}

	override protected function initialize():void
	{
		super.initialize();

		addChild(presenceView);
	}

	public function get presenceView():PresenceView
	{
		return _presenceView;
	}

	public function get data():Object
	{
		return _data;
	}
}
}
