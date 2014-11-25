/**
 * Created by kuts on 11/25/14.
 */
package com.scifi.view.chat.user.actions
{
import com.chat.IChat;

import feathers.data.ListCollection;

import robotlegs.extensions.starlingFeathers.impl.FeathersMediator;

public class UserActionsMediator extends FeathersMediator
{
	[Inject]
	public var chat:IChat;

	override public function initializeComplete():void
	{
		super.initializeComplete();

		actionsView.actionsButtons.dataProvider = new ListCollection();
		actionsView.actionsButtons.buttonFactory = actionsView.actionButtonFactory;

		setActionsButtons();
	}

	protected function setActionsButtons():void
	{

	}

	protected function get actionsView():UserActionsView
	{
		return null;
	}
}
}
