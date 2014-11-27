/**
 * Created by kuts on 11/11/14.
 */
package com.scifi.view.chat.communicator.types.muc.users
{
import com.chat.IChat;
import com.chat.model.ChatUser;
import com.chat.model.communicators.RoomCommunicator;

import feathers.data.ListCollection;

import org.igniterealtime.xiff.events.RoomEvent;
import org.igniterealtime.xiff.events.RosterEvent;

import robotlegs.extensions.starlingFeathers.impl.FeathersMediator;

public class MUCUsersMediator extends FeathersMediator
{
	[Inject]
	public var view:MUCUsersView;

	[Inject]
	public var chat:IChat;

	override public function initializeComplete():void
	{
		view.itemRendererProperties.labelFunction = usersListLabelFunction;
		view.itemRendererProperties.accessoryFunction = createItemControlsView;

		setUsersList();

		addCommunicatorEvents();
		addRosterEventsListeners();
	}

	override public function destroy():void
	{
		super.destroy();

		removeCommunicatorEvents();
		removeRosterEventsListeners();
	}

	private function setUsersList():void
	{
		view.dataProvider = new ListCollection();

		for each(var user:ChatUser in communicator.chatRoom.users.source)
			addUserToList(user);
	}

	private function addUserToList(user:ChatUser):void
	{
		view.dataProvider.addItem(user);
	}

	protected function addRosterEventsListeners():void
	{
		chat.model.roster.addEventListener(RosterEvent.ROSTER_LOADED, roster_handleEvent);
		chat.model.roster.addEventListener(RosterEvent.USER_ADDED, roster_handleEvent);
		chat.model.roster.addEventListener(RosterEvent.USER_REMOVED, roster_handleEvent);
		chat.model.roster.addEventListener(RosterEvent.USER_SUBSCRIPTION_UPDATED, roster_handleEvent);
		chat.model.roster.addEventListener(RosterEvent.SUBSCRIPTION_REVOCATION, roster_handleEvent);
	}

	protected function removeRosterEventsListeners():void
	{
		chat.model.roster.removeEventListener(RosterEvent.ROSTER_LOADED, roster_handleEvent);
		chat.model.roster.removeEventListener(RosterEvent.USER_ADDED, roster_handleEvent);
		chat.model.roster.removeEventListener(RosterEvent.USER_REMOVED, roster_handleEvent);
		chat.model.roster.removeEventListener(RosterEvent.USER_SUBSCRIPTION_UPDATED, roster_handleEvent);
		chat.model.roster.removeEventListener(RosterEvent.SUBSCRIPTION_REVOCATION, roster_handleEvent);
	}

	private function addCommunicatorEvents():void
	{
		communicator.chatRoom.addEventListener(RoomEvent.USER_JOIN, communicator_handleEvent);
		communicator.chatRoom.addEventListener(RoomEvent.USER_PRESENCE_CHANGE, communicator_handleEvent);
		communicator.chatRoom.addEventListener(RoomEvent.USER_DEPARTURE, communicator_handleEvent);
	}

	private function removeCommunicatorEvents():void
	{
		communicator.chatRoom.removeEventListener(RoomEvent.USER_JOIN, communicator_handleEvent);
		communicator.chatRoom.removeEventListener(RoomEvent.USER_PRESENCE_CHANGE, communicator_handleEvent);
		communicator.chatRoom.removeEventListener(RoomEvent.USER_DEPARTURE, communicator_handleEvent);
	}

	private function communicator_handleEvent(event:RoomEvent):void
	{
		switch (event.type)
		{
			case RoomEvent.USER_JOIN:
				addUserToList(communicator.chatRoom.getUserByNickname(event.nickname));
				break;
			case RoomEvent.USER_DEPARTURE:

				for (var idx:int = 0; idx < view.dataProvider.length; idx++)
				{
					var user:ChatUser = view.dataProvider.getItemAt(idx) as ChatUser;
					if (user.displayName == event.nickname)
						view.dataProvider.removeItemAt(idx);
				}
				break;
			case RoomEvent.USER_PRESENCE_CHANGE:
				break;
		}
	}

	private function roster_handleEvent(event:RosterEvent):void
	{
		setUsersList();
	}

	private static function createItemControlsView(data:ChatUser):MUCUserActionsView
	{
		return new MUCUserActionsView(data);
	}

	private static function usersListLabelFunction(data:ChatUser):String
	{
		return data.displayName;
	}

	public function get communicator():RoomCommunicator
	{
		return view.communicator as RoomCommunicator;
	}

}
}
