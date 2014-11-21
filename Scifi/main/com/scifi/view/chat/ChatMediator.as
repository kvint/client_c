/**
 * Created by kvint on 01.11.14.
 */
package com.scifi.view.chat
{
import com.chat.IChat;
import com.chat.events.CommunicatorFactoryEvent;
import com.chat.model.communicators.CommunicatorType;
import com.chat.model.communicators.ICommunicator;
	import com.chat.model.communicators.ICommunicatorFactory;
	import com.scifi.view.chat.communicator.types.direct.DirectCommunicatorView;
import com.scifi.view.chat.communicator.types.muc.MUCCommunicatorView;
import com.scifi.view.chat.tabs.CommunicatorTabContainerView;
import com.scifi.view.chat.tabs.types.DefaultCommunicatorTabView;
import com.scifi.view.chat.tabs.types.DirectCommunicatorTabView;

import feathers.controls.TabBar;

import feathers.data.ListCollection;

import flash.utils.setTimeout;

import org.as3commons.logging.api.ILogger;

import org.as3commons.logging.api.getLogger;

import robotlegs.extensions.starlingFeathers.impl.FeathersMediator;

import starling.events.Event;

public class ChatMediator extends FeathersMediator
{
	private static const log:ILogger = getLogger(ChatMediator);

	[Inject]
	public var view:ChatView;

	[Inject]
	public var communicators:ICommunicatorFactory;

	override public function initializeComplete():void
	{
		view.communicatorsTabs.dataProvider = new ListCollection();
		view.communicatorsTabs.tabInitializer = tabInitializer;

		view.containerView.communicatorFactory.setViewClass(DirectCommunicatorView, CommunicatorType.DIRECT);
		view.containerView.communicatorFactory.setViewClass(MUCCommunicatorView, CommunicatorType.MUC);

		setTabs();

		mapStarlingEvent(view.communicatorsTabs, Event.CHANGE, tabsView_onChange);

		communicators.addEventListener(CommunicatorFactoryEvent.COMMUNICATOR_ACTIVATED, model_handleActivation);
		communicators.addEventListener(CommunicatorFactoryEvent.COMMUNICATOR_DEACTIVATED, model_handleActivation);

		test();
	}

	private function test():void
	{
		/*var tabs:TabBar = new TabBar();
		view.addChild(tabs);
		tabs.dataProvider = new ListCollection();
		tabs.addEventListener(Event.CHANGE, handleChange);

		setTimeout(function ():void
		{
			tabs.dataProvider.addItem({ label: "One"});
			tabs.validate();
		}, 1000);

		function handleChange(event:Event):void
		{
			trace("Change");
		}*/

		/*tabs.dataProvider.addItem({ label: "Two"});
		tabs.dataProvider.addItem({ label: "Three"});

		tabs.selectedIndex = 1;
		tabs.validate();

		trace(tabs.selectedItem.label); // output: "Two". Ok

		tabs.dataProvider.removeItemAt(1);

		tabs.validate();
		trace(tabs.selectedItem.label);*/ // output: "Three". Change handler NOT firing

//		trace(tabs.selectedIndex); // output: "-1". Ok


//		tabs.validate();

//		trace(tabs.selectedIndex); // output: "0". Change handler NOT firing

		/*trace(tabs.selectedIndex); // output: "0". Change handler NOT firing

		tabs.dataProvider.addItem({ label: "Two"});
		tabs.dataProvider.addItem({ label: "Three"});

		tabs.validate();

		trace(tabs.selectedItem.label); // output: "One". Ok

		tabs.dataProvider.removeItemAt(0);

		tabs.validate();

		trace(tabs.selectedItem.label); // output: "Two". Same index but other item. Change handler NOT firing

		tabs.selectedIndex = 1;

		tabs.validate();

		trace(tabs.selectedItem.label); // output: "Three". Change handler firing.

		tabs.dataProvider.removeItemAt(1);

		tabs.validate();

		trace(tabs.selectedItem.label); // output: "Two". Change handler NOT firing*/
	}

	override public function destroy():void
	{
		super.destroy();

		communicators.removeEventListener(CommunicatorFactoryEvent.COMMUNICATOR_ACTIVATED, model_handleActivation);
		communicators.removeEventListener(CommunicatorFactoryEvent.COMMUNICATOR_DEACTIVATED, model_handleActivation);
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
