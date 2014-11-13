/**
 * Created by kuts on 11/11/14.
 */
package com.scifi.view.chat.communicator.types.muc.users
{
import com.chat.model.communicators.RoomCommunicator;

import feathers.data.ListCollection;

import org.igniterealtime.xiff.conference.IRoomOccupant;

import robotlegs.extensions.starlingFeathers.impl.FeathersMediator;

public class MUCUsersMediator extends FeathersMediator
{
	[Inject]
	public var view:MUCUsersView;

	override public function initializeComplete():void
	{
		setUsersList();

		view.dataProvider = new ListCollection();
		view.itemRendererProperties.labelFunction = usersListLabelFunction;

		view.dataProvider = new ListCollection(communicator.chatRoom.room.source);
	}

	private static function usersListLabelFunction(data:Object):String
	{
		return (data as IRoomOccupant).nickname;
	}

	private function setUsersList():void
	{
		for each(var data:IRoomOccupant in communicator.chatRoom.users.source)
			addUserToList(data);
	}

	private function addUserToList(data:IRoomOccupant):void
	{
		view.dataProvider.addItem(data);
	}

	public function get communicator():RoomCommunicator
	{
		return view.communicator as RoomCommunicator;
	}

	override public function destroy():void
	{
		super.destroy();
	}

}
}
