/**
 * Created by kuts on 11/25/14.
 */
package com.scifi.view.chat.user.actions
{
import com.scifi.view.chat.user.presence.PresenceView;

public class FriendUserActionsView extends UserActionsView
{
	private var _presenceView:PresenceView = new PresenceView();

	public function FriendUserActionsView(data:Object)
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
