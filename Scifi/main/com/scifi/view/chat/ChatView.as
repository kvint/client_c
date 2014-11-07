/**
 * Created by kvint on 01.11.14.
 */
package com.scifi.view.chat
{
import com.scifi.view.chat.communicator.CommunicatorContainerView;
import com.scifi.view.chat.tabs.CommunicatorsTabsView;

import feathers.controls.LayoutGroup;
import feathers.skins.IStyleProvider;

public class ChatView extends LayoutGroup
{

	private var _containerView:CommunicatorContainerView = new CommunicatorContainerView();
	private var _tabsView:CommunicatorsTabsView = new CommunicatorsTabsView();

	public static var globalStyleProvider:IStyleProvider;

	override protected function get defaultStyleProvider():IStyleProvider
	{
		return globalStyleProvider;
	}

	override protected function initialize():void
	{
		addChild(containerView);
		addChild(tabsView);
	}

	public function get containerView():CommunicatorContainerView
	{
		return _containerView;
	}

	public function get tabsView():CommunicatorsTabsView
	{
		return _tabsView;
	}

}
}
