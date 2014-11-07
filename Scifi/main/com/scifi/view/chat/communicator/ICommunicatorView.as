/**
 * Created by kvint on 02.11.14.
 */
package com.scifi.view.chat.communicator {
import feathers.core.IFeathersControl;

import utils.providers.IViewDataProvider;

public interface ICommunicatorView extends IFeathersControl {

		function get provider():IViewDataProvider;

	}
}
