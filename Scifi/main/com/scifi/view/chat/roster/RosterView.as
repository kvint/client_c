/**
 * Created by AlexanderSla on 03.11.2014.
 */
package com.scifi.view.chat.roster
{
import feathers.controls.Label;
import feathers.controls.LayoutGroup;
import feathers.controls.List;
import feathers.skins.IStyleProvider;

public class RosterView extends LayoutGroup
{
	private var _friendsLabel:Label = new Label();
	private var _requestsLabel:Label = new Label();
	private var _outLabel:Label = new Label();
	private var _requestsList:List = new List();
	private var _friendsList:List = new List();
	private var _outList:List = new List();

	public static var globalStyleProvider:IStyleProvider;

	override protected function get defaultStyleProvider():IStyleProvider
	{
	    return globalStyleProvider;
	}

	override protected function initialize():void
	{
		addChild(friendsLabel);
		addChild(friendsList);
		addChild(requestsLabel);
		addChild(requestsList);
		addChild(outLabel);
		addChild(outList);
	}

	public function get friendsList():List
	{
		return _friendsList;
	}

	public function get requestsList():List
	{
		return _requestsList;
	}

	public function get requestsLabel():Label
	{
		return _requestsLabel;
	}

	public function get friendsLabel():Label
	{
		return _friendsLabel;
	}

	public function get outList():List
	{
		return _outList;
	}

	public function get outLabel():Label
	{
		return _outLabel;
	}
}
}
