/*
 Copyright (c) 2014 Josh Tynjala

 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:

 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
 */
package com.scifi.view.theme
{

import com.scifi.view.chat.ChatView;
import com.scifi.view.chat.communicator.types.base.DefaultCommunicatorView;
import com.scifi.view.chat.communicator.types.direct.DirectCommunicatorView;
import com.scifi.view.chat.communicator.types.history.HistoryCommunicatorView;
import com.scifi.view.chat.communicator.types.muc.MUCCommunicatorView;
import com.scifi.view.chat.communicator.types.muc.users.MUCUserActionsView;
import com.scifi.view.chat.communicator.types.muc.users.MUCUsersView;
import com.scifi.view.chat.communicator.types.writable.WritableCommunicatorView;
import com.scifi.view.chat.user.actions.UserActionsView;
import com.scifi.view.chat.user.presence.PresenceView;
import com.scifi.view.chat.roster.RosterView;
import com.scifi.view.chat.tabs.CommunicatorTabContainerView;
import com.scifi.view.chat.tabs.types.DefaultCommunicatorTabView;
import com.scifi.view.screens.game.GameView;
import com.scifi.view.utils.UIUtils;

import feathers.controls.Button;

import feathers.controls.ButtonGroup;
import feathers.controls.Label;
import feathers.controls.List;
import feathers.controls.TabBar;
import feathers.display.Scale9Image;
import feathers.layout.AnchorLayout;
import feathers.layout.AnchorLayoutData;
import feathers.layout.HorizontalLayout;
import feathers.layout.VerticalLayout;
import feathers.themes.MetalWorksDesktopTheme;

import flash.text.engine.CFFHinting;
import flash.text.engine.FontDescription;
import flash.text.engine.FontLookup;
import flash.text.engine.FontPosture;
import flash.text.engine.FontWeight;
import flash.text.engine.RenderingMode;

import starling.core.Starling;

public class ChatTheme extends MetalWorksDesktopTheme
{
	[Embed(source="assets/Play-Regular.ttf", fontFamily="Play", fontWeight="normal", mimeType="application/x-font", embedAsCFF="true")]
	public static var FONT_PLAY_REGULAR:Class;

	public static const CUSTOM_FONT_NAME:String = "Play";

	override protected function initializeStage():void
	{
		Starling.current.stage.color = 0x000000;
		Starling.current.nativeStage.color = 0x000000;
	}

	override protected function initializeDimensions():void
	{
		super.initializeDimensions();

		buttonMinWidth = gutterSize;
	}

	override protected function initializeFonts():void
	{
		super.initializeFonts();

		regularFontDescription = new FontDescription(CUSTOM_FONT_NAME, FontWeight.NORMAL, FontPosture.NORMAL, FontLookup.EMBEDDED_CFF, RenderingMode.CFF, CFFHinting.NONE);
		boldFontDescription = new FontDescription(CUSTOM_FONT_NAME, FontWeight.BOLD, FontPosture.NORMAL, FontLookup.EMBEDDED_CFF, RenderingMode.CFF, CFFHinting.NONE);
	}

	override protected function initializeStyleProviders():void
	{
		super.initializeStyleProviders();

		getStyleProviderForClass(GameView).defaultStyleFunction = setGameViewStyles;
		getStyleProviderForClass(ChatView).defaultStyleFunction = setChatViewStyles;
		getStyleProviderForClass(RosterView).defaultStyleFunction = setRosterViewStyles;

		getStyleProviderForClass(HistoryCommunicatorView).defaultStyleFunction = setHistoryCommunicatorStyles;
		getStyleProviderForClass(WritableCommunicatorView).defaultStyleFunction = setWritableCommunicatorStyles;
		getStyleProviderForClass(DirectCommunicatorView).defaultStyleFunction = setDirectCommunicatorStyles;
		getStyleProviderForClass(DefaultCommunicatorTabView).defaultStyleFunction = setDefaultCommunicatorTabStyles;
		getStyleProviderForClass(MUCCommunicatorView).defaultStyleFunction = setMUCCommunicatorStyles;
		getStyleProviderForClass(MUCUsersView).defaultStyleFunction = setMUCUsersViewStyles;
		getStyleProviderForClass(MUCUserActionsView).defaultStyleFunction = setMUCUserActionsViewStyles;
		getStyleProviderForClass(PresenceView).defaultStyleFunction = setPresenceViewStyles;
		getStyleProviderForClass(UserActionsView).defaultStyleFunction = setUserActionsViewStyles;

		getStyleProviderForClass(List).setFunctionForStyleName(HistoryCommunicatorView.CHILD_COMMUNICATOR_EVENTS_LIST, setCommunicatorsEventsListStyles)
		getStyleProviderForClass(Label).setFunctionForStyleName(DefaultCommunicatorTabView.CHILD_COMMUNICATOR_TAB_NAME_LABEL, setCommunicatorTabNameLabelStyles)
		getStyleProviderForClass(Label).setFunctionForStyleName(DefaultCommunicatorTabView.CHILD_COMMUNICATOR_TAB_COUNT_LABEL, setCommunicatorTabCountLabelStyles)
		getStyleProviderForClass(TabBar).setFunctionForStyleName(ChatView.CHILD_COMMUNICATORS_TABS, setCommunicatorsTabsStyles)
		getStyleProviderForClass(ButtonGroup).setFunctionForStyleName(UserActionsView.CHILD_USER_ACTIONS_BUTTONS_GROUP, setUserActionsViewButtonsGroupStyles)
		getStyleProviderForClass(Button).setFunctionForStyleName(UserActionsView.CHILD_USER_ACTIONS_BUTTON, setUserActionsViewButtonStyles)
	}

	private function setUserActionsViewButtonStyles(button:Button):void
	{
		setButtonStyles(button);
	}

	private function setUserActionsViewButtonsGroupStyles(buttons:ButtonGroup):void
	{
		setButtonGroupStyles(buttons);

		buttons.direction = ButtonGroup.DIRECTION_HORIZONTAL;
		buttons.distributeButtonSizes = false;
		buttons.minWidth = 10;
	}

	private function setUserActionsViewStyles(view:UserActionsView):void
	{
		const hLayout:HorizontalLayout = new HorizontalLayout();

		hLayout.verticalAlign = HorizontalLayout.VERTICAL_ALIGN_MIDDLE;
		hLayout.gap = smallGutterSize;

		view.layout = hLayout;
	}

	private function setPresenceViewStyles(view:PresenceView):void
	{
		view.layout = new AnchorLayout();

		view.minWidth = 10;
		view.minHeight = 10;
	}

	private function setMUCUserActionsViewStyles(view:MUCUserActionsView):void
	{
		const layout:HorizontalLayout = new HorizontalLayout();
		view.layout = layout;
		view.actionsButtons.direction = ButtonGroup.DIRECTION_HORIZONTAL;
	}

	private function setMUCUsersViewStyles(view:MUCUsersView):void
	{
		setListStyles(view);

		view.width = 200;
	}

	private function setCommunicatorTabCountLabelStyles(label:Label):void
	{
		setLabelStyles(label);

		label.backgroundSkin = new Scale9Image(UIUtils.getScale9RectTexture(6, 6, 0x222222));
		label.padding = extraSmallGutterSize;
	}

	private function setCommunicatorTabNameLabelStyles(label:Label):void
	{
		setLabelStyles(label);
	}

	private function setDefaultCommunicatorStyles(view:DefaultCommunicatorView):void
	{
		view.layout = new AnchorLayout();
	}

	private function setHistoryCommunicatorStyles(view:HistoryCommunicatorView):void
	{
		setDefaultCommunicatorStyles(view);

		var eventsList:AnchorLayoutData = new AnchorLayoutData();

		eventsList.percentWidth = 100;
		eventsList.percentHeight = 100;

		view.eventsList.layoutData = eventsList;
	}

	private function setWritableCommunicatorStyles(view:WritableCommunicatorView):void
	{
		setDefaultCommunicatorStyles(view);

		var eventsList:AnchorLayoutData = new AnchorLayoutData();

		eventsList.top = 0;
		eventsList.percentWidth = 100;
		eventsList.bottomAnchorDisplayObject = view.messageInput;
		eventsList.bottom = 0;

		view.eventsList.layoutData = eventsList;

		var messageInput:AnchorLayoutData = new AnchorLayoutData();

		messageInput.percentWidth = 100;
		messageInput.bottom = 0;

		view.messageInput.layoutData = messageInput;
	}

	private function setDirectCommunicatorStyles(view:DirectCommunicatorView):void
	{
		setWritableCommunicatorStyles(view);
	}

	private function setMUCCommunicatorStyles(view:MUCCommunicatorView):void
	{
		setWritableCommunicatorStyles(view);

		var usersView:AnchorLayoutData = new AnchorLayoutData();

		usersView.top = 0;
		usersView.right = 0;

		view.usersView.layoutData = usersView;
	}

	private function setDefaultCommunicatorTabStyles(view:DefaultCommunicatorTabView):void
	{
		setButtonStyles(view);
	}

	private function setCommunicatorsEventsListStyles(list:List):void
	{
		setListStyles(list);

		const layout:VerticalLayout = new VerticalLayout();

		layout.hasVariableItemDimensions = true;
		layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_JUSTIFY;
		layout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_BOTTOM;

		list.layout = layout;
	}

	private function setGameViewStyles(view:GameView):void
	{
		view.backgroundSkin = new Scale9Image(UIUtils.getScale9RectTexture(6, 6, 0xf332233));

		view.layout = new AnchorLayout();

		var loginButtons:AnchorLayoutData = new AnchorLayoutData();

		loginButtons.percentWidth = 100;

		view.loginButtons.layoutData = loginButtons;

		view.loginButtons.direction = ButtonGroup.DIRECTION_HORIZONTAL;

		var rosterView:AnchorLayoutData = new AnchorLayoutData();

		rosterView.topAnchorDisplayObject = view.loginButtons;
		rosterView.top = 0;
		rosterView.left = 0;

		view.rosterView.layoutData = rosterView;

		var chatView:AnchorLayoutData = new AnchorLayoutData();

		chatView.percentWidth = 100;
		chatView.topAnchorDisplayObject = view.loginButtons;
		chatView.top = 0;
		chatView.bottom = 0;

		view.chatView.layoutData = chatView;
	}

	private function setChatViewStyles(view:ChatView):void
	{
		view.layout = new AnchorLayout();

		var containerView:AnchorLayoutData = new AnchorLayoutData();

		containerView.top = 0;
		containerView.percentWidth = 100;
		containerView.bottomAnchorDisplayObject = view.communicatorsTabs;
		containerView.bottom = 0;

		view.containerView.layoutData = containerView;

		var tabsView:AnchorLayoutData = new AnchorLayoutData();

		tabsView.percentWidth = 100;
		tabsView.bottom = 0;

		view.communicatorsTabs.layoutData = tabsView;
	}

	private function setCommunicatorsTabsStyles(tabs:TabBar):void
	{
		setTabBarStyles(tabs);

		tabs.tabFactory = function ():CommunicatorTabContainerView
		{
			return new CommunicatorTabContainerView();
		};

		tabs.horizontalAlign = TabBar.HORIZONTAL_ALIGN_CENTER;
		tabs.distributeTabSizes = false;
	}

	private function setRosterViewStyles(view:RosterView):void
	{
		view.layout = new AnchorLayout();

		var friendsLabel:AnchorLayoutData = new AnchorLayoutData();
		view.friendsLabel.layoutData = friendsLabel;

		var friendsList:AnchorLayoutData = new AnchorLayoutData();

		friendsList.topAnchorDisplayObject = view.friendsLabel;
		friendsList.top = smallGutterSize;
		friendsList.percentWidth = 100;

		view.friendsList.layoutData = friendsList;

		var requestsLabel:AnchorLayoutData = new AnchorLayoutData();

		requestsLabel.topAnchorDisplayObject = view.friendsList;
		requestsLabel.top = gutterSize;

		view.requestsLabel.layoutData = requestsLabel;

		var requestsList:AnchorLayoutData = new AnchorLayoutData();

		requestsList.topAnchorDisplayObject = view.requestsLabel;
		requestsList.top = smallGutterSize;
		requestsList.percentWidth = 100;

		view.requestsList.layoutData = requestsList;

		view.minWidth = 200;
	}

}
}
