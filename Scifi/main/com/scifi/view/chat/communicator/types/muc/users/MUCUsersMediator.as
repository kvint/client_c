/**
 * Created by kuts on 11/11/14.
 */
package com.scifi.view.chat.communicator.types.muc.users
{
import feathers.data.ListCollection;

import robotlegs.extensions.starlingFeathers.impl.FeathersMediator;

public class MUCUsersMediator extends FeathersMediator
{
	[Inject]
	public var view:MUCUsersView;

	override public function initializeComplete():void
	{
		super.initializeComplete();

		view.dataProvider = new ListCollection([
			{ label: "Userkk" },
			{ label: "User_22" },
			{ label: "User33" },
			{ label: "User2" },
			{ label: "User 4" },
			{ label: "User 6" }
		]);
	}

	override public function destroy():void
	{
		super.destroy();
	}

}
}
