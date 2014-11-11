/**
 * Created by kvint on 02.11.14.
 */
package com.scifi.view.chat.communicator.types {
import com.adobe.utils.DictionaryUtil;
import com.chat.events.CommunicatorCommandEvent;

import feathers.events.FeathersEventType;

import flash.utils.Dictionary;

import org.as3commons.lang.StringUtils;

public class WritableCommunicatorMediator extends HistoryCommunicatorMediator {

		private static const COMMAND_PATTERN:RegExp = /^\/\w+(\s|$)/ig;
		private static const ARG_DELIMITER:RegExp = /\s+/;

		private var commandsMap:Dictionary = new Dictionary();

		override public function initializeComplete():void {
			super.initializeComplete();

			commandsMap["/trace"] = CommunicatorCommandEvent.TRACE;
			commandsMap["/clear"] = CommunicatorCommandEvent.CLEAR;
			commandsMap["/muc"] = CommunicatorCommandEvent.CREATE_ROOM;
			commandsMap["/join"] = CommunicatorCommandEvent.JOIN_ROOM;
			commandsMap["/help"] = function(...params):CommunicatorCommandEvent {
				return new CommunicatorCommandEvent(CommunicatorCommandEvent.TRACE, communicatorData, DictionaryUtil.getKeys(commandsMap))
			};

			mapStarlingEvent(writableView.messageInput, FeathersEventType.ENTER, messageInput_onEnter);
		}


		private function messageInput_onEnter():void {
			var body:String = StringUtils.trim(writableView.messageInput.text);

			if(!body || body == "")
				return;

			if(proceedCommand(body)){
				resetInput();
				return;
			}
			sendMessage();
		}

		private function proceedCommand(body:String):Boolean {
			var commands:Array = body.match(COMMAND_PATTERN);
			var success:Boolean = false;
			if(commands && commands.length == 1) {
				var commandName:String = StringUtils.trim(commands[0])
				var params:Array = body.split(ARG_DELIMITER);
				params.shift();
				var eventObj:* = commandsMap[commandName];
				if(eventObj){
					success = true;
					if(eventObj is Function){
						dispatch(eventObj(params));
					}else if (eventObj is String){
						dispatch(new CommunicatorCommandEvent(eventObj, communicatorData, params));
					}else{
						success = false;
					}
				}
			}
			return success;
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
