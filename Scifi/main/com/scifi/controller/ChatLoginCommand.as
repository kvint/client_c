/**
 * Created by kvint on 27.11.14.
 */
package com.scifi.controller {
	import com.chat.controller.IChatController;

	import robotlegs.bender.extensions.commandCenter.api.ICommand;

	public class ChatLoginCommand implements ICommand{

		[Inject]
		public var chatController:IChatController;

		public function execute():void {
			chatController.joinRoom("test", "123");
		}
	}
}
