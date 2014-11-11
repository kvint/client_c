/**
 * Created by kvint on 11.11.14.
 */
package com.scifi.view.chat.communicator.types {
	import feathers.skins.IStyleProvider;

	public class MUCCommunicatorView extends WritableCommunicatorView {

		public static var globalStyleProvider:IStyleProvider;

		override protected function get defaultStyleProvider():IStyleProvider
		{
			return globalStyleProvider;
		}
	}
}
