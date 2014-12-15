/**
 * Created by kuts on 12/2/14.
 */
package com.scifi.view.chat.conversations
{
	import com.chat.IChat;
	import com.chat.events.ChatEvent;
	import com.chat.model.communicators.IConversationsCommunicator;
	import com.chat.model.data.citems.ICConversation;

	import feathers.data.CItemListCollection;

	import flash.events.Event;

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

		view.conversationsList.dataProvider = new CItemListCollection(_conversations.items);

		mapStarlingEvent(view.conversationsList, starling.events.Event.CHANGE, conversationsList_onChange);

		dispatch(new flash.events.Event(ChatEvent.LOAD_CONVERSATIONS));
	}

	private function conversationsList_onChange():void
	{
		if (view.conversationsList.selectedIndex == -1)
			return;

		var selectedItem:ICConversation = view.conversationsList.selectedItem as ICConversation;
		selectedItem.communicator.active = true;
	}
}
}
