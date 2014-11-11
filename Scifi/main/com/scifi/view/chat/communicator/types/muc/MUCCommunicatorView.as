/**
 * Created by kvint on 11.11.14.
 */
package com.scifi.view.chat.communicator.types.muc
{
import com.scifi.view.chat.communicator.types.muc.users.MUCUsersButtonView;
import com.scifi.view.chat.communicator.types.writable.WritableCommunicatorView;

import feathers.skins.IStyleProvider;

public class MUCCommunicatorView extends WritableCommunicatorView
{
	private var _usersView:MUCUsersButtonView = new MUCUsersButtonView();

	public static var globalStyleProvider:IStyleProvider;

	override protected function get defaultStyleProvider():IStyleProvider
	{
		return globalStyleProvider;
	}

	override protected function initialize():void
	{
		super.initialize();

		addChild(usersView);
	}

	public function get usersView():MUCUsersButtonView
	{
		return _usersView;
	}
}
}
