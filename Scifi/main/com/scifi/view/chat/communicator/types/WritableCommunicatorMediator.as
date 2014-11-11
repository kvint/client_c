/**
 * Created by kvint on 02.11.14.
 */
package com.scifi.view.chat.communicator.types {
	import controller.commands.InfoCMCommand;
	import controller.commands.ICMCommand;
	import controller.commands.TestCMCommand;

	import feathers.events.FeathersEventType;

	import flash.utils.Dictionary;

	import org.as3commons.lang.StringUtils;

	public class WritableCommunicatorMediator extends HistoryCommunicatorMediator {
		private const commandPattern:RegExp = /^\/\w+(\s|$)/ig;
		protected var commandMap:Dictionary = new Dictionary();

		override public function initializeComplete():void {
			super.initializeComplete();
			commandMap["/test"] = TestCMCommand;
			commandMap["/help"] = InfoCMCommand;

			mapStarlingEvent(writableView.messageInput, FeathersEventType.ENTER, messageInput_onEnter);
		}

		private function messageInput_onEnter():void {
			var body:String = StringUtils.trim(writableView.messageInput.text);

			if(!body || body == "")
				return;

			var commands:Array = body.match(commandPattern);

			if(commands && commands.length == 1) {
				var commandName:String = StringUtils.trim(commands[0]);
				var commandClass:Class = commandMap[commandName];
				if(commandClass) {
					var commandInstance:ICMCommand;
					if(commandClass == InfoCMCommand){
						commandInstance = new commandClass(commandMap);
					}else{
						commandInstance = new commandClass();
					}
					var params:Array = body.split(/\s/);
					params.shift(); // remove command name param
					commandInstance.communicator = communicatorData;
					var success:Boolean = commandInstance.exec.apply(communicatorData, params);
					if(success) {
						resetInput();
						return;
					}
				}
			}

			sendMessage();
		}

		protected function sendMessage():void {
		}

		protected function resetInput():void {
			writableView.messageInput.text = "";
			writableView.messageInput.selectRange(0, 0);
		}

		protected function get writableView():WritableCommunicatorView {
			return communicatorView as WritableCommunicatorView;
		}
	}
}
