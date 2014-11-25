/**
 * Created by kuts on 11/25/14.
 */
package com.scifi.view.chat.user.actions
{
import com.chat.IChat;
import com.chat.model.presences.IPresenceStatus;

import feathers.data.ListCollection;

import org.igniterealtime.xiff.data.im.IRosterItemVO;

import robotlegs.extensions.starlingFeathers.impl.FeathersMediator;

public class FriendUserActionsMediator extends FeathersMediator implements IPresenceStatus
{
	[Inject]
	public var view:FriendUserActionsView;

	[Inject]
	public var chat:IChat;

	override public function initializeComplete():void
	{
		super.initializeComplete();

		view.actionsButtons.dataProvider = new ListCollection();
		view.actionsButtons.buttonFactory = view.actionButtonFactory;

		setActionsData();

		chat.model.presences.subscribe(this);
	}

	private function setActionsData():void
	{
		view.actionsButtons.dataProvider.addItem({
			label: "-",
			triggered: actionsButtons_removeUser
		});

		view.actionsButtons.dataProvider.addItem({
			label: "..",
			triggered: actionsButtons_startPrivate
		});
	}

	private function actionsButtons_startPrivate():void
	{
		chat.model.communicators.getFor(rosterItem).active = true;
	}

	private function actionsButtons_removeUser():void
	{
		chat.model.roster.removeContact(rosterItem);
	}

	private function get rosterItem():IRosterItemVO
	{
		return view.data as IRosterItemVO;
	}

	public function get uid():String
	{
		return rosterItem.jid.bareJID;
	}

	public function set showStatus(value:int):void
	{
		view.presenceView.statusProvider.data = value;
	}

	public function set textStatus(value:String):void
	{
	}

	override public function destroy():void
	{
		chat.model.presences.unsubscribe(this);

		super.destroy();
	}
}
}
