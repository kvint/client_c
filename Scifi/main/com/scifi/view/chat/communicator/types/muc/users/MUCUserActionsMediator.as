/**
 * Created by kuts on 11/17/14.
 */
package com.scifi.view.chat.communicator.types.muc.users
{
import com.chat.model.ChatUser;
import com.chat.model.presences.IPresenceStatus;
import com.scifi.view.chat.user.actions.UserActionsMediator;
import com.scifi.view.chat.user.actions.UserActionsView;

public class MUCUserActionsMediator extends UserActionsMediator implements IPresenceStatus
{
	[Inject]
	public var view:MUCUserActionsView;

	override public function initializeComplete():void
	{
		super.initializeComplete();

		view.presenceView.statusProvider.data = chat.model.presences.getByUID(chatUser.jid.bareJID);

		chat.model.presences.subscribe(this);
	}

	override protected function setActionsButtons():void
	{
		if (chat.model.isMe(chatUser.jid))
			return;

		if (!chat.model.roster.isFriend(chatUser.jid))
		{
			view.actionsButtons.dataProvider.addItem({
				label: "+",
				triggered: actionsButtons_addFriend
			});
		}

		view.actionsButtons.dataProvider.addItem({
			label: "..",
			triggered: actionsButtons_startPrivate
		});
	}

	override public function destroy():void
	{
		chat.model.presences.unsubscribe(this);

		super.destroy();
	}

	private function actionsButtons_startPrivate():void
	{
		chat.model.communicators.getFor(chatUser).active = true;
	}

	private function actionsButtons_addFriend():void
	{
		chat.controller.addFriend(chatUser.jid);
	}

	public function set textStatus(value:String):void
	{
	}

	public function set showStatus(value:int):void
	{
		view.presenceView.statusProvider.data = value;
	}

	public function set online(value:Boolean):void
	{

	}

	public function get uid():String
	{
		return chatUser.jid.bareJID;
	}

	private function get chatUser():ChatUser
	{
		return view.data as ChatUser;
	}

	override protected function get actionsView():UserActionsView
	{
		return view;
	}
}
}
