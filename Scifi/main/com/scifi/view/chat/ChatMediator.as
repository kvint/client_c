/**
 * Created by kvint on 01.11.14.
 */
package com.scifi.view.chat
{
import com.chat.IChat;
import com.chat.model.communicators.CommunicatorType;
import com.chat.model.communicators.ICommunicator;
import com.scifi.view.chat.communicator.types.direct.DirectCommunicatorView;
import com.scifi.view.chat.communicator.types.muc.MUCCommunicatorView;

import robotlegs.extensions.starlingFeathers.impl.FeathersMediator;

import starling.events.Event;

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

		setCommunicatorView();

		view.tabsView.addEventListener(Event.CHANGE, tabsView_onChange);
	}

	private function tabsView_onChange():void
	{
		setCommunicatorView();
	}

	private function setCommunicatorView():void
	{
		view.containerView.communicatorProvider = view.tabsView.selectedItem as ICommunicator;
		view.containerView.validate();
	}

}
}
