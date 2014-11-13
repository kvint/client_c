/**
 * Created by kuts on 11/13/14.
 */
package com.scifi.view.chat.roster
{
import com.chat.Chat;

import feathers.controls.Callout;

import robotlegs.extensions.starlingFeathers.impl.FeathersMediator;

import starling.events.Event;

public class RosterButtonMediator extends FeathersMediator
{
	[Inject]
	public var view:RosterButtonView;

	[Inject]
	public var chat:Chat;

	private var _rosterCallout:Callout;

	override public function initializeComplete():void
	{
		super.initializeComplete();

		view.label = "FRIENDS";

		mapStarlingEvent(view, Event.CHANGE, view_onChange);
	}

	override public function destroy():void
	{
		super.destroy();
	}

	private function view_onChange():void
	{
		if (!view.isSelected)
			return;

		var rosterView:RosterView = new RosterView();

		_rosterCallout = Callout.show(rosterView, view, Callout.DIRECTION_ANY, true);

		mapStarlingEvent(_rosterCallout, Event.CLOSE, rosterCallout_onClose);
	}

	private function rosterCallout_onClose():void
	{
		unmapStarlingEvent(_rosterCallout, Event.CLOSE, rosterCallout_onClose);

		_rosterCallout = null;

		view.isSelected = false;
	}
}
}
