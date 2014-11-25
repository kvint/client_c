/**
 * Created by kuts on 11/17/14.
 */
package com.scifi.view.chat.communicator.types.muc.users
{
import com.chat.IChat;
import com.chat.model.ChatUser;
import com.chat.model.presences.IPresenceStatus;

import feathers.data.ListCollection;

import robotlegs.extensions.starlingFeathers.impl.FeathersMediator;

public class MUCUserActionsMediator extends FeathersMediator implements IPresenceStatus
{
	[Inject]
	public var view:MUCUserActionsView;

	[Inject]
	public var chat:IChat;

	override public function initializeComplete():void
	{
		super.initializeComplete();

		view.presenceView.statusProvider.data = chat.model.presences.getByUID(chatUser.jid.bareJID);

		chat.model.presences.subscribe(this);

		view.actionsButtons.dataProvider = new ListCollection([
			{ label: "+" },
			{ label: ".." }
		])
	}

	override public function destroy():void
	{
		chat.model.presences.unsubscribe(this);

		super.destroy();
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

}
}
