/**
 * Created by kvint on 02.11.14.
 */
package com.scifi.view.chat.communicator.types.history
{
import com.chat.IChat;
import com.chat.events.CommunicatorEvent;
	import com.chat.model.data.citems.CItemString;
	import com.chat.model.data.citems.ICItem;
import com.chat.model.data.citems.CItemMessage;
	import com.chat.model.data.collections.ICItemCollection;
	import com.scifi.view.chat.communicator.types.base.DefaultCommunicatorMediator;

	import feathers.data.ChatListCollection;

	import feathers.data.ListCollection;
	import feathers.events.CollectionEventType;

	import flash.globalization.DateTimeFormatter;
	import flash.globalization.DateTimeStyle;

	import flash.utils.setTimeout;

	import org.as3commons.lang.StringUtils;
	import org.igniterealtime.xiff.data.Message;

	import starling.events.Event;

	import starling.events.EventDispatcher;

	public class HistoryCommunicatorMediator extends DefaultCommunicatorMediator
{

	[Inject]
	public var chat:IChat;
	private var _dateFormatter:DateTimeFormatter = new DateTimeFormatter(flash.globalization.LocaleID.DEFAULT, DateTimeStyle.SHORT, DateTimeStyle.SHORT);

	override public function initializeComplete():void
	{
		super.initializeComplete();

		historyView.eventsList.dataProvider = new ChatListCollection(communicatorData.items);
		historyView.eventsList.isSelectable = false;

		var dispatcher:EventDispatcher = communicatorData.items as EventDispatcher;
		mapStarlingEvent(dispatcher, CollectionEventType.ADD_ITEM, onItemAdded);
		mapStarlingEvent(dispatcher, CollectionEventType.RESET, onCommunicatorChanged);

		historyView.eventsList.itemRendererProperties.labelFunction = function (item:ICItem):String
		{
			/*if (item.body == null)
			{
				return (item as MessageItem).data.toString();
			}
			return item.body.toString();*/
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
		if(item is CItemString) return String(item.body);

		var date:Date = new Date(item.time);

		var time:String = _dateFormatter.formatUTC(date);

		if (item is CItemMessage) {
			var messageItem:CItemMessage = item as CItemMessage;
			var message:Message = messageItem.data as Message;
			if (message.body == null) {
				if (message.state != null) {
					return StringUtils.substitute("[{0}] {1}: {2}", time, item.from, message.state);
				}
				if (message.receipt != null) {
					return StringUtils.substitute("[{0}] {1}: {2}", time, item.from, message.receipt);
				}
			}
		}

		return StringUtils.substitute("{0}[{1}] {2}: {3}", item.isRead? "" : "*", time, item.from, item.body);
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
