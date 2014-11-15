/**
 * Created by kvint on 02.11.14.
 */
package com.scifi.view.chat.communicator.types.history
{
import com.chat.Chat;
import com.chat.events.CommunicatorEvent;
	import com.chat.model.data.CIString;
	import com.chat.model.data.ICItem;
import com.chat.model.data.MessageItem;
import com.scifi.view.chat.communicator.types.base.DefaultCommunicatorMediator;

import feathers.data.ListCollection;

	import flash.utils.setTimeout;

	import org.as3commons.lang.StringUtils;
	import org.igniterealtime.xiff.data.Message;

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
			/*if (item.body == null)
			{
				return (item as MessageItem).data.toString();
			}
			return item.body.toString();*/
			return createListItem(item);
		};

		initHistory();
		scrollToEnd();

		communicatorData.addEventListener(CommunicatorEvent.REPLACED, onCommunicatorReplaced);
		communicatorData.addEventListener(CommunicatorEvent.ITEM_ADDED, onItemAdded);
		communicatorData.addEventListener(CommunicatorEvent.ITEM_UPDATED, onItemUpdated);
	}

	private function onCommunicatorReplaced(event:CommunicatorEvent):void
	{
		initHistory();
		scrollToEnd();
	}

	protected function initHistory():void
	{
		var history:Vector.<ICItem> = communicatorData.items.concat();
		for (var i:int = 0; i < history.length; i++)
		{
			var item:ICItem = history[i];
			if (item)
			{
				markMessageAsReceived(item);
			}
		}
		historyView.eventsList.dataProvider.data = history;
	}

	protected static function createListItem(item:ICItem):String
	{
		if(item is CIString) return String(item.body);
		if (item is MessageItem) {
			var messageItem:MessageItem = item as MessageItem;
			var message:Message = messageItem.data as Message;
			if (message.body == null) {
				if (message.state != null) {
					return StringUtils.substitute("[{0}] {1}: {2}", item.time, item.from, message.state);
				}
				if (message.receipt != null) {
					return StringUtils.substitute("[{0}] {1}: {2}", item.time, item.from, message.receipt);
				}
			}
		}

		return StringUtils.substitute("{0}[{1}] {2}: {3}", item.isRead? "" : "*", item.time, item.from, item.body);
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
		scrollToEnd();
	}

	protected function markMessageAsReceived(message:ICItem):void
	{
		communicatorData.read(message);
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
