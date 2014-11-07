/**
 * Created by kvint on 02.11.14.
 */
package com.scifi.view.chat.communicator.types {
	import feathers.controls.TextInput;

import com.scifi.view.chat.communicator.types.HistoryCommunicatorView;

public class WritableCommunicatorView extends HistoryCommunicatorView {

		private var _input:TextInput = new TextInput();

		public function WritableCommunicatorView() {
			super();
		}
		override protected function initialize():void {
			super.initialize();
			addChild(input);
		}

		public function get input():TextInput {
			return _input;
		}
	}
}
