/**
 * Created by kvint on 01.11.14.
 */
package com.scifi.view.chat
{
import com.chat.IChat;
import com.chat.events.ChatModelEvent;
import com.chat.model.communicators.CommunicatorType;
import com.chat.model.communicators.ICommunicator;
import com.scifi.view.chat.communicator.types.direct.DirectCommunicatorView;
import com.scifi.view.chat.communicator.types.muc.MUCCommunicatorView;

import robotlegs.extensions.starlingFeathers.impl.FeathersMediator;

public class ChatMediator extends FeathersMediator
{

	[Inject]
	public var view		:ChatView;

	[Inject]
	public var chat		:IChat;

	override public function initializeComplete():void
	{
		view.containerView.communicatorFactory.setViewClass(DirectCommunicatorView, CommunicatorType.DIRECT);
		view.containerView.communicatorFactory.setViewClass(MUCCommunicatorView, CommunicatorType.MUC);

		chat.model.addEventListener(ChatModelEvent.COMMUNICATOR_ACTIVATED, model_onCommunicatorActivated)
	}

	private function model_onCommunicatorActivated(event:ChatModelEvent):void
	{
		view.containerView.communicatorProvider = event.data as ICommunicator;
	}

	override public function destroy():void
	{
		super.destroy();

		chat.model.removeEventListener(ChatModelEvent.COMMUNICATOR_ACTIVATED, model_onCommunicatorActivated)
	}
}
}
