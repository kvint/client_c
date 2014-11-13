/**
 * Created by kvint on 02.11.14.
 */
package com.scifi.view.chat.communicator.types.history
{
	import com.chat.Chat;
	import com.chat.events.CommunicatorEvent;
	import com.chat.model.data.ICItem;
	import com.scifi.view.chat.communicator.types.base.DefaultCommunicatorMediator;

	import feathers.data.ListCollection;

	public class HistoryCommunicatorMediator extends DefaultCommunicatorMediator
{

	[Inject]
	public var chat:Chat;

	override public function initializeComplete():void
	{
		super.initializeComplete();

		historyView.eventsList.dataProvider = new ListCollection();
		historyView.eventsList.isSelectable = false;

		historyView.eventsList.itemRendererProperties.labelFunction = function (item:ICItem):String
		{
			return item.body.toString();
		};

		initHistory();
		scrollToEnd();

		communicatorData.addEventListener(CommunicatorEvent.REPLACED, onCommunicatorReplaced);
		communicatorData.addEventListener(CommunicatorEvent.ITEM_ADDED, onItemAdded);
		communicatorData.addEventListener(CommunicatorEvent.ITEM_UPDATED, onItemUpdated);
	}

	private function onCommunicatorReplaced(event:CommunicatorEvent):void {
		initHistory();
		scrollToEnd();
	}

	protected function initHistory():void
	{
		var history:Vector.<ICItem> = communicatorData.items.concat();
		for (var i:int = 0; i < history.length; i++)
		{
			var item:ICItem = history[i];
			if(item) {
				markMessageAsReceived(item);
			}
		}
		historyView.eventsList.dataProvider.data = history;
	}

	protected function scrollToEnd():void
	{
		historyView.eventsList.validate();
		historyView.eventsList.verticalScrollPosition = historyView.eventsList.maxVerticalScrollPosition;
	}

	private function onItemUpdated(event:CommunicatorEvent):void
	{
		var itemIndex:int = historyView.eventsList.dataProvider.getItemIndex(event.data);
		historyView.eventsList.dataProvider.updateItemAt(itemIndex);
	}

	protected function onItemAdded(event:CommunicatorEvent):void
	{
		markMessageAsReceived(event.data as ICItem);


		/*if(item is ChatMessage){
			var str:String = "";
			if (!item.read)
			{
				str += "! "
			}
			str += item.from.node + ": " + item.body;
			return str;
		}
		return item.toString();*/

		addItemToHistory(event.data as ICItem);
		communicatorData.markAsRead((event.data as ICItem));
		scrollToEnd();
	}

	protected function markMessageAsReceived(message:ICItem):void
	{
		communicatorData.markAsRead(message);
	}

	protected function addItemToHistory(item:ICItem):void
	{
		historyView.eventsList.dataProvider.addItem(item);
	}

	protected function get historyView():HistoryCommunicatorView
	{
		return communicatorView as HistoryCommunicatorView;
	}

	override public function destroy():void
	{
		communicatorData.removeEventListener(CommunicatorEvent.ITEM_ADDED, onItemAdded);
		communicatorData.removeEventListener(CommunicatorEvent.ITEM_UPDATED, onItemUpdated);
		communicatorData.removeEventListener(CommunicatorEvent.REPLACED, onCommunicatorReplaced);
		super.destroy();
	}
}
}
