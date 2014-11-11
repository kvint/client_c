/**
 * Created by kvint on 02.11.14.
 */
package com.scifi.view.chat.communicator.types.writable
{
import com.scifi.view.chat.communicator.types.history.HistoryCommunicatorView;

import feathers.controls.TextInput;
import feathers.skins.IStyleProvider;

public class WritableCommunicatorView extends HistoryCommunicatorView
{
	private var _messageInput:TextInput = new TextInput();

	public static var globalStyleProvider:IStyleProvider;

	override protected function get defaultStyleProvider():IStyleProvider
	{
	    return globalStyleProvider;
	}

	override protected function initialize():void
	{
		super.initialize();
		addChild(messageInput);
	}

	public function get messageInput():TextInput
	{
		return _messageInput;
	}
}
}
