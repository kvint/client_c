/**
 * Created by kvint on 02.11.14.
 */
package com.scifi.view.chat.communicator.types.direct
{
	import com.scifi.view.chat.communicator.ICommunicatorView;
	import com.scifi.view.chat.communicator.types.writable.WritableCommunicatorMediator;

	public class DirectCommunicatorMediator extends WritableCommunicatorMediator
{
	[Inject]
	public var view:DirectCommunicatorView;


		override public function initializeComplete():void {
			super.initializeComplete();
			communicatorData.history.fetchNext(3);
		}

		override protected function get communicatorView():ICommunicatorView
	{
		return view;
	}
}
}
