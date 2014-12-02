/**
 * Created by kuts on 12/2/14.
 */
package com.scifi.view.chat.conversations
{
import com.chat.IChat;

import feathers.controls.Callout;

import robotlegs.extensions.starlingFeathers.impl.FeathersMediator;

import starling.events.Event;

public class ConversationsBarMediator extends FeathersMediator
{
	[Inject]
	public var view:ConversationsBar;

	[Inject]
	public var chat:IChat;

	private var _conversationsCallout:Callout;

	override public function initializeComplete():void
	{
		super.initializeComplete();

		view.label = "RECENT";

		view.counterView.countProvider.data = 7;

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

		var conversationsView:ConversationsView = new ConversationsView();

		_conversationsCallout = Callout.show(conversationsView, view, Callout.DIRECTION_ANY, true);

		mapStarlingEvent(_conversationsCallout, Event.CLOSE, conversationsCallout_onClose);
	}

	private function conversationsCallout_onClose():void
	{
		unmapStarlingEvent(_conversationsCallout, Event.CLOSE, conversationsCallout_onClose);

		_conversationsCallout = null;

		view.isSelected = false;
	}
}
}
