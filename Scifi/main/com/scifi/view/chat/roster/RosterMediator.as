/**
 * Created by AlexanderSla on 03.11.2014.
 */
package com.scifi.view.chat.roster
{
import com.chat.controller.ChatController;
import com.chat.events.ChatModelEvent;
import com.chat.model.ChatModel;
import com.chat.model.communicators.ICommunicator;

import feathers.controls.List;
import feathers.data.ListCollection;

import org.igniterealtime.xiff.data.im.RosterItemVO;
import org.igniterealtime.xiff.events.RosterEvent;

import robotlegs.extensions.starlingFeathers.impl.FeathersMediator;

import starling.events.Event;

public class RosterMediator extends FeathersMediator
{

	[Inject]
	public var chatModel:ChatModel;

	[Inject]
	public var chatController:ChatController;

	[Inject]
	public var view:RosterView;

	override public function initializeComplete():void
	{
		view.friendsLabel.text = "Friends";
		view.requestsLabel.text = "Requests";

		view = viewComponent as RosterView;

		view.friendsList.itemRendererProperties.labelFunction = function (data:RosterItemVO):String
		{
			return data.jid.node;
		}

		view.friendsList.addEventListener(Event.CHANGE, listChangeHandler);
		chatModel.addEventListener(RosterEvent.ROSTER_LOADED, onRosterLoaded);
		displayRoster();
	}

	private function listChangeHandler(event:Event):void
	{
		var ri:RosterItemVO = (event.currentTarget as List).selectedItem as RosterItemVO;
		var iCommunicator:ICommunicator = chatModel.provider.getCommunicator(ri);
		chatModel.dispatchEvent(new ChatModelEvent(ChatModelEvent.COMMUNICATOR_ACTIVATED, iCommunicator));
	}

	private function onRosterLoaded(event:RosterEvent):void
	{
		displayRoster();
	}

	private function displayRoster():void
	{
		view.friendsList.dataProvider = new ListCollection(chatModel.roster.source);
	}
}
}
