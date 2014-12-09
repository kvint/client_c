/**
 * Created by kvint on 01.11.14.
 */
package com.scifi.view.chat.communicator.types.base {
	import com.chat.model.IChatModel;
	import com.chat.model.communicators.ICommunicator;
	import com.scifi.view.chat.communicator.*;

	import robotlegs.extensions.starlingFeathers.impl.FeathersMediator;

	public class DefaultCommunicatorMediator extends FeathersMediator {

		[Inject]
		public var chatModel:IChatModel;


		override public function initializeComplete():void {
			super.initializeComplete();
			communicatorView.provider.subscribe(onViewDataChanged);
		}

		protected function onViewDataChanged():void {

		}
		protected function get communicatorData():ICommunicator {
			return communicatorView.provider.data as ICommunicator;
		}

		protected function get communicatorView():ICommunicatorView {
			return viewComponent as ICommunicatorView;
		}

		override public function destroy():void {
			communicatorView.provider.unsubscribe(onViewDataChanged);
			super.destroy();
		}
	}
}
