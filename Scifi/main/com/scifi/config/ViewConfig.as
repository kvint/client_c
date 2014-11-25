/**
 * Created by mikhailkuts on 03.10.14.
 */
package com.scifi.config
{

import com.scifi.view.chat.ChatMediator;
import com.scifi.view.chat.ChatView;
import com.scifi.view.chat.communicator.types.direct.DirectCommunicatorMediator;
import com.scifi.view.chat.communicator.types.direct.DirectCommunicatorView;
import com.scifi.view.chat.communicator.types.muc.MUCCommunicatorMediator;
import com.scifi.view.chat.communicator.types.muc.MUCCommunicatorView;
import com.scifi.view.chat.communicator.types.muc.users.MUCUserActionsMediator;
import com.scifi.view.chat.communicator.types.muc.users.MUCUserActionsView;
import com.scifi.view.chat.communicator.types.muc.users.MUCUsersButtonMediator;
import com.scifi.view.chat.communicator.types.muc.users.MUCUsersButtonView;
import com.scifi.view.chat.communicator.types.muc.users.MUCUsersMediator;
import com.scifi.view.chat.communicator.types.muc.users.MUCUsersView;
import com.scifi.view.chat.user.actions.FriendUserActionsMediator;
import com.scifi.view.chat.user.actions.FriendUserActionsView;
import com.scifi.view.chat.user.presence.PresenceMediator;
import com.scifi.view.chat.user.presence.PresenceView;
import com.scifi.view.chat.roster.RosterButtonMediator;
import com.scifi.view.chat.roster.RosterButtonView;
import com.scifi.view.chat.roster.RosterMediator;
import com.scifi.view.chat.roster.RosterView;
import com.scifi.view.chat.tabs.types.DirectCommunicatorTabMediator;
import com.scifi.view.chat.tabs.types.DirectCommunicatorTabView;
import com.scifi.view.chat.tabs.types.MUCCommunicatorTabMediator;
import com.scifi.view.chat.tabs.types.MUCCommunicatorTabView;
import com.scifi.view.screens.game.GameMediator;
import com.scifi.view.screens.game.GameView;
import com.scifi.view.starling.StarlingStageMediator;
import com.scifi.view.starling.StarlingStageView;

import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.framework.api.IConfig;
import robotlegs.bender.framework.api.IInjector;

public class ViewConfig implements IConfig
{

	[Inject]
	public var mediatorMap:IMediatorMap;

	[Inject]
	public var injector:IInjector;

	public function configure():void
	{
		mapView();
	}

	private function mapView():void
	{
		mediatorMap.map(StarlingStageView).toMediator(StarlingStageMediator);
		mediatorMap.map(GameView).toMediator(GameMediator);

		// CHAT
		mediatorMap.map(ChatView).toMediator(ChatMediator);
		mediatorMap.map(RosterView).toMediator(RosterMediator);
		mediatorMap.map(RosterButtonView).toMediator(RosterButtonMediator);
		mediatorMap.map(MUCUsersButtonView).toMediator(MUCUsersButtonMediator);
		mediatorMap.map(MUCUsersView).toMediator(MUCUsersMediator);

		// COMMUNICATORS
		mediatorMap.map(DirectCommunicatorView).toMediator(DirectCommunicatorMediator);
		mediatorMap.map(MUCCommunicatorView).toMediator(MUCCommunicatorMediator);

		// TABS
		mediatorMap.map(MUCCommunicatorTabView).toMediator(MUCCommunicatorTabMediator);
		mediatorMap.map(DirectCommunicatorTabView).toMediator(DirectCommunicatorTabMediator);

		mediatorMap.map(MUCUserActionsView).toMediator(MUCUserActionsMediator);
		mediatorMap.map(PresenceView).toMediator(PresenceMediator);
		mediatorMap.map(FriendUserActionsView).toMediator(FriendUserActionsMediator);
	}

}
}
