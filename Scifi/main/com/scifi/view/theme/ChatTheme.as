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
import com.scifi.view.chat.communicator.types.DefaultCommunicatorView;
import com.scifi.view.chat.communicator.types.DirectCommunicatorView;
import com.scifi.view.chat.communicator.types.HistoryCommunicatorView;
	import com.scifi.view.chat.communicator.types.MUCCommunicatorView;
	import com.scifi.view.chat.communicator.types.WritableCommunicatorView;
import com.scifi.view.chat.roster.RosterView;
import com.scifi.view.chat.tabs.CommunicatorTabContainerView;
import com.scifi.view.chat.tabs.types.DefaultCommunicatorTabView;
import com.scifi.view.chat.tabs.types.DirectCommunicatorTabView;
import com.scifi.view.screens.game.GameView;
import com.scifi.view.utils.UIUtils;

import feathers.controls.ButtonGroup;
import feathers.controls.Label;
import feathers.controls.List;
import feathers.controls.TabBar;
import feathers.display.Scale9Image;
import feathers.layout.AnchorLayout;
import feathers.layout.AnchorLayoutData;
import feathers.layout.VerticalLayout;
import feathers.themes.MetalWorksDesktopTheme;

import flash.text.engine.CFFHinting;
import flash.text.engine.FontDescription;
import flash.text.engine.FontLookup;
import flash.text.engine.FontPosture;
import flash.text.engine.FontWeight;
import flash.text.engine.RenderingMode;

import starling.core.Starling;
import starling.display.Quad;

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
		getStyleProviderForClass(DirectCommunicatorTabView).defaultStyleFunction = setDirectCommunicatorTabStyles;
		getStyleProviderForClass(MUCCommunicatorView).defaultStyleFunction = setMUCCommunicatorStyles;

		getStyleProviderForClass(TabBar).setFunctionForStyleName(ChatView.CHILD_COMMUNICATORS_TABS, setChatViewCommunicatorsTabsStyles)
		getStyleProviderForClass(List).setFunctionForStyleName(HistoryCommunicatorView.CHILD_COMMUNICATOR_EVENTS_LIST, setCommunicatorsEventsListStyles)
		getStyleProviderForClass(Label).setFunctionForStyleName(DirectCommunicatorTabView.CHILD_COMMUNICATOR_TAB_NAME_LABEL, setCommunicatorTabNameLabelStyles)
		getStyleProviderForClass(Label).setFunctionForStyleName(DirectCommunicatorTabView.CHILD_COMMUNICATOR_TAB_COUNT_LABEL, setCommunicatorTabCountLabelStyles)
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
	}

	private function setDefaultCommunicatorTabStyles(view:DefaultCommunicatorTabView):void
	{
		setButtonStyles(view);
	}

	private function setDirectCommunicatorTabStyles(view:DirectCommunicatorTabView):void
	{
		setDefaultCommunicatorTabStyles(view);
	}

	private function setChatViewCommunicatorsTabsStyles(tabs:TabBar):void
	{
		setTabBarStyles(tabs);

		tabs.tabFactory = function ():CommunicatorTabContainerView
		{
			return new CommunicatorTabContainerView();
		};

		tabs.horizontalAlign = TabBar.HORIZONTAL_ALIGN_CENTER;
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
		rosterView.right = 0;

		view.rosterView.layoutData = rosterView;

		view.rosterView.width = 100;

		var chatView:AnchorLayoutData = new AnchorLayoutData();

		chatView.left = 0;
		chatView.topAnchorDisplayObject = view.loginButtons;
		chatView.top = 0;
		chatView.rightAnchorDisplayObject = view.rosterView;
		chatView.right = 0;
		chatView.bottom = 0;

		view.chatView.layoutData = chatView;
	}

	private function setChatViewStyles(view:ChatView):void
	{
		view.layout = new AnchorLayout();

		var containerView:AnchorLayoutData = new AnchorLayoutData();

		containerView.top = 0;
		containerView.percentWidth = 100;
		containerView.bottomAnchorDisplayObject = view.tabsView;
		containerView.bottom = 0;

		view.containerView.layoutData = containerView;

		var tabsView:AnchorLayoutData = new AnchorLayoutData();

		tabsView.percentWidth = 100;
		tabsView.bottom = 0;

		view.tabsView.layoutData = tabsView;
	}

	private function setRosterViewStyles(view:RosterView):void
	{
		view.layout = new AnchorLayout();

		var list:AnchorLayoutData = new AnchorLayoutData();

		list.percentWidth = 100;

		view.list.layoutData = list;
	}

}
}
