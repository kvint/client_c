/**
 * Created by kuts on 11/25/14.
 */
package com.scifi.view.chat.user.actions
{
import org.igniterealtime.xiff.data.im.IRosterItemVO;

public class RequestUserActionsMediator extends UserActionsMediator
{
	[Inject]
	public var view:RequestUserActionsView;

	override protected function setActionsButtons():void
	{
		super.setActionsButtons();

		view.actionsButtons.dataProvider.addItem({
			label: "✓️", //✔
			triggered: actionsButtons_onRequestAccepted
		});

		view.actionsButtons.dataProvider.addItem({
			label: "x",
			triggered: actionsButtons_onRequestDecline
		});
	}

	private function actionsButtons_onRequestAccepted():void
	{
		chat.controller.addFriend(rosterItem.jid);
	}

	private function actionsButtons_onRequestDecline():void
	{
		chat.model.roster.denySubscription(rosterItem.jid);
	}

	protected function get rosterItem():IRosterItemVO
	{
		return view.data as IRosterItemVO;
	}

	override protected function get actionsView():UserActionsView
	{
		return view;
	}
}
}
