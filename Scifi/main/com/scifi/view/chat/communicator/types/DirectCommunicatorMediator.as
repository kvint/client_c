/**
 * Created by kvint on 02.11.14.
 */
package com.scifi.view.chat.communicator.types
{
import com.chat.events.CommunicatorCommandEvent;
import com.chat.model.communicators.DirectCommunicator;
import com.scifi.view.chat.communicator.ICommunicatorView;

public class DirectCommunicatorMediator extends WritableCommunicatorMediator
{
	[Inject]
	public var view:DirectCommunicatorView;


	override public function initializeComplete():void {
		super.initializeComplete();
		//commandMap["/add"] = AddCMCommand;
	}

	override protected function sendMessage():void {

		dispatch(new CommunicatorCommandEvent(CommunicatorCommandEvent.PRIVATE_MESSAGE, directCommunicatorData, [writableView.messageInput.text]));

		resetInput();
	}

	protected function get directCommunicatorData():DirectCommunicator
	{
		return communicatorData as DirectCommunicator;
	}

	override protected function get communicatorView():ICommunicatorView
	{
		return view;
	}
}
}
