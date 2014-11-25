/**
 * Created by kuts on 11/25/14.
 */
package com.scifi.view.chat.user.actions
{
import feathers.controls.Button;
import feathers.controls.ButtonGroup;
import feathers.controls.LayoutGroup;
import feathers.skins.IStyleProvider;

public class UserActionsView extends LayoutGroup
{
	public static const CHILD_USER_ACTIONS_BUTTONS_GROUP:String = "child-user-actions-buttons-group";
	public static const CHILD_USER_ACTIONS_BUTTON:String = "child-user-actions-buttons-group";

	private var _actionsButtons:ButtonGroup = new ButtonGroup();

	private var _data:Object;

	public function UserActionsView(data:Object)
	{
		_data = data;
	}

	public static var globalStyleProvider:IStyleProvider;

	override protected function get defaultStyleProvider():IStyleProvider
	{
	    return globalStyleProvider;
	}

	public function actionButtonFactory():Button
	{
		var button:Button = new Button();
		button.styleNameList.add(CHILD_USER_ACTIONS_BUTTON);
		return button;
	}

	override protected function initialize():void
	{
		super.initialize();

		actionsButtons.styleNameList.add(CHILD_USER_ACTIONS_BUTTONS_GROUP);

		addChild(actionsButtons);
	}

	public function get actionsButtons():ButtonGroup
	{
		return _actionsButtons;
	}

	public function get data():Object
	{
		return _data;
	}
}
}
