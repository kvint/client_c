/**
 * Created by AlexanderSla on 03.11.2014.
 */
package com.scifi.view.chat.roster
{
import com.chat.IChat;
import com.chat.events.CommunicatorFactoryEvent;
import com.chat.events.CommunicatorCommandEvent;
import com.chat.model.communicators.ICommunicator;
import com.chat.model.communicators.ICommunicatorBase;
	import com.chat.model.communicators.factory.ICommunicatorFactory;
import com.scifi.view.chat.user.actions.FriendUserActionsView;
import com.scifi.view.chat.user.actions.RequestUserActionsView;

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

	[Inject]
	public var communicators:ICommunicatorFactory;

	override public function initializeComplete():void
	{
		view.friendsLabel.text = "Friends";
		view.requestsLabel.text = "Requests";

		view.friendsList.isSelectable = false;
		view.requestsList.isSelectable = false;

		view.friendsList.itemRendererProperties.labelFunction = usersListLabelFunction;
		view.friendsList.itemRendererProperties.accessoryFunction = createFriendActionsView;

		view.requestsList.itemRendererProperties.labelFunction = usersListLabelFunction;
		view.requestsList.itemRendererProperties.accessoryFunction = createRequestActionsView;

		if (chat.model.roster.connection.loggedIn)
			setUsersList();

		addRosterEventsListeners();
	}

	private static function createFriendActionsView(data:IRosterItemVO):FriendUserActionsView
	{
		return new FriendUserActionsView(data);
	}

	private static function createRequestActionsView(data:IRosterItemVO):RequestUserActionsView
	{
		return new RequestUserActionsView(data);
	}

	override public function destroy():void
	{
		super.destroy();

		removeRosterEventsListeners();
	}

	private static function usersListLabelFunction(data:Object):String
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
		view.friendsList.dataProvider = new ListCollection();
		view.requestsList.dataProvider = new ListCollection();

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

	private function removeUserFromList(data:IRosterItemVO):void
	{
		switch (data.subscribeType){
			case RosterExtension.SUBSCRIBE_TYPE_BOTH:
				view.friendsList.dataProvider.removeItemAt(view.friendsList.dataProvider.getItemIndex(data));
				break;
			case RosterExtension.SUBSCRIBE_TYPE_FROM:
				view.requestsList.dataProvider.removeItemAt(view.requestsList.dataProvider.getItemIndex(data));
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
				removeUserFromList(event.data);
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

}
}
