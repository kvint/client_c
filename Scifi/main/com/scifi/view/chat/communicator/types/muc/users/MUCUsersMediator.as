/**
 * Created by kuts on 11/11/14.
 */
package com.scifi.view.chat.communicator.types.muc.users
{
	import com.chat.model.communicators.RoomCommunicator;

	import robotlegs.extensions.starlingFeathers.impl.FeathersMediator;

	public class MUCUsersMediator extends FeathersMediator
{
	[Inject]
	public var view:MUCUsersView;

	override public function initializeComplete():void
	{
		super.initializeComplete();

		view.dataProvider.data = roomCommunicator.chatRoom.room.source;
	}

	public function get roomCommunicator():RoomCommunicator {
		return view.communicator as RoomCommunicator;
	}
	override public function destroy():void
	{
		super.destroy();
	}

}
}
