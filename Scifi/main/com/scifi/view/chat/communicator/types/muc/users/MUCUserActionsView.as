/**
 * Created by kuts on 11/17/14.
 */
package com.scifi.view.chat.communicator.types.muc.users
{
import com.scifi.view.chat.user.actions.UserActionsView;
import com.scifi.view.chat.user.presence.PresenceView;

public class MUCUserActionsView extends UserActionsView
{
	private var _presenceView:PresenceView = new PresenceView();

	public function MUCUserActionsView(data:Object)
	{
		super(data);
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
}
}
