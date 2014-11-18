/**
 * Created by kvint on 01.11.14.
 */
package com.scifi.view.chat
{
import com.chat.IChat;
import com.chat.events.ChatModelEvent;
import com.chat.model.communicators.CommunicatorType;
import com.chat.model.communicators.ICommunicator;
import com.scifi.view.chat.communicator.types.direct.DirectCommunicatorView;
import com.scifi.view.chat.communicator.types.muc.MUCCommunicatorView;
import com.scifi.view.chat.tabs.CommunicatorTabContainerView;
import com.scifi.view.chat.tabs.types.DefaultCommunicatorTabView;
import com.scifi.view.chat.tabs.types.DirectCommunicatorTabView;

import feathers.data.ListCollection;

import robotlegs.extensions.starlingFeathers.impl.FeathersMediator;

import starling.events.Event;

public class ChatMediator extends FeathersMediator
{

	[Inject]
	public var view:ChatView;

	[Inject]
	public var chat:IChat;

	override public function initializeComplete():void
	{
		view.communicatorsTabs.dataProvider = new ListCollection();
		view.communicatorsTabs.tabInitializer = tabInitializer;

		view.containerView.communicatorFactory.setViewClass(DirectCommunicatorView, CommunicatorType.DIRECT);
		view.containerView.communicatorFactory.setViewClass(MUCCommunicatorView, CommunicatorType.MUC);

		setTabs();

		mapStarlingEvent(view.communicatorsTabs, Event.CHANGE, tabsView_onChange);

		chat.model.addEventListener(ChatModelEvent.COMMUNICATOR_ACTIVATED, model_handleActivation);
		chat.model.addEventListener(ChatModelEvent.COMMUNICATOR_DEACTIVATED, model_handleActivation);
	}

	override public function destroy():void
	{
		super.destroy();

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
		var iCommunicators:Vector.<ICommunicator> = chat.model.provider.getAll();

		for each (var communicator:ICommunicator in iCommunicators)
			if (communicator.active)
				removeTab(communicator);
	}

	private function addTab(communicator:ICommunicator):void
	{
		view.communicatorsTabs.dataProvider.addItem(communicator);
	}

	private function removeTab(communicator:ICommunicator):void
	{
		var index:int = view.communicatorsTabs.dataProvider.getItemIndex(communicator);
		view.communicatorsTabs.dataProvider.removeItemAt(index);
		view.validate();
	}

	private function model_handleActivation(event:ChatModelEvent):void
	{
		switch (event.type)
		{
			case ChatModelEvent.COMMUNICATOR_ACTIVATED:
				addTab(event.data as ICommunicator);
//				view.communicatorsTabs.validate();
				break;
			case ChatModelEvent.COMMUNICATOR_DEACTIVATED:
				removeTab(event.data as ICommunicator);
				view.communicatorsTabs.validate();
				break;
		}
	}

	private function tabsView_onChange():void
	{
		setCommunicatorView();
	}

	private function setCommunicatorView():void
	{
		view.containerView.communicatorProvider = view.communicatorsTabs.selectedItem as ICommunicator;
		view.containerView.validate();
	}

}
}
