/**
 * Created by kuts on 11/8/14.
 */
package com.scifi.view.chat.tabs.types
{
	import model.communicators.ICommunicator;

	import robotlegs.extensions.starlingFeathers.impl.FeathersMediator;

public class DirectCommunicatorTabMediator extends FeathersMediator
{
	[Inject]
	public var view:DirectCommunicatorTabView;

	override public function initializeComplete():void
	{
		super.initializeComplete();

		var iCommunicator:ICommunicator = view.provider.data as ICommunicator;
		view.label = iCommunicator.label;
	}

	override public function destroy():void
	{
		super.destroy();
	}
}
}
