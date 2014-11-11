/**
 * Created by kvint on 02.11.14.
 */
package com.scifi.view.chat.communicator.types.direct
{
import com.scifi.view.chat.communicator.types.writable.WritableCommunicatorView;

import feathers.skins.IStyleProvider;

public class DirectCommunicatorView extends WritableCommunicatorView
{
	public static var globalStyleProvider:IStyleProvider;

	override protected function get defaultStyleProvider():IStyleProvider
	{
		return globalStyleProvider;
	}
}
}
