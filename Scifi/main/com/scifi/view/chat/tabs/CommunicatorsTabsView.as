/**
 * Created by kuts on 11/7/14.
 */
package com.scifi.view.chat.tabs
{
import feathers.controls.TabBar;
import feathers.skins.IStyleProvider;

public class CommunicatorsTabsView extends TabBar
{
	public static var globalStyleProvider:IStyleProvider;

	override protected function get defaultStyleProvider():IStyleProvider
	{
	    return globalStyleProvider;
	}

}
}
