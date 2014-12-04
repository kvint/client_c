/**
 * Created by kvint on 01.11.14.
 */
package com.scifi.view.chat
{
import com.chat.events.CommunicatorFactoryEvent;
import com.chat.model.communicators.CommunicatorType;
import com.chat.model.communicators.ICommunicator;
import com.chat.model.communicators.factory.ICommunicatorFactory;
import com.scifi.view.chat.communicator.types.direct.DirectCommunicatorView;
import com.scifi.view.chat.communicator.types.muc.MUCCommunicatorView;
import com.scifi.view.chat.tabs.CommunicatorTabContainerView;
import com.scifi.view.chat.tabs.types.DefaultCommunicatorTabView;
import com.scifi.view.chat.tabs.types.DirectCommunicatorTabView;

import feathers.core.FeathersControl;

import feathers.data.ListCollection;

import org.as3commons.logging.api.ILogger;
import org.as3commons.logging.api.getLogger;

import robotlegs.extensions.starlingFeathers.impl.FeathersMediator;

import starling.events.Event;

public class ChatClientMediator extends FeathersMediator
{
	private static const log:ILogger = getLogger(ChatClientMediator);

	[Inject]
	public var view:ChatClient;

	[Inject]
	public var communicators:ICommunicatorFactory;

	override public function initializeComplete():void
	{
		view.communicatorsTabs.dataProvider = new ListCollection();
		view.communicatorsTabs.itemRendererProperties.tabFactoryFunc = tabFactoryFunction;
//		view.communicatorsTabs.tabInitializer = tabInitializer;

		view.containerView.communicatorFactory.setViewClass(DirectCommunicatorView, CommunicatorType.DIRECT);
		view.containerView.communicatorFactory.setViewClass(MUCCommunicatorView, CommunicatorType.MUC);

		setTabs();

		mapStarlingEvent(view.communicatorsTabs, Event.CHANGE, tabsView_onChange);

		communicators.addEventListener(CommunicatorFactoryEvent.COMMUNICATOR_ACTIVATED, model_handleActivation);
		communicators.addEventListener(CommunicatorFactoryEvent.COMMUNICATOR_DEACTIVATED, model_handleActivation);
	}

	override public function destroy():void
	{
		super.destroy();

		communicators.removeEventListener(CommunicatorFactoryEvent.COMMUNICATOR_ACTIVATED, model_handleActivation);
		communicators.removeEventListener(CommunicatorFactoryEvent.COMMUNICATOR_DEACTIVATED, model_handleActivation);
	}

	protected function tabFactoryFunction(communicator:ICommunicator):DefaultCommunicatorTabView
	{
		var tab:DefaultCommunicatorTabView;

		switch (communicator.type)
		{
			case CommunicatorType.DIRECT:
				tab = new DirectCommunicatorTabView();
				break;
			case CommunicatorType.MUC:
				tab = new DirectCommunicatorTabView();
				break;
			default :
				tab = new DefaultCommunicatorTabView();
				break;
		}

		tab.provider.data = communicator;

		return tab;
	}

	private function setTabs():void
	{
		var iCommunicators:Vector.<ICommunicator> = communicators.getAll();

		for each (var communicator:ICommunicator in iCommunicators)
			if (communicator.active)
				addTab(communicator);
	}

	private function addTab(communicator:ICommunicator):void
	{
		view.communicatorsTabs.dataProvider.addItem(communicator);
	}

	private function removeTab(communicator:ICommunicator):void
	{
		var index:int = view.communicatorsTabs.dataProvider.getItemIndex(communicator);
		view.communicatorsTabs.dataProvider.removeItemAt(index);
	}

	private function model_handleActivation(event:CommunicatorFactoryEvent):void
	{
		switch (event.type)
		{
			case CommunicatorFactoryEvent.COMMUNICATOR_ACTIVATED:
				addTab(event.data as ICommunicator);
				break;
			case CommunicatorFactoryEvent.COMMUNICATOR_DEACTIVATED:
				removeTab(event.data as ICommunicator);
				break;
		}

		view.communicatorsTabs.validate();
		setCommunicatorView();
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
