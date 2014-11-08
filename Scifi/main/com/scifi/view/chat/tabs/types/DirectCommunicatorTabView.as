/**
 * Created by kuts on 11/8/14.
 */
package com.scifi.view.chat.tabs.types
{
import feathers.skins.IStyleProvider;

public class DirectCommunicatorTabView extends DefaultCommunicatorTabView
{
	public static var globalStyleProvider:IStyleProvider;

	override protected function get defaultStyleProvider():IStyleProvider
	{
	    return globalStyleProvider;
	}

	public function DirectCommunicatorTabView()
	{
		super();
	}
}
}
