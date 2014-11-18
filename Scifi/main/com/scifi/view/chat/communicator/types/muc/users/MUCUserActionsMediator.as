/**
 * Created by kuts on 11/17/14.
 */
package com.scifi.view.chat.communicator.types.muc.users
{
import feathers.data.ListCollection;

import robotlegs.extensions.starlingFeathers.impl.FeathersMediator;

public class MUCUserActionsMediator extends FeathersMediator
{
	[Inject]
	public var view:MUCUserActionsView;

	override public function initializeComplete():void
	{
		super.initializeComplete();

		view.actionsButtons.dataProvider = new ListCollection([
			{ label: "+" },
			{ label: ".." }
		])
	}
}
}
