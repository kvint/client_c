/**
 * Created by kvint on 02.11.14.
 */
package com.scifi.view.chat.communicator.types
{
import feathers.controls.List;
import feathers.skins.IStyleProvider;

public class HistoryCommunicatorView extends DefaultCommunicatorView
{
	public static const CHILD_COMMUNICATOR_EVENTS_LIST:String = "child-communicator-event-list";

	private var _eventsList:List = new List();

	public static var globalStyleProvider:IStyleProvider;

	override protected function get defaultStyleProvider():IStyleProvider
	{
	    return globalStyleProvider;
	}

	public function get eventsList():List
	{
		return _eventsList;
	}

	override protected function initialize():void
	{
		eventsList.styleNameList.add(CHILD_COMMUNICATOR_EVENTS_LIST);
		addChild(eventsList);
	}
}
}
