/**
 * Created by kvint on 02.11.14.
 */
package com.scifi.view.chat.communicator.types
{
import feathers.events.FeathersEventType;

public class WritableCommunicatorMediator extends HistoryCommunicatorMediator
{
	override public function initializeComplete():void
	{
		super.initializeComplete();

		mapStarlingEvent(writableView.messageInput, FeathersEventType.ENTER, messageInput_onEnter);
	}

	private function messageInput_onEnter():void
	{
		sendMessage();
	}

	protected function sendMessage():void
	{
	}

	protected function get writableView():WritableCommunicatorView
	{
		return communicatorView as WritableCommunicatorView;
	}
}
}
