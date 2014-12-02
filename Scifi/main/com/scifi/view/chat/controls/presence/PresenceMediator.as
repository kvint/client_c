/**
 * Created by kuts on 11/25/14.
 */
package com.scifi.view.chat.controls.presence
{
import robotlegs.extensions.starlingFeathers.impl.FeathersMediator;

public class PresenceMediator extends FeathersMediator
{
	[Inject]
	public var view:PresenceView;

	override public function initializeComplete():void
	{
		super.initializeComplete();

		setStatus();

		view.statusProvider.subscribe(statusProvider_onDataChange);
	}

	private function setStatus():void
	{
		view.statusQuad.color = view.statusColors[view.statusProvider.data];
	}

	override public function destroy():void
	{
		view.statusProvider.unsubscribe(statusProvider_onDataChange);

		super.destroy();
	}

	private function statusProvider_onDataChange():void
	{
		setStatus();
	}
}
}
