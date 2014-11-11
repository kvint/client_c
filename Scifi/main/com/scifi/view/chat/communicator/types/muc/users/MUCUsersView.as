/**
 * Created by kuts on 11/11/14.
 */
package com.scifi.view.chat.communicator.types.muc.users
{
import feathers.controls.List;
import feathers.skins.IStyleProvider;

public class MUCUsersView extends List
{
	private var _communicator:Object;

	public static var globalStyleProvider:IStyleProvider;

	override protected function get defaultStyleProvider():IStyleProvider
	{
	    return globalStyleProvider;
	}

	public function MUCUsersView(communicator:Object)
	{
		_communicator = communicator;
	}

	public function get communicator():Object
	{
		return _communicator;
	}
}
}
