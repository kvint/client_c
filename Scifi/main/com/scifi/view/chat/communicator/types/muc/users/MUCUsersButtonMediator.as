/**
 * Created by kuts on 11/11/14.
 */
package com.scifi.view.chat.communicator.types.muc.users
{
import com.chat.model.communicators.RoomCommunicator;

import feathers.controls.Callout;

import robotlegs.extensions.starlingFeathers.impl.FeathersMediator;

import starling.events.Event;

public class MUCUsersButtonMediator extends FeathersMediator
{
	[Inject]
	public var view:MUCUsersButtonView;

	private var _usersCallout:Callout;

	override public function initializeComplete():void
	{
		super.initializeComplete();

		mapStarlingEvent(view, Event.CHANGE, view_onChange);
	}

	override public function destroy():void
	{
		super.destroy();
	}

	private function view_onChange():void
	{
		if (!communicator)
		{
			view.isSelected = false;
			return;
		}

		if (!view.isSelected)
			return;

		var usersListView:MUCUsersView = new MUCUsersView(communicator);

		_usersCallout = Callout.show(usersListView, view, Callout.DIRECTION_ANY, true);

		mapStarlingEvent(_usersCallout, Event.CLOSE, usersListCallout_onClose);
	}

	private function usersListCallout_onClose():void
	{
		unmapStarlingEvent(_usersCallout, Event.CLOSE, usersListCallout_onClose);

		_usersCallout = null;

		view.isSelected = false;
	}

	protected function get communicator():RoomCommunicator
	{
		return view.provider.data as RoomCommunicator;
	}

}
}
