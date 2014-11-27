/**
 * Created by kvint on 02.11.14.
 */
package com.scifi.view.chat.communicator {
import com.scifi.utils.providers.IViewDataProvider;

import feathers.core.IFeathersControl;

public interface ICommunicatorView extends IFeathersControl {

		function get provider():IViewDataProvider;

	}
}
