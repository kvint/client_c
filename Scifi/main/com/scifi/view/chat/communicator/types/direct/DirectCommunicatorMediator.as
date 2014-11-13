/**
 * Created by kvint on 02.11.14.
 */
package com.scifi.view.chat.communicator.types.direct
{
	import com.chat.model.communicators.DirectCommunicator;
	import com.scifi.view.chat.communicator.ICommunicatorView;
	import com.scifi.view.chat.communicator.types.writable.WritableCommunicatorMediator;

	public class DirectCommunicatorMediator extends WritableCommunicatorMediator
{
	[Inject]
	public var view:DirectCommunicatorView;

	override protected function sendMessage():void {

		var result:int = directCommunicatorData.send(writableView.messageInput.text);

		if (result >= 0) {
			resetInput();
		}
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
