/**
 * Created by kuts on 11/11/14.
 */
package com.scifi.view.chat.tabs.types
{
import com.chat.events.CommunicatorEvent;
import com.chat.model.communicators.RoomCommunicator;

import robotlegs.extensions.starlingFeathers.impl.FeathersMediator;

public class MUCCommunicatorTabMediator extends FeathersMediator
{
	[Inject]
	public var view:MUCCommunicatorTabView;

	override public function initializeComplete():void
	{
		super.initializeComplete();

		view.label = null;

		setName();
		setCount();

		communicator.addEventListener(CommunicatorEvent.UNREAD_UPDATED, communicator_onUnreadUpdate);
	}

	private function communicator_onUnreadUpdate(event:CommunicatorEvent):void
	{
		setCount();
	}

	private function setName():void
	{
		view.nameLabel.text = communicator.name;
	}

	private function setCount():void
	{
		view.countLabel.visible = communicator.unreadCount;
		view.countLabel.text = String(communicator.unreadCount);
	}

	override public function destroy():void
	{
		super.destroy();

		communicator.removeEventListener(CommunicatorEvent.UNREAD_UPDATED, communicator_onUnreadUpdate);
	}

	protected function get communicator():RoomCommunicator
	{
		return view.provider.data as RoomCommunicator;
	}
}
}
