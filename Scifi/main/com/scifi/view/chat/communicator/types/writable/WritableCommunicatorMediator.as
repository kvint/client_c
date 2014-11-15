/**
 * Created by kvint on 02.11.14.
 */
package com.scifi.view.chat.communicator.types.writable {
	import com.adobe.utils.StringUtil;
	import com.chat.events.CommunicatorCommandEvent;
	import com.chat.model.communicators.WritableCommunicator;
	import com.scifi.view.chat.communicator.types.history.HistoryCommunicatorMediator;

	import feathers.events.FeathersEventType;

	import org.igniterealtime.xiff.data.Message;

	import starling.events.Event;

	import starling.events.KeyboardEvent;

	public class WritableCommunicatorMediator extends HistoryCommunicatorMediator {

		override public function initializeComplete():void {
			super.initializeComplete();

			mapStarlingEvent(writableView.messageInput, FeathersEventType.ENTER, messageInput_onEnter);
			mapStarlingEvent(writableView.messageInput, FeathersEventType.SOFT_KEYBOARD_ACTIVATE, messageInput_onEnter);
			mapStarlingEvent(writableView.messageInput, Event.CHANGE, messageInput_changeHandler);
		}

		private function messageInput_changeHandler():void {
			var body:String = StringUtil.trim(writableView.messageInput.text);
			if(body.length > 0){
				sendMessageState(Message.STATE_COMPOSING);
			}else{
				sendMessageState(Message.STATE_ACTIVE);
			}
		}

		private function sendMessageState(state:String):void {
			dispatch(new CommunicatorCommandEvent(CommunicatorCommandEvent.SEND_MESSAGE_STATE, communicatorData, [state]));
		}


		private function messageInput_onEnter():void {
			sendMessage();
		}

		protected function sendMessage():void {
			var result:int = writableCommunicator.send(writableView.messageInput.text);

			if (result >= 0) {
				resetInput();
			}
		}

		public function get writableCommunicator():WritableCommunicator {
			return communicatorData as WritableCommunicator;
		}

		protected function resetInput():void {
			writableView.messageInput.text = "";
			writableView.messageInput.selectRange(0, 0);
		}

		protected function get writableView():WritableCommunicatorView {
			return communicatorView as WritableCommunicatorView;
		}

		override public function destroy():void {
			//TODO: если пользователь закрыл вкладку, то отправлять Message.STATE_GONE, а Message.STATE_INACTIVE отправлять в случае, если он её просто свернул
			dispatch(new CommunicatorCommandEvent(CommunicatorCommandEvent.SEND_MESSAGE_STATE, communicatorData, [Message.STATE_INACTIVE]));
			super.destroy();
		}
	}
}
