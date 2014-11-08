/**
 * Created by kvint on 02.11.14.
 */
package com.scifi.view.chat.communicator.types
{
import events.CommunicatorEvent;

import feathers.data.ListCollection;

import model.data.ChatMessage;

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
		historyView.eventsList.itemRendererProperties.labelFunction = function (item:ChatMessage):String
		{
			var str:String = "";
			if (!item.read)
			{
				str += "! "
			}
			str += item.from.node + ": " + item.body;
			return str;
		};
		communicatorData.addEventListener(CommunicatorEvent.ITEM_ADDED, onMessageAdded);
		communicatorData.addEventListener(CommunicatorEvent.ITEM_UPDATED, onMessageUpdated);

		initHistory();
		scrollToEnd();
	}

	protected function initHistory():void
	{
		var history:Array = communicatorData.history.concat();
		for (var i:int = 0; i < history.length; i++)
		{
			var message:ChatMessage = history[i];
			markMessageAsReceived(message);
		}
		historyView.eventsList.dataProvider.data = history;
	}

	protected function scrollToEnd():void
	{
		historyView.eventsList.validate();
		historyView.eventsList.verticalScrollPosition = historyView.eventsList.maxVerticalScrollPosition;
	}

	private function onMessageUpdated(event:CommunicatorEvent):void
	{
		var itemIndex:int = historyView.eventsList.dataProvider.getItemIndex(event.data);
		historyView.eventsList.dataProvider.updateItemAt(itemIndex);
	}

	protected function onMessageAdded(event:CommunicatorEvent):void
	{
		var message:ChatMessage = event.data as ChatMessage;
		markMessageAsReceived(message);
		addToHistory(message);
		scrollToEnd();
	}

	protected function markMessageAsReceived(message:ChatMessage):void
	{
		communicatorData.markAsRead(message);
	}

	protected function addToHistory(message:Message):void
	{
		historyView.eventsList.dataProvider.addItem(message);
	}

	protected function get historyView():HistoryCommunicatorView
	{
		return communicatorView as HistoryCommunicatorView;
	}

	override public function destroy():void
	{
		communicatorData.removeEventListener(CommunicatorEvent.ITEM_ADDED, onMessageAdded);
		communicatorData.removeEventListener(CommunicatorEvent.ITEM_UPDATED, onMessageUpdated);
		super.destroy();
	}
}
}
