/**
 * Created by kvint on 02.11.14.
 */
package com.scifi.view.chat.communicator.types
{
import feathers.controls.List;
import feathers.controls.TextInput;

public class WritableCommunicatorView extends HistoryCommunicatorView
{
	private var _eventsList:List = new List();
	private var _messageInput:TextInput = new TextInput();

	override protected function initialize():void
	{
		addChild(eventsList);
		addChild(messageInput);
	}

	public function get messageInput():TextInput
	{
		return _messageInput;
	}

	public function get eventsList():List
	{
		return _eventsList;
	}
}
}
