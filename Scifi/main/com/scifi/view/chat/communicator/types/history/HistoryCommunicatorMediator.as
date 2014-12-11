/**
 * Created by kvint on 02.11.14.
 */
package com.scifi.view.chat.communicator.types.history
{
	import com.chat.IChat;
	import com.chat.model.data.citems.CItem;
	import com.chat.model.data.citems.CMessage;
	import com.chat.model.data.citems.ICItem;
	import com.chat.model.data.citems.ICMessage;
	import com.chat.model.data.citems.ICTime;
	import com.scifi.view.chat.communicator.types.base.DefaultCommunicatorMediator;

	import feathers.data.CItemListCollection;
	import feathers.events.CollectionEventType;

	import org.as3commons.lang.StringUtils;
	import org.igniterealtime.xiff.data.Message;

	import starling.events.Event;
	import starling.events.EventDispatcher;

	public class HistoryCommunicatorMediator extends DefaultCommunicatorMediator
{

	[Inject]
	public var chat:IChat;

	override public function initializeComplete():void
	{
		super.initializeComplete();

		var itemListCollection:CItemListCollection = new CItemListCollection(communicatorData.items);
		historyView.eventsList.dataProvider = itemListCollection;
		historyView.eventsList.isSelectable = false;

		mapStarlingEvent(itemListCollection, CollectionEventType.ADD_ITEM, onItemAdded);
		mapStarlingEvent(itemListCollection, CollectionEventType.RESET, onCommunicatorChanged);

		historyView.eventsList.itemRendererProperties.labelFunction = function (item:ICItem):String
		{
			return createListItem(item);
		};
		readMessages();
		scrollToEnd();
	}

	private function readMessages():void {
		for(var i:int = 0; i < communicatorData.items.length; i++) {
			var icItem:ICItem = communicatorData.items.getItemAt(i);
			markMessageAsReceived(icItem);
		}
	}

	private function onCommunicatorChanged(event:Event):void
	{
		scrollToEnd();
	}

	protected function createListItem(item:ICItem):String
	{
		if(item is CItem) return item.toString();

		var time:String = "";
		if(item is ICTime){
			var date:Date = new Date((item as ICTime).time);
			time = chat.model.dateFormatter.formatUTC(date);
		}

		if (item is ICMessage) {
			var messageItem:CMessage = item as CMessage;
			var message:Message = messageItem.data;
			if (message.body == null) {
				if (message.state != null) {
					return StringUtils.substitute("[{0}] {1}: {2}", time, messageItem.from, message.state);
				}
				if (message.receipt != null) {
					return StringUtils.substitute("[{0}] {1}: {2}", time, messageItem.from, message.receipt);
				}
			}else{
				return StringUtils.substitute("{0}[{1}] {2}: {3}", messageItem.isRead? "" : "*", time, messageItem.from, messageItem.toString());
			}
		}

		return item.toString();
	}

	protected function scrollToEnd():void
	{
		historyView.eventsList.validate();
		historyView.eventsList.verticalScrollPosition = historyView.eventsList.maxVerticalScrollPosition;
	}

	protected function onItemAdded(event:Event):void
	{
		var index:int = int(event.data);
		var item:ICItem = communicatorData.items.getItemAt(index);
		markMessageAsReceived(item);

		scrollToEnd();
	}

	protected function markMessageAsReceived(message:ICItem):void
	{
		communicatorData.read(message);
	}

	protected function get historyView():HistoryCommunicatorView
	{
		return communicatorView as HistoryCommunicatorView;
	}

	override public function destroy():void
	{
		super.destroy();
	}
}
}
