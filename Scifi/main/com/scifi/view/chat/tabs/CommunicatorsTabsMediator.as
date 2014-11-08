/**
 * Created by kvint on 01.11.14.
 */
package com.scifi.view.chat.tabs
{
import com.scifi.view.chat.tabs.types.DefaultCommunicatorTabView;
import com.scifi.view.chat.tabs.types.DirectCommunicatorTabView;

import events.ChatModelEvent;

import feathers.data.ListCollection;

import model.communicators.CommunicatorType;

import model.communicators.ICommunicator;

import robotlegs.extensions.starlingFeathers.impl.FeathersMediator;

import starling.events.Event;

public class CommunicatorsTabsMediator extends FeathersMediator
{

	[Inject]
	public var view:CommunicatorsTabsView;

	[Inject]
	public var chat:Chat;

	override public function initializeComplete():void
	{
		view.dataProvider = new ListCollection();

		setTabs();

		chat.model.addEventListener(ChatModelEvent.COMMUNICATOR_ADDED, model_handleEvent);
		chat.model.addEventListener(ChatModelEvent.COMMUNICATOR_ACTIVATED, model_handleEvent);

		mapStarlingEvent(view, Event.CHANGE, view_onChange);

		view.tabInitializer = tabInitializer;
	}

	override public function destroy():void
	{
		chat.model.removeEventListener(ChatModelEvent.COMMUNICATOR_ADDED, model_handleEvent);
		chat.model.removeEventListener(ChatModelEvent.COMMUNICATOR_ACTIVATED, model_handleEvent);
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
			default :
				factory = DefaultCommunicatorTabView;
				break;
		}

		tab.viewFactoryClass = factory;
	}

	private function setTabs():void
	{
		var iCommunicators:Vector.<ICommunicator> = chat.model.provider.getAll();
		for (var idx:int = 0; idx < iCommunicators.length; idx++)
			addTab(iCommunicators[idx]);
	}

	private function addTab(provider:ICommunicator):void
	{
		view.dataProvider.addItem(provider);
	}

	private function view_onChange():void
	{
		var communicator:ICommunicator = view.selectedItem as ICommunicator;
		chat.controller.activateCommunicator(communicator);
	}

	private function model_handleEvent(event:ChatModelEvent):void
	{
		switch (event.type)
		{
			case ChatModelEvent.COMMUNICATOR_ADDED:
				addTab(event.data as ICommunicator);
				break;
			case ChatModelEvent.COMMUNICATOR_ACTIVATED:
				var index:int = view.dataProvider.getItemIndex(event.data);
				view.selectedIndex = index;
				break;
		}
	}

}
}
