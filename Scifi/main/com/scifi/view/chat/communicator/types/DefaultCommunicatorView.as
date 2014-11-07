/**
 * Created by kvint on 01.11.14.
 */
package com.scifi.view.chat.communicator.types {
import com.scifi.view.chat.communicator.*;
	import feathers.controls.LayoutGroup;

	import utils.providers.IViewDataProvider;
	import utils.providers.ViewDataProvider;

	public class DefaultCommunicatorView extends LayoutGroup implements ICommunicatorView {

		private var _provider:IViewDataProvider = new ViewDataProvider();

		public function get provider():IViewDataProvider {
			return _provider;
		}
	}
}
