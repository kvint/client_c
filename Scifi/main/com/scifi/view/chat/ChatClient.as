/**
 * Created by kvint on 01.11.14.
 */
package com.scifi.view.chat
{
import com.scifi.view.chat.communicator.CommunicatorContainerView;

import feathers.controls.LayoutGroup;
import feathers.controls.List;
import feathers.controls.TabBar;
import feathers.skins.IStyleProvider;

public class ChatClient extends LayoutGroup
{
	public static const CHILD_COMMUNICATORS_TABS:String = "child-communicators-tabs";

	private var _containerView:CommunicatorContainerView = new CommunicatorContainerView();
	private var _communicatorsTabs:List = new List();

	public static var globalStyleProvider:IStyleProvider;

	override protected function get defaultStyleProvider():IStyleProvider
	{
		return globalStyleProvider;
	}

	override protected function initialize():void
	{
		communicatorsTabs.styleNameList.add(CHILD_COMMUNICATORS_TABS);

		addChild(containerView);
		addChild(communicatorsTabs);
	}

	public function get containerView():CommunicatorContainerView
	{
		return _containerView;
	}

	public function get communicatorsTabs():List
	{
		return _communicatorsTabs;
	}

}
}
