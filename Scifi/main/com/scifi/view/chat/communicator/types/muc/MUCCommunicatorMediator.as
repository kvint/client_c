/**
 * Created by kvint on 11.11.14.
 */
package com.scifi.view.chat.communicator.types.muc
{
	import com.chat.model.communicators.RoomCommunicator;
	import com.scifi.view.chat.communicator.ICommunicatorView;
	import com.scifi.view.chat.communicator.types.writable.WritableCommunicatorMediator;

	public class MUCCommunicatorMediator extends WritableCommunicatorMediator
{
	[Inject]
	public var view:MUCCommunicatorView;

	override public function initializeComplete():void
	{
		super.initializeComplete();

		view.usersView.provider.data = roomCommunicatorData;
	}

	protected function get roomCommunicatorData():RoomCommunicator
	{
		return communicatorData as RoomCommunicator;
	}

	override protected function get communicatorView():ICommunicatorView
	{
		return view;
	}

}
}
