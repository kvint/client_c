/**
 * Created by kuts on 12/2/14.
 */
package com.scifi.view.chat.conversations
{
import com.chat.IChat;
import com.chat.events.CommunicatorEvent;

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

		setCount();

		mapStarlingEvent(view, Event.CHANGE, view_onChange);

		chat.model.conversations.addEventListener(CommunicatorEvent.UNREAD_UPDATED, communicator_onUnreadUpdate);
	}

	override public function destroy():void
	{
		chat.model.conversations.removeEventListener(CommunicatorEvent.UNREAD_UPDATED, communicator_onUnreadUpdate);

		super.destroy();
	}

	private function communicator_onUnreadUpdate(event:CommunicatorEvent):void
	{
		setCount();
	}

	private function setCount():void
	{
		view.counterView.visible = chat.model.conversations.unreadCount;
		view.counterView.countProvider.data = chat.model.conversations.unreadCount;
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
