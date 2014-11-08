/**
 * Created by kvint on 02.11.14.
 */
package com.scifi.view.chat.communicator.types
{
import com.scifi.view.chat.communicator.ICommunicatorView;

import model.communicators.DirectCommunicator;
import model.data.ChatMessage;

import org.igniterealtime.xiff.data.Message;

public class DirectCommunicatorMediator extends WritableCommunicatorMediator
{
	[Inject]
	public var view:DirectCommunicatorView;

	override protected function sendMessage():void
	{
		var message:ChatMessage = new ChatMessage(directCommunicatorData.participant.escaped);

		message.type = Message.TYPE_CHAT;
		message.from = chatModel.currentUser.jid.escaped;
		message.body = writableView.messageInput.text;

		var iCommunicator:DirectCommunicator = chatModel.provider.getCommunicator(message) as DirectCommunicator;

		iCommunicator.sendMessage(message);

		writableView.messageInput.text = "";
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
