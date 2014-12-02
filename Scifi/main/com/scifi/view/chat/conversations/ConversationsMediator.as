/**
 * Created by kuts on 12/2/14.
 */
package com.scifi.view.chat.conversations
{
import com.chat.IChat;
import com.chat.events.CommunicatorEvent;
import com.chat.model.communicators.ICommunicator;
import com.chat.model.communicators.IConversationsCommunicator;
import com.chat.model.data.CItemConversation;
import com.chat.model.data.ICItem;

import feathers.data.ListCollection;

import org.igniterealtime.xiff.core.AbstractJID;

import robotlegs.extensions.starlingFeathers.impl.FeathersMediator;

import starling.events.Event;

public class ConversationsMediator extends FeathersMediator
{
	[Inject]
	public var view:ConversationsView;

	[Inject]
	public var chat:IChat;

	private var _conversations:IConversationsCommunicator;

	override public function initializeComplete():void {
		super.initializeComplete();
		_conversations = chat.model.conversations;

		_conversations.addEventListener(CommunicatorEvent.ITEM_ADDED, handler);
		_conversations.addEventListener(CommunicatorEvent.ITEM_REMOVED, handler);
		_conversations.addEventListener(CommunicatorEvent.ITEM_INSERTED, handler);
		_conversations.addEventListener(CommunicatorEvent.ITEM_UPDATED, handler);

		view.conversationsList.itemRendererProperties.labelFunction = conversationListLabelFunction;

		setItems();

		mapStarlingEvent(view.conversationsList, Event.CHANGE, conversationsList_onChange);
	}

	private function conversationListLabelFunction(item:ICItem):String {
		if(item is CItemConversation){
			var conversation:CItemConversation = item as CItemConversation;
			var from:AbstractJID = conversation.from as AbstractJID;
			var msg:String = "";
			if(conversation.lastMessage){
				msg = String(conversation.lastMessage.body);
			}
			return from.toString() + msg;
		}
		return null;
	}

	private function setItems():void {
		view.conversationsList.dataProvider = new ListCollection();
		for (var i:int = 0; i < _conversations.items.length; i++) {
			addItem(_conversations.items[i]);
		}
	}

	private function insertItem(item:ICItem):void {
		view.conversationsList.dataProvider.addItemAt(item, 0);
	}

	private function updateItem(item:ICItem):void {
		var idx:int = view.conversationsList.dataProvider.getItemIndex(item);
		view.conversationsList.dataProvider.updateItemAt(idx);
	}

	private function addItem(item:ICItem):void {
		view.conversationsList.dataProvider.addItem(item);

	}
	private function removeItem(item:ICItem):void {
		view.conversationsList.dataProvider.removeItem(item);
	}

	private function handler(event:CommunicatorEvent):void {
		var item:ICItem = event.data as ICItem;
		switch (event.type)
		{
			case CommunicatorEvent.ITEM_ADDED:
				addItem(item);
				break;
			case CommunicatorEvent.ITEM_REMOVED:
				removeItem(item);
				break;
			case CommunicatorEvent.ITEM_INSERTED:
				insertItem(item);
				break;
			case CommunicatorEvent.ITEM_UPDATED:
				updateItem(item);
				break;
		}
	}


	override public function destroy():void {
		_conversations.removeEventListener(CommunicatorEvent.ITEM_REMOVED, handler);
		_conversations.removeEventListener(CommunicatorEvent.ITEM_ADDED, handler);
		_conversations.removeEventListener(CommunicatorEvent.ITEM_INSERTED, handler);
		_conversations.removeEventListener(CommunicatorEvent.ITEM_UPDATED, handler);
		super.destroy();
	}

	private function conversationsList_onChange():void
	{
		if (view.conversationsList.selectedIndex == -1)
			return;

		var iCommunicator:ICommunicator = chat.model.communicators.getFor(view.conversationsList.selectedItem);
		iCommunicator.active = true;
	}
}
}
