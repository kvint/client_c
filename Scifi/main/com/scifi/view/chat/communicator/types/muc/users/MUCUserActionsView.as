/**
 * Created by kuts on 11/17/14.
 */
package com.scifi.view.chat.communicator.types.muc.users
{
import com.scifi.view.chat.presence.PresenceView;

import feathers.controls.ButtonGroup;
import feathers.controls.LayoutGroup;
import feathers.skins.IStyleProvider;

public class MUCUserActionsView extends LayoutGroup
{
	private var _data:Object;

	private var _presenceView:PresenceView = new PresenceView();
	private var _actionsButtons:ButtonGroup = new ButtonGroup();

	public static var globalStyleProvider:IStyleProvider;

	override protected function get defaultStyleProvider():IStyleProvider
	{
	    return globalStyleProvider;
	}

	public function MUCUserActionsView(data:Object)
	{
		super();
		_data = data;
	}

	override protected function initialize():void
	{
		super.initialize();

		addChild(actionsButtons);
		addChild(presenceView);
	}

	public function get data():Object
	{
		return _data;
	}

	public function get actionsButtons():ButtonGroup
	{
		return _actionsButtons;
	}

	public function get presenceView():PresenceView
	{
		return _presenceView;
	}
}
}
