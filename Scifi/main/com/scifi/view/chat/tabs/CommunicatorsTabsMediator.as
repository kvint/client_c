/**
 * Created by kvint on 01.11.14.
 */
package com.scifi.view.chat.tabs
{
import com.chat.IChat;
import com.chat.events.ChatModelEvent;
import com.chat.model.communicators.CommunicatorType;
import com.chat.model.communicators.ICommunicatorBase;
import com.chat.model.communicators.ICommunicator;
import com.scifi.view.chat.tabs.types.DefaultCommunicatorTabView;
import com.scifi.view.chat.tabs.types.DirectCommunicatorTabView;

import feathers.data.ListCollection;

import robotlegs.extensions.starlingFeathers.impl.FeathersMediator;

import starling.events.Event;

public class CommunicatorsTabsMediator extends FeathersMediator
{

	[Inject]
	public var view:CommunicatorsTabsView;

	[Inject]
	public var chat:IChat;

	override public function initializeComplete():void
	{
		view.dataProvider = new ListCollection();

		setTabs();

		chat.model.addEventListener(ChatModelEvent.COMMUNICATOR_ACTIVATED, model_handleActivation);
		chat.model.addEventListener(ChatModelEvent.COMMUNICATOR_DEACTIVATED, model_handleActivation);

		mapStarlingEvent(view, Event.CHANGE, view_onChange);

		view.tabInitializer = tabInitializer;
	}

	override public function destroy():void
	{
		chat.model.removeEventListener(ChatModelEvent.COMMUNICATOR_ACTIVATED, model_handleActivation);
		chat.model.removeEventListener(ChatModelEvent.COMMUNICATOR_DEACTIVATED, model_handleActivation);
	}

	protected function tabInitializer(tab:CommunicatorTabContainerView, communicator:ICommunicator):void
	{
		tab.provider = communicator;

		var factory:Class;

		switch (communicator.type)
		{
			case CommunicatorType.DIRECT:
				factory = DirectCommunicatorTabView;
				break;
			case CommunicatorType.MUC:
				factory = DirectCommunicatorTabView;
				break;
			default :
				factory = DefaultCommunicatorTabView;
				break;
		}

		tab.viewFactoryClass = factory;
	}

	private function setTabs():void
	{
		var iCommunicators:Vector.<ICommunicatorBase> = chat.model.provider.getAll();

		for each (var communicator:ICommunicator in iCommunicators)
			if (communicator.active)
				addTab(communicator);
	}

	private function addTab(provider:ICommunicatorBase):void
	{
		view.dataProvider.addItem(provider);
	}

	private function view_onChange():void
	{
		var communicator:ICommunicatorBase = view.selectedItem as ICommunicatorBase;
		chat.controller.activateCommunicator(communicator);
	}

	private function model_handleActivation(event:ChatModelEvent):void
	{
		switch (event.type)
		{
			case ChatModelEvent.COMMUNICATOR_ACTIVATED:
				addTab(event.data as ICommunicatorBase);
				break;
			case ChatModelEvent.COMMUNICATOR_DEACTIVATED:
				var index:int = view.dataProvider.getItemIndex(event.data);
				view.dataProvider.removeItemAt(index);
				view.validate();
				break;
		}
	}

}
}
