/**
 * Created by kvint on 02.11.14.
 */
package com.scifi.view.chat.communicator.types.writable {
	import com.adobe.utils.StringUtil;
	import com.chat.model.communicators.WritableCommunicator;
	import com.scifi.view.chat.communicator.types.history.HistoryCommunicatorMediator;

	import feathers.events.FeathersEventType;

	import flash.utils.setTimeout;

	import org.igniterealtime.xiff.data.Message;

	import starling.events.Event;

	public class WritableCommunicatorMediator extends HistoryCommunicatorMediator {

		override public function initializeComplete():void {
			super.initializeComplete();

			mapStarlingEvent(writableView.messageInput, FeathersEventType.ENTER, messageInput_onEnter);
			mapStarlingEvent(writableView.messageInput, Event.CHANGE, messageInput_changeHandler);
		}

		private function messageInput_changeHandler():void {
			var body:String = StringUtil.trim(writableView.messageInput.text);
			writableCommunicator.state = (body.length > 0) ? Message.STATE_COMPOSING : Message.STATE_ACTIVE;
		}

		private function messageInput_onEnter():void {
			sendMessage();
		}

		protected function sendMessage():void {
			var result:int = writableCommunicator.send(writableView.messageInput.text);

			if (result >= 0 || result == WritableCommunicator.BLANK_BODY) {
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
			writableCommunicator.state = Message.STATE_INACTIVE;
			super.destroy();
		}
	}
}
