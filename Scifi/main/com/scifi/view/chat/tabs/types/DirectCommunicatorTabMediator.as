/**
 * Created by kuts on 11/8/14.
 */
package com.scifi.view.chat.tabs.types
{
import robotlegs.extensions.starlingFeathers.impl.FeathersMediator;

public class DirectCommunicatorTabMediator extends FeathersMediator
{
	[Inject]
	public var view:DirectCommunicatorTabView;

	override public function initializeComplete():void
	{
		super.initializeComplete();

		view.label = "AWD";
	}

	override public function destroy():void
	{
		super.destroy();
	}
}
}
