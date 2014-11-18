/**
 * Created by AlexanderSla on 03.11.2014.
 */
package com.scifi.view.chat.roster
{
import com.chat.IChat;
import com.chat.events.ChatModelEvent;
import com.chat.model.communicators.ICommunicator;

import feathers.controls.List;
import feathers.data.ListCollection;

import org.igniterealtime.xiff.data.im.IRosterItemVO;
	import org.igniterealtime.xiff.data.im.RosterExtension;
	import org.igniterealtime.xiff.data.im.RosterItemVO;
import org.igniterealtime.xiff.events.RosterEvent;

import robotlegs.extensions.starlingFeathers.impl.FeathersMediator;

import starling.events.Event;

public class RosterMediator extends FeathersMediator
{

	[Inject]
	public var view:RosterView;

	[Inject]
	public var chat:IChat;

	override public function initializeComplete():void
	{
//		view.friendsList.isSelectable = false;

		view.friendsLabel.text = "Friends";
		view.requestsLabel.text = "Requests";

		view.friendsList.dataProvider = new ListCollection();
		view.requestsList.dataProvider = new ListCollection();

		view.friendsList.itemRendererProperties.labelFunction = friendsListLabelFunction;
		view.requestsList.itemRendererProperties.labelFunction = friendsListLabelFunction;

		if (chat.model.roster.connection.loggedIn)
			setUsersList();

		mapStarlingEvent(view.friendsList, Event.CHANGE, friendsList_onChange);

		addRosterEventsListeners();
	}

	override public function destroy():void
	{
		super.destroy();

		removeRosterEventsListeners();
	}

	private static function friendsListLabelFunction(data:Object):String
	{
		return (data as IRosterItemVO).nickname;
	}

	protected function addRosterEventsListeners():void
	{
		chat.model.roster.addEventListener(RosterEvent.ROSTER_LOADED, roster_handleEvent);
		chat.model.roster.addEventListener(RosterEvent.USER_ADDED, roster_handleEvent);
		chat.model.roster.addEventListener(RosterEvent.USER_REMOVED, roster_handleEvent);
		chat.model.roster.addEventListener(RosterEvent.USER_SUBSCRIPTION_UPDATED, roster_handleEvent);

		/*
		 public static const ROSTER_LOADED:String = "rosterLoaded";
		 public static const SUBSCRIPTION_DENIAL:String = "subscriptionDenial";
		 public static const SUBSCRIPTION_REQUEST:String = "subscriptionRequest";
		 public static const SUBSCRIPTION_REVOCATION:String = "subscriptionRevocation";
		 public static const USER_ADDED:String = "userAdded";
		 public static const USER_AVAILABLE:String = "userAvailable";
		 public static const USER_PRESENCE_UPDATED:String = "userPresenceUpdated";
		 public static const USER_REMOVED:String = "userRemoved";
		 public static const USER_SUBSCRIPTION_UPDATED:String = "userSubscriptionUpdated";
		 public static const USER_UNAVAILABLE:String = "userUnavailable";
		 */
	}

	protected function removeRosterEventsListeners():void
	{
		chat.model.roster.removeEventListener(RosterEvent.ROSTER_LOADED, roster_handleEvent);
		chat.model.roster.removeEventListener(RosterEvent.USER_ADDED, roster_handleEvent);
		chat.model.roster.removeEventListener(RosterEvent.USER_REMOVED, roster_handleEvent);
		chat.model.roster.removeEventListener(RosterEvent.USER_SUBSCRIPTION_UPDATED, roster_handleEvent);
	}

	private function setUsersList():void
	{
		for each(var data:IRosterItemVO in chat.model.roster.source)
			addUserToList(data);
	}

	private function addUserToList(data:IRosterItemVO):void
	{
		switch (data.subscribeType){
			case RosterExtension.SUBSCRIBE_TYPE_BOTH:
				view.friendsList.dataProvider.addItem(data);
				break;
			case RosterExtension.SUBSCRIBE_TYPE_FROM:
				view.requestsList.dataProvider.addItem(data);
				break;
			case RosterExtension.SUBSCRIBE_TYPE_TO:
				break;
		}
	}

	private function roster_handleEvent(event:RosterEvent):void
	{
		switch (event.type)
		{
			case RosterEvent.ROSTER_LOADED:
				setUsersList();
				break;
			case RosterEvent.USER_ADDED:
				addUserToList(event.data);
				break;
			case RosterEvent.USER_REMOVED:
				break;
			case RosterEvent.USER_SUBSCRIPTION_UPDATED:
				setUsersList();
				/** TODO:
				 * from - входящий запрос в друзья,
				 * to - исходящий запрос в друзья,
				 * both - друзья навеки!
				 **/
				break;
		}
	}

	private function friendsList_onChange(event:Event):void
	{
		var ri:RosterItemVO = (event.currentTarget as List).selectedItem as RosterItemVO;

		var iCommunicator:ICommunicator = chat.model.provider.getCommunicator(ri);
		iCommunicator.active = true;
	}

}
}
