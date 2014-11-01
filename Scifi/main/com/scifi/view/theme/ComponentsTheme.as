/*
 Copyright (c) 2012 Josh Tynjala

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
package com.scifi.view.theme{

import com.scifi.view.assets.Assets;
import com.scifi.view.utils.UIUtils;

import feathers.controls.Alert;
import feathers.controls.Button;
import feathers.controls.ButtonGroup;
import feathers.controls.Callout;
import feathers.controls.Check;
import feathers.controls.GroupedList;
import feathers.controls.Header;
import feathers.controls.IScrollBar;
import feathers.controls.Label;
import feathers.controls.List;
import feathers.controls.NumericStepper;
import feathers.controls.PageIndicator;
import feathers.controls.Panel;
import feathers.controls.PanelScreen;
import feathers.controls.PickerList;
import feathers.controls.ProgressBar;
import feathers.controls.Radio;
import feathers.controls.Screen;
import feathers.controls.ScrollBar;
import feathers.controls.ScrollContainer;
import feathers.controls.ScrollText;
import feathers.controls.Scroller;
import feathers.controls.SimpleScrollBar;
import feathers.controls.Slider;
import feathers.controls.TabBar;
import feathers.controls.TextArea;
import feathers.controls.TextInput;
import feathers.controls.ToggleSwitch;
import feathers.controls.popups.CalloutPopUpContentManager;
import feathers.controls.renderers.BaseDefaultItemRenderer;
import feathers.controls.renderers.DefaultGroupedListHeaderOrFooterRenderer;
import feathers.controls.renderers.DefaultGroupedListItemRenderer;
import feathers.controls.renderers.DefaultListItemRenderer;
import feathers.controls.text.BitmapFontTextRenderer;
import feathers.controls.text.TextFieldTextEditor;
import feathers.controls.text.TextFieldTextRenderer;
import feathers.core.DisplayListWatcher;
import feathers.core.FeathersControl;
import feathers.core.ITextEditor;
import feathers.core.ITextRenderer;
import feathers.display.Scale3Image;
import feathers.display.Scale9Image;
import feathers.layout.HorizontalLayout;
import feathers.layout.VerticalLayout;
import feathers.skins.SmartDisplayObjectStateValueSelector;
import feathers.skins.StandardIcons;
import feathers.textures.Scale3Textures;
import feathers.textures.Scale9Textures;
import flash.display.BitmapData;
import flash.geom.Rectangle;
import flash.ui.Keyboard;
import org.as3commons.lang.StringUtils;
import starling.core.Starling;
import starling.display.DisplayObject;
import starling.display.Image;
import starling.display.Quad;
import starling.events.Event;
import starling.textures.Texture;
import starling.textures.TextureAtlas;
import starling.utils.AssetManager;

public class ComponentsTheme extends DisplayListWatcher
{
	public static const ASSETS_IMAGES_EXTENSION									:String 			= ".png";

	public static const THEME_NAME_HORIZONTAL_SCROLL_BAR_INCREMENT_BUTTON		:String 			= "aeon-horizontal-scroll-bar-increment-button";
	public static const THEME_NAME_HORIZONTAL_SCROLL_BAR_DECREMENT_BUTTON		:String 			= "aeon-horizontal-scroll-bar-decrement-button";
	public static const THEME_NAME_HORIZONTAL_SCROLL_BAR_THUMB					:String 			= "aeon-horizontal-scroll-bar-thumb";
	public static const THEME_NAME_HORIZONTAL_SCROLL_BAR_MINIMUM_TRACK			:String 			= "aeon-horizontal-scroll-bar-minimum-track";

	public static const THEME_NAME_VERTICAL_SCROLL_BAR_INCREMENT_BUTTON			:String 			= "aeon-vertical-scroll-bar-increment-button";
	public static const THEME_NAME_VERTICAL_SCROLL_BAR_DECREMENT_BUTTON			:String 			= "aeon-vertical-scroll-bar-decrement-button";
	public static const THEME_NAME_VERTICAL_SCROLL_BAR_THUMB					:String 			= "aeon-vertical-scroll-bar-thumb";
	public static const THEME_NAME_VERTICAL_SCROLL_BAR_MINIMUM_TRACK			:String 			= "aeon-vertical-scroll-bar-minimum-track";

	public static const THEME_NAME_HORIZONTAL_SIMPLE_SCROLL_BAR_THUMB			:String 			= "aeon-horizontal-simple-scroll-bar-thumb";
	public static const THEME_NAME_VERTICAL_SIMPLE_SCROLL_BAR_THUMB				:String 			= "aeon-vertical-simple-scroll-bar-thumb";

	public static const THEME_NAME_HORIZONTAL_SLIDER_THUMB						:String 			= "aeon-horizontal-slider-thumb";
	public static const THEME_NAME_HORIZONTAL_SLIDER_MINIMUM_TRACK				:String 			= "aeon-horizontal-slider-minimum-track";

	public static const THEME_NAME_VERTICAL_SLIDER_THUMB						:String 			= "aeon-vertical-slider-thumb";
	public static const THEME_NAME_VERTICAL_SLIDER_MINIMUM_TRACK				:String 			= "aeon-vertical-slider-minimum-track";

	public static const THEME_NAME_PICKER_LIST_CALLOUT							:String 			= "scifi-picker-list-callout";

//	[Embed(source="assets/fonts/NettelbladtMiso.otf", fontName="MisoT", fontFamily = "MisoT", embedAsCFF = "false")]
//	public static var MISO_FONT													:Class;

	[Embed(source="assets/fonts/Play-Regular.ttf", fontName="MisoT", fontFamily = "MisoT", embedAsCFF = "false")]
	public static var MISO_FONT													:Class;

	protected static const FOCUS_INDICATOR_SCALE_9_GRID							:Rectangle 			= new Rectangle(5, 4, 1, 14);
	protected static const BUTTON_SCALE_9_GRID									:Rectangle 			= new Rectangle(3, 4, 18, 8);
	protected static const STEPPER_INCREMENT_BUTTON_SCALE_9_GRID				:Rectangle 			= new Rectangle(1, 9, 15, 1);
	protected static const STEPPER_DECREMENT_BUTTON_SCALE_9_GRID				:Rectangle 			= new Rectangle(1, 1, 15, 1);
	protected static const HSLIDER_FIRST_REGION									:Number 			= 2;
	protected static const HSLIDER_SECOND_REGION								:Number 			= 75;
	protected static const TEXT_INPUT_SCALE_9_GRID								:Rectangle 			= new Rectangle(4, 4, 16, 16);
	protected static const VERTICAL_SCROLL_BAR_THUMB_SCALE_9_GRID				:Rectangle 			= new Rectangle(2, 5, 6, 42);
	protected static const VERTICAL_SCROLL_BAR_TRACK_SCALE_9_GRID				:Rectangle 			= new Rectangle(2, 1, 11, 2);
	protected static const VERTICAL_SCROLL_BAR_STEP_BUTTON_SCALE_9_GRID			:Rectangle 			= new Rectangle(2, 2, 11, 10);
	protected static const HORIZONTAL_SCROLL_BAR_THUMB_SCALE_9_GRID				:Rectangle 			= new Rectangle(5, 2, 42, 6);
	protected static const HORIZONTAL_SCROLL_BAR_TRACK_SCALE_9_GRID				:Rectangle 			= new Rectangle(1, 2, 2, 11);
	protected static const HORIZONTAL_SCROLL_BAR_STEP_BUTTON_SCALE_9_GRID		:Rectangle 			= new Rectangle(2, 2, 10, 11);
	protected static const SIMPLE_BORDER_SCALE_9_GRID							:Rectangle 			= new Rectangle(2, 2, 2, 2);
	protected static const PANEL_BORDER_SCALE_9_GRID							:Rectangle 			= new Rectangle(6, 6, 2, 2);
	protected static const CALLOUT_BACKGROUND_SCALE_9_GRID						:Rectangle 			= new Rectangle(1, 1, 6, 6);
	protected static const HEADER_SCALE_9_GRID									:Rectangle 			= new Rectangle(0, 0, 4, 28);

	protected static const DROP_DOWN_MENU_BACKGROUND_SCALE_9_GRID				:Rectangle 			= new Rectangle(2, 2, 20, 20);

	protected static const PROGRESS_BAR_BACKGROUND_SCALE_9_GRID					:Rectangle 			= new Rectangle(1, 1, 2, 2);
	protected static const PROGRESS_BAR_FILL_SCALE_9_GRID						:Rectangle 			= new Rectangle(1, 1, 2, 2);

	protected static const MODULE_DEFAULT_BACKGROUND_SCALE_9_GRID				:Rectangle 			= new Rectangle(3, 3, 5, 5);
	protected static const MODULE_DEFAULT_BORDER_SCALE_9_GRID					:Rectangle 			= new Rectangle(5, 5, 22, 22);

	protected static const LIST_ITEM_RENDERER_SCALE_9_GRID						:Rectangle 			= new Rectangle(1, 1, 6, 6);

	protected static const TOGGLE_TRACK_BACKGROUND_SCALE_9_GRID					:Rectangle 			= new Rectangle(3, 3, 26, 8);
	protected static const TOGGLE_THUMB_SCALE_9_GRID							:Rectangle 			= new Rectangle(2, 2, 6, 6);

	protected static const SCROLL_BAR_THUMB_DEFAULT_SCALE_9_GRID				:Rectangle 			= new Rectangle(2, 2, 6, 6);
	protected static const SCROLL_BAR_TRACK_DEFAULT_SCALE_9_GRID				:Rectangle 			= new Rectangle(2, 2, 6, 6);

	protected var focusIndicatorSkinTextures									:Scale9Textures;

	protected var buttonUpSkinTextures											:Scale9Textures;
	protected var buttonHoverSkinTextures										:Scale9Textures;
	protected var buttonDownSkinTextures										:Scale9Textures;
	protected var buttonSelectedUpSkinTextures									:Scale9Textures;
	protected var buttonDisabledSkinTextures									:Scale9Textures;

	protected var tabDownSkinTextures											:Scale9Textures;
	protected var tabDisabledSkinTextures										:Scale9Textures;

	protected var stepperIncrementButtonUpSkinTextures							:Scale9Textures;
	protected var stepperIncrementButtonHoverSkinTextures						:Scale9Textures;
	protected var stepperIncrementButtonDownSkinTextures						:Scale9Textures;
	protected var stepperIncrementButtonDisabledSkinTextures					:Scale9Textures;

	protected var stepperDecrementButtonUpSkinTextures							:Scale9Textures;
	protected var stepperDecrementButtonHoverSkinTextures						:Scale9Textures;
	protected var stepperDecrementButtonDownSkinTextures						:Scale9Textures;
	protected var stepperDecrementButtonDisabledSkinTextures					:Scale9Textures;

	protected var hSliderThumbUpSkinTexture										:Texture;
	protected var hSliderThumbHoverSkinTexture									:Texture;
	protected var hSliderThumbDownSkinTexture									:Texture;
	protected var hSliderThumbDisabledSkinTexture								:Texture;
	protected var hSliderTrackSkinTextures										:Scale3Textures;

	protected var vSliderThumbUpSkinTexture										:Texture;
	protected var vSliderThumbHoverSkinTexture									:Texture;
	protected var vSliderThumbDownSkinTexture									:Texture;
	protected var vSliderThumbDisabledSkinTexture								:Texture;
	protected var vSliderTrackSkinTextures										:Scale3Textures;

	protected var scrollBarThumbDefaultSkin										:Scale9Textures;
	protected var scrollBarTrackDefaultSkin										:Scale9Textures;

	protected var listBackgroundSkinTexture										:Scale9Textures;
	protected var listItemRendererUpSkinTexture									:Scale9Textures;
	protected var listItemRendererHoverSkinTexture								:Scale9Textures;
	protected var listItemRendererSelectedUpSkinTexture							:Scale9Textures;

	protected var headerBackgroundSkinTextures									:Scale9Textures;
	protected var groupedListHeaderBackgroundSkinTextures						:Scale9Textures;

	protected var checkUpIconTexture											:Texture;
	protected var checkSelectedUpIconTexture									:Texture;
	protected var checkPartialSelectedUpIconTexture								:Texture;

	protected var radioUpIconTexture											:Texture;
	protected var radioSelectedUpIconTexture									:Texture;

	protected var pageIndicatorNormalSkinTexture								:Texture;
	protected var pageIndicatorSelectedSkinTexture								:Texture;

	protected var pickerListDefaultIconTexture									:Texture;

	protected var dropDownMenuBackgroundTexture									:Scale9Textures;

	protected var toggleSwitchTrackBackgroundTexture							:Scale9Textures;
	protected var toggleSwitchThumbDownTexture									:Scale9Textures;
	protected var toggleSwitchThumbDefaultTexture								:Scale9Textures;

	protected var textInputBackgroundSkinTextures								:Scale9Textures;
	protected var textInputBackgroundDisabledSkinTextures						:Scale9Textures;

	protected var vScrollBarThumbUpSkinTextures									:Scale9Textures;
	protected var vScrollBarThumbHoverSkinTextures								:Scale9Textures;
	protected var vScrollBarThumbDownSkinTextures								:Scale9Textures;
	protected var vScrollBarTrackSkinTextures									:Scale9Textures;
	protected var vScrollBarThumbIconTexture									:Texture;
	protected var vScrollBarStepButtonUpSkinTextures							:Scale9Textures;
	protected var vScrollBarStepButtonHoverSkinTextures							:Scale9Textures;
	protected var vScrollBarStepButtonDownSkinTextures							:Scale9Textures;
	protected var vScrollBarStepButtonDisabledSkinTextures						:Scale9Textures;
	protected var vScrollBarDecrementButtonIconTexture							:Texture;
	protected var vScrollBarIncrementButtonIconTexture							:Texture;

	protected var hScrollBarThumbUpSkinTextures									:Scale9Textures;
	protected var hScrollBarThumbHoverSkinTextures								:Scale9Textures;
	protected var hScrollBarThumbDownSkinTextures								:Scale9Textures;
	protected var hScrollBarTrackSkinTextures									:Scale9Textures;
	protected var hScrollBarThumbIconTexture									:Texture;
	protected var hScrollBarStepButtonUpSkinTextures							:Scale9Textures;
	protected var hScrollBarStepButtonHoverSkinTextures							:Scale9Textures;
	protected var hScrollBarStepButtonDownSkinTextures							:Scale9Textures;
	protected var hScrollBarStepButtonDisabledSkinTextures						:Scale9Textures;
	protected var hScrollBarDecrementButtonIconTexture							:Texture;
	protected var hScrollBarIncrementButtonIconTexture							:Texture;

	protected var simpleBorderBackgroundSkinTextures							:Scale9Textures;
	protected var panelBorderBackgroundSkinTextures								:Scale9Textures;

	protected var calloutBackgroundSkinTextures									:Scale9Textures;

	protected var progressBarBackgroundSkinTexture								:Scale9Textures;
	protected var progressBarFillSkinTexture									:Texture;

	protected var mapDarkBackgroundTexture										:Scale9Textures;

	protected var emptyTexture													:Texture;

	public function ComponentsTheme()
	{
		super(Starling.current.stage);
		new MISO_FONT();
	}

	public function init():void
	{
		FeathersControl.defaultTextRendererFactory = textRendererFactory;
		FeathersControl.defaultTextEditorFactory = textEditorFactory;

		Callout.stagePaddingTop = Callout.stagePaddingRight = Callout.stagePaddingBottom =
		Callout.stagePaddingLeft = 20;
	}

	protected static function textRendererFactory():ITextRenderer
	{
		var tfr:TextFieldTextRenderer = new TextFieldTextRenderer();

		ThemeUtils.fontEmbeddingWrap(tfr);

		return tfr;
	}

	protected static function textEditorFactory():ITextEditor
	{
		var tfe:TextFieldTextEditor = new TextFieldTextEditor();

		ThemeUtils.fontEmbeddingWrap(tfe);

		return tfe;
	}

	protected function scrollBarFactory():IScrollBar
	{
		var scrollBar:ScrollBar = new ScrollBar();
		return scrollBar;
	}

	///////////////////////////////////////////////// INITIALIZE ///////////////////////////////////////////////////

	protected function setTextures():void
	{
		this.focusIndicatorSkinTextures = new Scale9Textures(getTexture("focus-indicator-skin"), FOCUS_INDICATOR_SCALE_9_GRID);

		this.buttonUpSkinTextures = UIUtils.getScale9RectTexture(10, 10, 0x13171B);
		this.buttonHoverSkinTextures = UIUtils.getScale9RectTexture(10, 10, 0x191E23);
		this.buttonDownSkinTextures = UIUtils.getScale9RectTexture(10, 10, 0x749A96); //new Scale9Textures(getTexture("button-down-skin"), BUTTON_SCALE_9_GRID);
		this.buttonDisabledSkinTextures = UIUtils.getScale9RectTexture(10, 10, 0x20272E); //new Scale9Textures(getTexture("button-disabled-skin"), BUTTON_SCALE_9_GRID);
		this.buttonSelectedUpSkinTextures = buttonDownSkinTextures; //new Scale9Textures(getTexture("button-down-skin"), BUTTON_SCALE_9_GRID);

		this.tabDownSkinTextures = this.buttonDownSkinTextures;
		this.tabDisabledSkinTextures = this.buttonDisabledSkinTextures;

		this.toggleSwitchTrackBackgroundTexture = new Scale9Textures(getTexture("toggle-track-background-skin"), TOGGLE_TRACK_BACKGROUND_SCALE_9_GRID);
		this.toggleSwitchThumbDefaultTexture = new Scale9Textures(getTexture("toggle-thumb-default-skin"), TOGGLE_THUMB_SCALE_9_GRID);
		this.toggleSwitchThumbDownTexture = new Scale9Textures(getTexture("toggle-thumb-down-skin"), TOGGLE_THUMB_SCALE_9_GRID);

		this.stepperIncrementButtonUpSkinTextures = new Scale9Textures(getTexture("numeric-stepper-increment-button-up-skin"), STEPPER_INCREMENT_BUTTON_SCALE_9_GRID);
		this.stepperIncrementButtonHoverSkinTextures = new Scale9Textures(getTexture("numeric-stepper-increment-button-hover-skin"), STEPPER_INCREMENT_BUTTON_SCALE_9_GRID);
		this.stepperIncrementButtonDownSkinTextures = new Scale9Textures(getTexture("numeric-stepper-increment-button-down-skin"), STEPPER_INCREMENT_BUTTON_SCALE_9_GRID);
		this.stepperIncrementButtonDisabledSkinTextures = new Scale9Textures(getTexture("numeric-stepper-increment-button-disabled-skin"), STEPPER_INCREMENT_BUTTON_SCALE_9_GRID);

		this.stepperDecrementButtonUpSkinTextures = new Scale9Textures(getTexture("numeric-stepper-decrement-button-up-skin"), STEPPER_DECREMENT_BUTTON_SCALE_9_GRID);
		this.stepperDecrementButtonHoverSkinTextures = new Scale9Textures(getTexture("numeric-stepper-decrement-button-hover-skin"), STEPPER_DECREMENT_BUTTON_SCALE_9_GRID);
		this.stepperDecrementButtonDownSkinTextures = new Scale9Textures(getTexture("numeric-stepper-decrement-button-down-skin"), STEPPER_DECREMENT_BUTTON_SCALE_9_GRID);
		this.stepperDecrementButtonDisabledSkinTextures = new Scale9Textures(getTexture("numeric-stepper-decrement-button-disabled-skin"), STEPPER_DECREMENT_BUTTON_SCALE_9_GRID);

		this.hSliderThumbUpSkinTexture = getTexture("hslider-thumb-up-skin");
		this.hSliderThumbHoverSkinTexture = getTexture("hslider-thumb-hover-skin");
		this.hSliderThumbDownSkinTexture = getTexture("hslider-thumb-down-skin");
		this.hSliderThumbDisabledSkinTexture = getTexture("hslider-thumb-disabled-skin");
		this.hSliderTrackSkinTextures = new Scale3Textures(getTexture("hslider-track-skin"), HSLIDER_FIRST_REGION, HSLIDER_SECOND_REGION, Scale3Textures.DIRECTION_HORIZONTAL);

		this.vSliderThumbUpSkinTexture = getTexture("vslider-thumb-up-skin");
		this.vSliderThumbHoverSkinTexture = getTexture("vslider-thumb-hover-skin");
		this.vSliderThumbDownSkinTexture = getTexture("vslider-thumb-down-skin");
		this.vSliderThumbDisabledSkinTexture = getTexture("vslider-thumb-disabled-skin");
		this.vSliderTrackSkinTextures = new Scale3Textures(getTexture("vslider-track-skin"), HSLIDER_FIRST_REGION, HSLIDER_SECOND_REGION, Scale3Textures.DIRECTION_VERTICAL);

		this.scrollBarThumbDefaultSkin = new Scale9Textures(getTexture("scroll-bar-thumb-default-skin"), SCROLL_BAR_THUMB_DEFAULT_SCALE_9_GRID);
		this.scrollBarTrackDefaultSkin = new Scale9Textures(getTexture("scroll-bar-track-default-skin"), SCROLL_BAR_TRACK_DEFAULT_SCALE_9_GRID);

		this.listBackgroundSkinTexture = UIUtils.getScale9RectTexture(10, 10, 0x14181C);
		this.listItemRendererUpSkinTexture = new Scale9Textures(getTexture("list-item-renderer-default-skin"), LIST_ITEM_RENDERER_SCALE_9_GRID);
		this.listItemRendererHoverSkinTexture = new Scale9Textures(getTexture("list-item-renderer-hover-skin"),LIST_ITEM_RENDERER_SCALE_9_GRID);
		this.listItemRendererSelectedUpSkinTexture = new Scale9Textures(getTexture("list-item-renderer-selected-skin"), LIST_ITEM_RENDERER_SCALE_9_GRID);

		this.headerBackgroundSkinTextures = new Scale9Textures(getTexture("header-background-skin"), HEADER_SCALE_9_GRID);
		this.groupedListHeaderBackgroundSkinTextures = new Scale9Textures(getTexture("grouped-list-header-background-skin"), HEADER_SCALE_9_GRID);

		this.checkUpIconTexture = getTexture("check-up-skin");
		this.checkSelectedUpIconTexture = getTexture("check-selected-up-skin");
		this.checkPartialSelectedUpIconTexture = UIUtils.getRectTexture(10, 10, 0x628280, 0.8);

		this.radioUpIconTexture = getTexture("radio-up-skin");
		this.radioSelectedUpIconTexture = getTexture("radio-selected-up-skin");

		this.pageIndicatorNormalSkinTexture = getTexture("page-indicator-normal-skin");
		this.pageIndicatorSelectedSkinTexture = getTexture("page-indicator-selected-skin");

		this.pickerListDefaultIconTexture = getTexture("picker-list-default-icon");

		this.dropDownMenuBackgroundTexture = new Scale9Textures(getTexture("drop-down-menu-background-skin"), DROP_DOWN_MENU_BACKGROUND_SCALE_9_GRID);

		this.textInputBackgroundSkinTextures = new Scale9Textures(getTexture("text-input-background-skin"), TEXT_INPUT_SCALE_9_GRID);
		this.textInputBackgroundDisabledSkinTextures = new Scale9Textures(getTexture("text-input-background-disabled-skin"), TEXT_INPUT_SCALE_9_GRID);

		this.vScrollBarThumbUpSkinTextures = new Scale9Textures(getTexture("vertical-scroll-bar-thumb-up-skin"), VERTICAL_SCROLL_BAR_THUMB_SCALE_9_GRID);
		this.vScrollBarThumbHoverSkinTextures = new Scale9Textures(getTexture("vertical-scroll-bar-thumb-hover-skin"), VERTICAL_SCROLL_BAR_THUMB_SCALE_9_GRID);
		this.vScrollBarThumbDownSkinTextures = new Scale9Textures(getTexture("vertical-scroll-bar-thumb-down-skin"), VERTICAL_SCROLL_BAR_THUMB_SCALE_9_GRID);
		this.vScrollBarTrackSkinTextures = new Scale9Textures(getTexture("vertical-scroll-bar-track-skin"), VERTICAL_SCROLL_BAR_TRACK_SCALE_9_GRID);
		this.vScrollBarThumbIconTexture = getTexture("vertical-scroll-bar-thumb-icon");
		this.vScrollBarStepButtonUpSkinTextures = new Scale9Textures(getTexture("vertical-scroll-bar-step-button-up-skin"), VERTICAL_SCROLL_BAR_STEP_BUTTON_SCALE_9_GRID);
		this.vScrollBarStepButtonHoverSkinTextures = new Scale9Textures(getTexture("vertical-scroll-bar-step-button-hover-skin"), VERTICAL_SCROLL_BAR_STEP_BUTTON_SCALE_9_GRID);
		this.vScrollBarStepButtonDownSkinTextures = new Scale9Textures(getTexture("vertical-scroll-bar-step-button-down-skin"), VERTICAL_SCROLL_BAR_STEP_BUTTON_SCALE_9_GRID);
		this.vScrollBarStepButtonDisabledSkinTextures = new Scale9Textures(getTexture("vertical-scroll-bar-step-button-disabled-skin"), VERTICAL_SCROLL_BAR_STEP_BUTTON_SCALE_9_GRID);
		this.vScrollBarDecrementButtonIconTexture = getTexture("vertical-scroll-bar-decrement-button-icon");
		this.vScrollBarIncrementButtonIconTexture = getTexture("vertical-scroll-bar-increment-button-icon");

		this.hScrollBarThumbUpSkinTextures = new Scale9Textures(getTexture("horizontal-scroll-bar-thumb-up-skin"), HORIZONTAL_SCROLL_BAR_THUMB_SCALE_9_GRID);
		this.hScrollBarThumbHoverSkinTextures = new Scale9Textures(getTexture("horizontal-scroll-bar-thumb-hover-skin"), HORIZONTAL_SCROLL_BAR_THUMB_SCALE_9_GRID);
		this.hScrollBarThumbDownSkinTextures = new Scale9Textures(getTexture("horizontal-scroll-bar-thumb-down-skin"), HORIZONTAL_SCROLL_BAR_THUMB_SCALE_9_GRID);
		this.hScrollBarTrackSkinTextures = new Scale9Textures(getTexture("horizontal-scroll-bar-track-skin"), HORIZONTAL_SCROLL_BAR_TRACK_SCALE_9_GRID);
		this.hScrollBarThumbIconTexture = getTexture("horizontal-scroll-bar-thumb-icon");
		this.hScrollBarStepButtonUpSkinTextures = new Scale9Textures(getTexture("horizontal-scroll-bar-step-button-up-skin"), HORIZONTAL_SCROLL_BAR_STEP_BUTTON_SCALE_9_GRID);
		this.hScrollBarStepButtonHoverSkinTextures = new Scale9Textures(getTexture("horizontal-scroll-bar-step-button-hover-skin"), HORIZONTAL_SCROLL_BAR_STEP_BUTTON_SCALE_9_GRID);
		this.hScrollBarStepButtonDownSkinTextures = new Scale9Textures(getTexture("horizontal-scroll-bar-step-button-down-skin"), HORIZONTAL_SCROLL_BAR_STEP_BUTTON_SCALE_9_GRID);
		this.hScrollBarStepButtonDisabledSkinTextures = new Scale9Textures(getTexture("horizontal-scroll-bar-step-button-disabled-skin"), HORIZONTAL_SCROLL_BAR_STEP_BUTTON_SCALE_9_GRID);
		this.hScrollBarDecrementButtonIconTexture = getTexture("horizontal-scroll-bar-decrement-button-icon");
		this.hScrollBarIncrementButtonIconTexture = getTexture("horizontal-scroll-bar-increment-button-icon");

		this.simpleBorderBackgroundSkinTextures = new Scale9Textures(getTexture("simple-border-background-skin"), SIMPLE_BORDER_SCALE_9_GRID);
		this.panelBorderBackgroundSkinTextures = new Scale9Textures(getTexture("panel-background-skin"), PANEL_BORDER_SCALE_9_GRID);

		this.calloutBackgroundSkinTextures = new Scale9Textures(getTexture("callout-background-skin"), CALLOUT_BACKGROUND_SCALE_9_GRID);

		this.progressBarBackgroundSkinTexture = new Scale9Textures(getTexture("progress-bar-background-skin"), PROGRESS_BAR_BACKGROUND_SCALE_9_GRID);
		this.progressBarFillSkinTexture = getTexture("progress-bar-fill-skin");

		this.mapDarkBackgroundTexture = UIUtils.getScale9RectTexture(10, 10, 0x14181C);

		emptyTexture = getTexture("empty");

		StandardIcons.listDrillDownAccessoryTexture = getTexture("list-accessory-drill-down-icon");
	}

	protected function setInitializers():void
	{
		this.setInitializerForClassAndSubclasses(Screen, screenInitializer);
		this.setInitializerForClassAndSubclasses(PanelScreen, panelScreenInitializer);
		this.setInitializerForClass(Label, labelInitializer);
		this.setInitializerForClass(ScrollText, scrollTextInitializer);
		this.setInitializerForClass(BitmapFontTextRenderer, itemRendererAccessoryLabelInitializer, BaseDefaultItemRenderer.DEFAULT_CHILD_NAME_ACCESSORY_LABEL);
		this.setInitializerForClass(Button, buttonInitializer);
		this.setInitializerForClass(Button, tabInitializer, TabBar.DEFAULT_CHILD_NAME_TAB);
		this.setInitializerForClass(Button, toggleSwitchOnTrackInitializer, ToggleSwitch.DEFAULT_CHILD_NAME_ON_TRACK);
		this.setInitializerForClass(Button, toggleSwitchThumbInitializer, ToggleSwitch.DEFAULT_CHILD_NAME_THUMB);
		this.setInitializerForClass(Button, pickerListButtonInitializer, PickerList.DEFAULT_CHILD_NAME_BUTTON);
		this.setInitializerForClass(Button, stepperIncrementButtonInitializer, NumericStepper.DEFAULT_CHILD_NAME_INCREMENT_BUTTON);
		this.setInitializerForClass(Button, stepperDecrementButtonInitializer, NumericStepper.DEFAULT_CHILD_NAME_DECREMENT_BUTTON);
		this.setInitializerForClass(Button, horizontalSliderThumbInitializer, THEME_NAME_HORIZONTAL_SLIDER_THUMB);
		this.setInitializerForClass(Button, horizontalSliderMinimumTrackInitializer, THEME_NAME_HORIZONTAL_SLIDER_MINIMUM_TRACK);
		this.setInitializerForClass(Button, verticalSliderThumbInitializer, THEME_NAME_VERTICAL_SLIDER_THUMB);
		this.setInitializerForClass(Button, verticalSliderMinimumTrackInitializer, THEME_NAME_VERTICAL_SLIDER_MINIMUM_TRACK);
		this.setInitializerForClass(Button, horizontalSimpleScrollBarThumbInitializer, THEME_NAME_HORIZONTAL_SIMPLE_SCROLL_BAR_THUMB);
		this.setInitializerForClass(Button, verticalSimpleScrollBarThumbInitializer, THEME_NAME_VERTICAL_SIMPLE_SCROLL_BAR_THUMB);
		this.setInitializerForClass(Button, horizontalScrollBarIncrementButtonInitializer, THEME_NAME_HORIZONTAL_SCROLL_BAR_INCREMENT_BUTTON);
		this.setInitializerForClass(Button, horizontalScrollBarDecrementButtonInitializer, THEME_NAME_HORIZONTAL_SCROLL_BAR_DECREMENT_BUTTON);
		this.setInitializerForClass(Button, horizontalScrollBarThumbInitializer, THEME_NAME_HORIZONTAL_SCROLL_BAR_THUMB);
		this.setInitializerForClass(Button, horizontalScrollBarMinimumTrackInitializer, THEME_NAME_HORIZONTAL_SCROLL_BAR_MINIMUM_TRACK);
		this.setInitializerForClass(Button, verticalScrollBarIncrementButtonInitializer, THEME_NAME_VERTICAL_SCROLL_BAR_INCREMENT_BUTTON);
		this.setInitializerForClass(Button, verticalScrollBarDecrementButtonInitializer, THEME_NAME_VERTICAL_SCROLL_BAR_DECREMENT_BUTTON);
		this.setInitializerForClass(Button, verticalScrollBarThumbInitializer, THEME_NAME_VERTICAL_SCROLL_BAR_THUMB);
		this.setInitializerForClass(Button, verticalScrollBarMinimumTrackInitializer, THEME_NAME_VERTICAL_SCROLL_BAR_MINIMUM_TRACK);
		this.setInitializerForClass(ButtonGroup, buttonGroupInitializer);
		this.setInitializerForClass(Check, checkInitializer);
		this.setInitializerForClass(Radio, radioInitializer);
		this.setInitializerForClass(ToggleSwitch, toggleSwitchInitializer);
		this.setInitializerForClass(Slider, sliderInitializer);
		this.setInitializerForClass(NumericStepper, numericStepperInitializer);
		this.setInitializerForClass(SimpleScrollBar, horizontalSimpleScrollBarInitializer, Scroller.DEFAULT_CHILD_NAME_HORIZONTAL_SCROLL_BAR);
		this.setInitializerForClass(SimpleScrollBar, verticalSimpleScrollBarInitializer, Scroller.DEFAULT_CHILD_NAME_VERTICAL_SCROLL_BAR);
		this.setInitializerForClass(ScrollBar, horizontalScrollBarInitializer, Scroller.DEFAULT_CHILD_NAME_HORIZONTAL_SCROLL_BAR);
		this.setInitializerForClass(ScrollBar, verticalScrollBarInitializer, Scroller.DEFAULT_CHILD_NAME_VERTICAL_SCROLL_BAR);
		this.setInitializerForClass(TextInput, textInputInitializer);
		this.setInitializerForClass(TextInput, numericStepperTextInputInitializer, NumericStepper.DEFAULT_CHILD_NAME_TEXT_INPUT);
		this.setInitializerForClass(TextArea, textAreaInitializer);
		this.setInitializerForClass(PageIndicator, pageIndicatorInitializer);
		this.setInitializerForClass(ProgressBar, progressBarInitializer);
		this.setInitializerForClass(ScrollBar, horizontalScrollBarInitializer, Scroller.DEFAULT_CHILD_NAME_HORIZONTAL_SCROLL_BAR);
		this.setInitializerForClass(ScrollBar, verticalScrollBarInitializer, Scroller.DEFAULT_CHILD_NAME_VERTICAL_SCROLL_BAR);
		this.setInitializerForClass(List, listInitializer);
		this.setInitializerForClass(List, pickerListListInitializer, PickerList.DEFAULT_CHILD_NAME_LIST);
		this.setInitializerForClass(GroupedList, groupedListInitializer);
		this.setInitializerForClass(PickerList, pickerListInitializer);
		this.setInitializerForClass(DefaultListItemRenderer, defaultItemRendererInitializer);
		this.setInitializerForClass(DefaultGroupedListItemRenderer, defaultItemRendererInitializer);
		this.setInitializerForClass(DefaultGroupedListHeaderOrFooterRenderer, defaultHeaderOrFooterRendererInitializer);
		this.setInitializerForClass(Header, headerInitializer);
		this.setInitializerForClass(Header, panelHeaderInitializer, Panel.DEFAULT_CHILD_NAME_HEADER);
		this.setInitializerForClass(Callout, calloutInitializer);
		this.setInitializerForClass(Callout, pickerListCalloutInitializer, THEME_NAME_PICKER_LIST_CALLOUT);
		this.setInitializerForClass(ScrollContainer, scrollContainerInitializer);
		this.setInitializerForClass(ScrollContainer, scrollContainerToolbarInitializer, ScrollContainer.ALTERNATE_NAME_TOOLBAR);
		this.setInitializerForClass(Panel, panelInitializer);
		this.setInitializerForClass(Alert, alertInitializer);
		this.setInitializerForClass(ButtonGroup, alertButtonGroupInitializer, Alert.DEFAULT_CHILD_NAME_BUTTON_GROUP);
		this.setInitializerForClass(TextFieldTextRenderer, alertTextFieldTextRendererInitializer, Alert.DEFAULT_CHILD_NAME_MESSAGE);
	}

	protected function getTexture(id:String):Texture
	{
		return Assets.getTexture(StringUtils.substitute("{0}{1}", id, ASSETS_IMAGES_EXTENSION));
	}

	protected function pageIndicatorNormalSymbolFactory():Image
	{
		return new Image(this.pageIndicatorNormalSkinTexture);
	}

	protected function pageIndicatorSelectedSymbolFactory():Image
	{
		return new Image(this.pageIndicatorSelectedSkinTexture);
	}

	private static function screenInitializer(screen:Screen):void
	{
		screen.originalDPI = ThemeUtils.originalDPI;
	}

	private function panelScreenInitializer(screen:PanelScreen):void
	{
		screen.originalDPI = ThemeUtils.originalDPI;

		screen.interactionMode = ScrollContainer.INTERACTION_MODE_MOUSE;
		screen.scrollBarDisplayMode = ScrollContainer.SCROLL_BAR_DISPLAY_MODE_FIXED;

		screen.horizontalScrollBarFactory = scrollBarFactory;
		screen.verticalScrollBarFactory = scrollBarFactory;
	}

	protected static function labelInitializer(label:Label):void
	{
		label.textRendererProperties.textFormat = ThemeStyles.getTextFormat();
	}

	protected function scrollTextInitializer(text:ScrollText):void
	{
		text.embedFonts = true;
		text.textFormat = ThemeStyles.getTextFormat(ThemeStyles.TEXT_TYPE_DEFAULT, ThemeStyles.MEDIUM);

		text.paddingTop = text.paddingRight = text.paddingBottom = text.paddingLeft = 8;

		text.interactionMode = ScrollText.INTERACTION_MODE_MOUSE;
		text.scrollBarDisplayMode = ScrollText.SCROLL_BAR_DISPLAY_MODE_FIXED;

		text.horizontalScrollBarFactory = scrollBarFactory;
		text.verticalScrollBarFactory = scrollBarFactory;
	}

	private static function itemRendererAccessoryLabelInitializer(renderer:TextFieldTextRenderer):void
	{
		renderer.textFormat = ThemeStyles.getTextFormat();
	}

	protected function buttonInitializer(button:Button):void
	{
		const skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
		skinSelector.defaultValue = this.buttonUpSkinTextures;
		skinSelector.defaultSelectedValue = this.buttonUpSkinTextures;
		skinSelector.setValueForState(this.buttonHoverSkinTextures, Button.STATE_HOVER, false);
		skinSelector.setValueForState(this.buttonDownSkinTextures, Button.STATE_DOWN, false);
		skinSelector.setValueForState(this.buttonDisabledSkinTextures, Button.STATE_DISABLED, false);
		skinSelector.setValueForState(this.buttonUpSkinTextures, Button.STATE_UP, false);

		skinSelector.setValueForState(this.buttonDownSkinTextures, Button.STATE_HOVER, true);
		skinSelector.setValueForState(this.buttonDownSkinTextures, Button.STATE_DOWN, true);
		skinSelector.setValueForState(this.buttonDownSkinTextures, Button.STATE_DISABLED, true);
		skinSelector.setValueForState(this.buttonDownSkinTextures, Button.STATE_UP, true);
		button.stateToSkinFunction = skinSelector.updateValue;

		button.focusIndicatorSkin = new Scale9Image(this.focusIndicatorSkinTextures);
		button.focusPadding = -1;

		button.defaultLabelProperties.textFormat = ThemeStyles.getTextFormat(ThemeStyles.TEXT_TYPE_INTERACTIVE_DEFAULT);
		button.disabledLabelProperties.textFormat = ThemeStyles.getTextFormat(ThemeStyles.TEXT_TYPE_INTERACTIVE_DISABLED);
		button.hoverLabelProperties.textFormat = ThemeStyles.getTextFormat(ThemeStyles.TEXT_TYPE_INTERACTIVE_HOVERED);
		button.downLabelProperties.textFormat = ThemeStyles.getTextFormat(ThemeStyles.TEXT_TYPE_INTERACTIVE_DOWN);

		button.selectedDisabledLabelProperties.textFormat = ThemeStyles.getTextFormat(ThemeStyles.TEXT_TYPE_INTERACTIVE_DOWN);
		button.selectedHoverLabelProperties.textFormat = ThemeStyles.getTextFormat(ThemeStyles.TEXT_TYPE_INTERACTIVE_DOWN);
		button.selectedDownLabelProperties.textFormat = ThemeStyles.getTextFormat(ThemeStyles.TEXT_TYPE_INTERACTIVE_DOWN);
		button.selectedUpLabelProperties.textFormat = ThemeStyles.getTextFormat(ThemeStyles.TEXT_TYPE_INTERACTIVE_DOWN);

		button.paddingTop = button.paddingBottom = 2;
		button.paddingLeft = button.paddingRight = 10;
		button.gap = 2;
		button.minWidth = button.minHeight = 12;
	}

	protected function pickerListButtonInitializer(button:Button):void
	{
		const skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
		skinSelector.defaultValue = this.buttonDownSkinTextures;
		button.stateToSkinFunction = skinSelector.updateValue;

		button.focusIndicatorSkin = new Scale9Image(this.focusIndicatorSkinTextures);
		button.focusPadding = -1;

		button.defaultLabelProperties.textFormat = ThemeStyles.getTextFormat(ThemeStyles.TEXT_TYPE_INTERACTIVE_SELECTED);

		const iconSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
		iconSelector.defaultValue = this.pickerListDefaultIconTexture;
		button.stateToIconFunction = iconSelector.updateValue;

		button.gap = Number.POSITIVE_INFINITY; //fill as completely as possible
		button.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
		button.iconPosition = Button.ICON_POSITION_RIGHT;
		button.paddingLeft = button.paddingRight = 6;
		button.minWidth = 12;
	}

	protected function toggleSwitchOnTrackInitializer(track:Button):void
	{
		track.defaultSkin = new Scale9Image(toggleSwitchTrackBackgroundTexture);
	}

	protected function toggleSwitchThumbInitializer(thumb:Button):void
	{
		const skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
		skinSelector.defaultValue = this.toggleSwitchThumbDefaultTexture;
		skinSelector.setValueForState(this.toggleSwitchThumbDownTexture, Button.STATE_DOWN, false);
		thumb.stateToSkinFunction = skinSelector.updateValue;

		thumb.focusIndicatorSkin = new Scale9Image(this.focusIndicatorSkinTextures);
		thumb.focusPadding = -1;
		//buttonSelectedUpSkinTextures

		thumb.paddingTop = thumb.paddingBottom = 0;
		thumb.paddingLeft = thumb.paddingRight = 0;
		thumb.minWidth = thumb.minHeight = 4;
	}

	protected function horizontalScrollBarIncrementButtonInitializer(button:Button):void
	{
		const skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
		skinSelector.defaultValue = this.hScrollBarStepButtonUpSkinTextures;
		skinSelector.setValueForState(this.hScrollBarStepButtonHoverSkinTextures, Button.STATE_HOVER, false);
		skinSelector.setValueForState(this.hScrollBarStepButtonDownSkinTextures, Button.STATE_DOWN, false);
		skinSelector.setValueForState(this.hScrollBarStepButtonDisabledSkinTextures, Button.STATE_DISABLED, false);
		button.stateToSkinFunction = skinSelector.updateValue;

		button.defaultIcon = new Image(this.hScrollBarIncrementButtonIconTexture);

		const incrementButtonDisabledIcon:Quad = new Quad(1, 1, 0xff00ff);
		incrementButtonDisabledIcon.alpha = 0;
		button.disabledIcon = incrementButtonDisabledIcon;
	}

	protected function horizontalScrollBarDecrementButtonInitializer(button:Button):void
	{
		const skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
		skinSelector.defaultValue = hScrollBarStepButtonUpSkinTextures;
		skinSelector.setValueForState(this.hScrollBarStepButtonHoverSkinTextures, Button.STATE_HOVER, false);
		skinSelector.setValueForState(this.hScrollBarStepButtonDownSkinTextures, Button.STATE_DOWN, false);
		skinSelector.setValueForState(this.hScrollBarStepButtonDisabledSkinTextures, Button.STATE_DISABLED, false);
		button.stateToSkinFunction = skinSelector.updateValue;

		button.defaultIcon = new Image(this.hScrollBarDecrementButtonIconTexture);

		const decrementButtonDisabledIcon:Quad = new Quad(1, 1, 0xff00ff);
		decrementButtonDisabledIcon.alpha = 0;
		button.disabledIcon = decrementButtonDisabledIcon;
	}

	protected function horizontalScrollBarThumbInitializer(thumb:Button):void
	{
		const skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
		skinSelector.defaultValue = this.hScrollBarThumbUpSkinTextures;
		skinSelector.setValueForState(this.hScrollBarThumbHoverSkinTextures, Button.STATE_HOVER, false);
		skinSelector.setValueForState(this.hScrollBarThumbDownSkinTextures, Button.STATE_DOWN, false);
		thumb.stateToSkinFunction = skinSelector.updateValue;

		thumb.defaultIcon = new Image(this.hScrollBarThumbIconTexture);
		thumb.verticalAlign = Button.VERTICAL_ALIGN_TOP;
		thumb.paddingTop = 4;
	}

	protected function horizontalScrollBarMinimumTrackInitializer(track:Button):void
	{
		track.defaultSkin = new Scale9Image(this.hScrollBarTrackSkinTextures);
	}

	protected function verticalScrollBarIncrementButtonInitializer(button:Button):void
	{
	}

	protected function verticalScrollBarDecrementButtonInitializer(button:Button):void
	{
	}

	protected function verticalScrollBarThumbInitializer(thumb:Button):void
	{
		const skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
		skinSelector.defaultValue = this.scrollBarThumbDefaultSkin;
		thumb.stateToSkinFunction = skinSelector.updateValue;
	}

	protected function verticalScrollBarMinimumTrackInitializer(track:Button):void
	{
		track.defaultSkin = new Scale9Image(this.scrollBarTrackDefaultSkin);
		track.defaultSkin.x = 5;
	}

	protected function horizontalSimpleScrollBarThumbInitializer(thumb:Button):void
	{
		const skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
		skinSelector.defaultValue = this.hScrollBarThumbUpSkinTextures;
		skinSelector.setValueForState(this.hScrollBarThumbHoverSkinTextures, Button.STATE_HOVER, false);
		skinSelector.setValueForState(this.hScrollBarThumbDownSkinTextures, Button.STATE_DOWN, false);
		thumb.stateToSkinFunction = skinSelector.updateValue;

		thumb.defaultIcon = new Image(this.hScrollBarThumbIconTexture);
		thumb.verticalAlign = Button.VERTICAL_ALIGN_TOP;
		thumb.paddingTop = 4;
	}

	protected function verticalSimpleScrollBarThumbInitializer(thumb:Button):void
	{
		const skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
		skinSelector.defaultValue = this.vScrollBarThumbUpSkinTextures;
		skinSelector.setValueForState(this.vScrollBarThumbHoverSkinTextures, Button.STATE_HOVER, false);
		skinSelector.setValueForState(this.vScrollBarThumbDownSkinTextures, Button.STATE_DOWN, false);
		thumb.stateToSkinFunction = skinSelector.updateValue;

		thumb.defaultIcon = new Image(this.vScrollBarThumbIconTexture);
		thumb.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
		thumb.paddingLeft = 4;
	}

	protected function horizontalSliderThumbInitializer(thumb:Button):void
	{
		const skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
		skinSelector.defaultValue = this.toggleSwitchThumbDefaultTexture;
		skinSelector.setValueForState(this.toggleSwitchThumbDownTexture, Button.STATE_DOWN, false);
		thumb.stateToSkinFunction = skinSelector.updateValue;
	}

	protected function horizontalSliderMinimumTrackInitializer(track:Button):void
	{
		track.defaultSkin = new Scale9Image(this.toggleSwitchTrackBackgroundTexture);
	}

	protected function verticalSliderThumbInitializer(thumb:Button):void
	{
		const skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
		skinSelector.defaultValue = this.vSliderThumbUpSkinTexture;
		skinSelector.setValueForState(this.vSliderThumbHoverSkinTexture, Button.STATE_HOVER, false);
		skinSelector.setValueForState(this.vSliderThumbDownSkinTexture, Button.STATE_DOWN, false);
		skinSelector.setValueForState(this.vSliderThumbDisabledSkinTexture, Button.STATE_DISABLED, false);
		thumb.stateToSkinFunction = skinSelector.updateValue;
	}

	protected function verticalSliderMinimumTrackInitializer(track:Button):void
	{
		track.defaultSkin = new Scale3Image(this.vSliderTrackSkinTextures);
	}

	protected function checkInitializer(check:Check):void
	{
		const iconSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
		iconSelector.defaultValue = this.checkUpIconTexture;
		iconSelector.defaultSelectedValue = this.checkSelectedUpIconTexture;
		iconSelector.setValueForState(this.checkUpIconTexture, Button.STATE_HOVER, false);
		iconSelector.setValueForState(this.checkUpIconTexture, Button.STATE_DOWN, false);
		iconSelector.setValueForState(this.checkUpIconTexture, Button.STATE_DISABLED, false);
		iconSelector.setValueForState(this.checkSelectedUpIconTexture, Button.STATE_HOVER, true);
		iconSelector.setValueForState(this.checkSelectedUpIconTexture, Button.STATE_DOWN, true);
		iconSelector.setValueForState(this.checkSelectedUpIconTexture, Button.STATE_DISABLED, true);
		check.stateToIconFunction = iconSelector.updateValue;

		check.focusIndicatorSkin = new Scale9Image(this.focusIndicatorSkinTextures);
		check.focusPadding = -2;

		check.defaultLabelProperties.textFormat = ThemeStyles.getTextFormat(ThemeStyles.TEXT_TYPE_INTERACTIVE_DEFAULT);
		check.disabledLabelProperties.textFormat = ThemeStyles.getTextFormat(ThemeStyles.TEXT_TYPE_INTERACTIVE_DISABLED);
		check.hoverLabelProperties.textFormat = ThemeStyles.getTextFormat(ThemeStyles.TEXT_TYPE_INTERACTIVE_HOVERED);
		check.downLabelProperties.textFormat = ThemeStyles.getTextFormat(ThemeStyles.TEXT_TYPE_INTERACTIVE_HOVERED);
		check.defaultSelectedLabelProperties.textFormat = ThemeStyles.getTextFormat(ThemeStyles.TEXT_TYPE_INTERACTIVE_DEFAULT);

		check.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
		check.verticalAlign = Button.VERTICAL_ALIGN_MIDDLE;

		check.gap = 4;
	}

	protected function radioInitializer(radio:Radio):void
	{
		const iconSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
		iconSelector.defaultValue = this.radioUpIconTexture;
		iconSelector.defaultSelectedValue = this.radioSelectedUpIconTexture;
		iconSelector.setValueForState(this.radioUpIconTexture, Button.STATE_HOVER, false);
		iconSelector.setValueForState(this.radioUpIconTexture, Button.STATE_DOWN, false);
		iconSelector.setValueForState(this.radioUpIconTexture, Button.STATE_DISABLED, false);
		iconSelector.setValueForState(this.radioSelectedUpIconTexture, Button.STATE_HOVER, true);
		iconSelector.setValueForState(this.radioSelectedUpIconTexture, Button.STATE_DOWN, true);
		iconSelector.setValueForState(this.radioSelectedUpIconTexture, Button.STATE_DISABLED, true);
		radio.stateToIconFunction = iconSelector.updateValue;

		radio.focusIndicatorSkin = new Scale9Image(this.focusIndicatorSkinTextures);
		radio.focusPadding = -2;

		radio.defaultLabelProperties.textFormat = ThemeStyles.getTextFormat(ThemeStyles.TEXT_TYPE_DEFAULT);
		radio.disabledLabelProperties.textFormat = ThemeStyles.getTextFormat(ThemeStyles.TEXT_TYPE_DEFAULT);

		radio.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
		radio.verticalAlign = Button.VERTICAL_ALIGN_MIDDLE;

		radio.gap = 4;
	}

	protected function tabInitializer(tab:Button):void
	{
		buttonInitializer(tab);

		tab.paddingTop = tab.paddingBottom = -2;
		tab.paddingLeft = tab.paddingRight = 4;
		tab.minWidth = tab.minHeight = 12;
	}

	protected function stepperIncrementButtonInitializer(button:Button):void
	{
		const skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
		skinSelector.defaultValue = this.stepperIncrementButtonUpSkinTextures;
		skinSelector.setValueForState(this.stepperIncrementButtonHoverSkinTextures, Button.STATE_HOVER, false);
		skinSelector.setValueForState(this.stepperIncrementButtonDownSkinTextures, Button.STATE_DOWN, false);
		skinSelector.setValueForState(this.stepperIncrementButtonDisabledSkinTextures, Button.STATE_DISABLED, false);
		button.stateToSkinFunction = skinSelector.updateValue;

		button.defaultLabelProperties.textFormat = ThemeStyles.getTextFormat(ThemeStyles.TEXT_TYPE_INTERACTIVE_DEFAULT);
		button.disabledLabelProperties.textFormat = ThemeStyles.getTextFormat(ThemeStyles.TEXT_TYPE_INTERACTIVE_DISABLED);
		button.hoverLabelProperties.textFormat = ThemeStyles.getTextFormat(ThemeStyles.TEXT_TYPE_INTERACTIVE_HOVERED);
		button.downLabelProperties.textFormat = ThemeStyles.getTextFormat(ThemeStyles.TEXT_TYPE_INTERACTIVE_DOWN);
		button.selectedUpLabelProperties.textFormat = ThemeStyles.getTextFormat(ThemeStyles.TEXT_TYPE_INTERACTIVE_DOWN);
		button.selectedHoverLabelProperties.textFormat = ThemeStyles.getTextFormat(ThemeStyles.TEXT_TYPE_INTERACTIVE_DOWN);
	}

	protected function stepperDecrementButtonInitializer(button:Button):void
	{
		const skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
		skinSelector.defaultValue = this.stepperDecrementButtonUpSkinTextures;
		skinSelector.setValueForState(this.stepperDecrementButtonHoverSkinTextures, Button.STATE_HOVER, false);
		skinSelector.setValueForState(this.stepperDecrementButtonDownSkinTextures, Button.STATE_DOWN, false);
		skinSelector.setValueForState(this.stepperDecrementButtonDisabledSkinTextures, Button.STATE_DISABLED, false);
		button.stateToSkinFunction = skinSelector.updateValue;

		button.defaultLabelProperties.textFormat = ThemeStyles.getTextFormat(ThemeStyles.TEXT_TYPE_INTERACTIVE_DEFAULT);
		button.disabledLabelProperties.textFormat = ThemeStyles.getTextFormat(ThemeStyles.TEXT_TYPE_INTERACTIVE_DISABLED);
		button.hoverLabelProperties.textFormat = ThemeStyles.getTextFormat(ThemeStyles.TEXT_TYPE_INTERACTIVE_HOVERED);
		button.downLabelProperties.textFormat = ThemeStyles.getTextFormat(ThemeStyles.TEXT_TYPE_INTERACTIVE_DOWN);
		button.selectedUpLabelProperties.textFormat = ThemeStyles.getTextFormat(ThemeStyles.TEXT_TYPE_INTERACTIVE_DOWN);
		button.selectedHoverLabelProperties.textFormat = ThemeStyles.getTextFormat(ThemeStyles.TEXT_TYPE_INTERACTIVE_DOWN);
	}

	protected function toggleSwitchInitializer(toggle:ToggleSwitch):void
	{
		toggle.trackLayoutMode = ToggleSwitch.TRACK_LAYOUT_MODE_SINGLE;

		toggle.labelAlign = ToggleSwitch.LABEL_ALIGN_MIDDLE;

		toggle.defaultLabelProperties.textFormat = ThemeStyles.getTextFormat(ThemeStyles.TEXT_TYPE_PLANE);
		toggle.disabledLabelProperties.textFormat = ThemeStyles.getTextFormat(ThemeStyles.TEXT_TYPE_PLANE);

		toggle.focusIndicatorSkin = new Scale9Image(this.focusIndicatorSkinTextures);
		toggle.focusPadding = -1;

		toggle.paddingLeft = toggle.paddingRight = 3;

		toggle.minWidth = 32;
		toggle.minHeight = 16;

	}

	protected function buttonGroupInitializer(group:ButtonGroup):void
	{
		group.gap = 4;
	}

	protected function sliderInitializer(slider:Slider):void
	{
		slider.trackLayoutMode = Slider.TRACK_LAYOUT_MODE_SINGLE;

		slider.minimumPadding = slider.maximumPadding = 2;

		if(slider.direction == Slider.DIRECTION_VERTICAL)
		{
			slider.customThumbName = THEME_NAME_VERTICAL_SLIDER_THUMB;
			slider.customMinimumTrackName = THEME_NAME_VERTICAL_SLIDER_MINIMUM_TRACK;

			slider.focusPaddingLeft = slider.focusPaddingRight = -2;
			slider.focusPaddingTop = slider.focusPaddingBottom = -2 + slider.minimumPadding;
		}
		else //horizontal
		{
			slider.customThumbName = THEME_NAME_HORIZONTAL_SLIDER_THUMB;
			slider.customMinimumTrackName = THEME_NAME_HORIZONTAL_SLIDER_MINIMUM_TRACK;

			slider.focusPaddingTop = slider.focusPaddingBottom = -2;
			slider.focusPaddingLeft = slider.focusPaddingRight = -2 + slider.minimumPadding;
		}

		slider.focusIndicatorSkin = new Scale9Image(this.focusIndicatorSkinTextures);

		slider.minWidth = 14;
		slider.minHeight = 16;
	}

	private static function verticalScrollBarInitializer(scrollBar:ScrollBar):void
	{
		scrollBar.direction = ScrollBar.DIRECTION_VERTICAL;
		scrollBar.trackLayoutMode = ScrollBar.TRACK_LAYOUT_MODE_SINGLE;

		scrollBar.customIncrementButtonName = THEME_NAME_VERTICAL_SCROLL_BAR_INCREMENT_BUTTON;
		scrollBar.customDecrementButtonName = THEME_NAME_VERTICAL_SCROLL_BAR_DECREMENT_BUTTON;
		scrollBar.customThumbName = THEME_NAME_VERTICAL_SCROLL_BAR_THUMB;
		scrollBar.customMinimumTrackName = THEME_NAME_VERTICAL_SCROLL_BAR_MINIMUM_TRACK;
	}

	private static function horizontalScrollBarInitializer(scrollBar:ScrollBar):void
	{
		scrollBar.direction = ScrollBar.DIRECTION_HORIZONTAL;
		scrollBar.trackLayoutMode = ScrollBar.TRACK_LAYOUT_MODE_SINGLE;

		scrollBar.customIncrementButtonName = THEME_NAME_HORIZONTAL_SCROLL_BAR_INCREMENT_BUTTON;
		scrollBar.customDecrementButtonName = THEME_NAME_HORIZONTAL_SCROLL_BAR_DECREMENT_BUTTON;
		scrollBar.customThumbName = THEME_NAME_HORIZONTAL_SCROLL_BAR_THUMB;
		scrollBar.customMinimumTrackName = THEME_NAME_HORIZONTAL_SCROLL_BAR_MINIMUM_TRACK;
	}

	private static function horizontalSimpleScrollBarInitializer(scrollBar:SimpleScrollBar):void
	{
		scrollBar.customThumbName = THEME_NAME_HORIZONTAL_SIMPLE_SCROLL_BAR_THUMB;
	}

	private static function verticalSimpleScrollBarInitializer(scrollBar:SimpleScrollBar):void
	{
		scrollBar.customThumbName = THEME_NAME_VERTICAL_SIMPLE_SCROLL_BAR_THUMB;
	}

	protected function numericStepperInitializer(stepper:NumericStepper):void
	{
		stepper.buttonLayoutMode = NumericStepper.BUTTON_LAYOUT_MODE_RIGHT_SIDE_VERTICAL;

		stepper.focusIndicatorSkin = new Scale9Image(this.focusIndicatorSkinTextures);
		stepper.focusPadding = -1;
	}

	protected function baseTextInputInitializer(input:TextInput):void
	{
		var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
		skinSelector.defaultValue = this.textInputBackgroundSkinTextures;
		skinSelector.setValueForState(this.textInputBackgroundDisabledSkinTextures, TextInput.STATE_DISABLED);
		input.stateToSkinFunction = skinSelector.updateValue;

		input.focusIndicatorSkin = new Scale9Image(this.focusIndicatorSkinTextures);
		input.focusPadding = -1;

		input.minWidth = input.minHeight = 22;
		input.gap = 2;
		input.paddingTop = input.paddingBottom = 2;
		input.paddingRight = input.paddingLeft = 4;

		input.textEditorProperties.textFormat = ThemeStyles.getTextFormat(ThemeStyles.TEXT_TYPE_INTERACTIVE_DEFAULT);
		input.promptProperties.textFormat = ThemeStyles.getTextFormat(ThemeStyles.TEXT_TYPE_INTERACTIVE_DEFAULT);
	}

	protected function textInputInitializer(input:TextInput):void
	{
		this.baseTextInputInitializer(input);
	}

	protected function numericStepperTextInputInitializer(input:TextInput):void
	{
		baseTextInputInitializer(input);

		input.isFocusEnabled = true;
	}

	protected function textAreaInitializer(textArea:TextArea):void
	{
		ThemeUtils.fontEmbeddingWrap(textArea.textEditorProperties);
		textArea.textEditorProperties.textFormat = ThemeStyles.getTextFormat(ThemeStyles.TEXT_TYPE_PLANE);

		textArea.paddingTop = 2;
		textArea.paddingBottom = 2;
		textArea.paddingRight = 2;
		textArea.paddingLeft = 4;

		textArea.focusIndicatorSkin = new Scale9Image(this.focusIndicatorSkinTextures);
		textArea.focusPadding = -1;

		const backgroundSkin:Scale9Image = new Scale9Image(textInputBackgroundSkinTextures);
		backgroundSkin.width = 264;
		backgroundSkin.height = 88;
		textArea.backgroundSkin = backgroundSkin;

		const backgroundDisabledSkin:Scale9Image = new Scale9Image(textInputBackgroundDisabledSkinTextures);
		backgroundDisabledSkin.width = 264;
		backgroundDisabledSkin.height = 88;
		textArea.backgroundDisabledSkin = backgroundDisabledSkin;

		textArea.interactionMode = ScrollContainer.INTERACTION_MODE_MOUSE;
		textArea.scrollBarDisplayMode = ScrollContainer.SCROLL_BAR_DISPLAY_MODE_FIXED;

		textArea.horizontalScrollBarFactory = scrollBarFactory;
		textArea.verticalScrollBarFactory = scrollBarFactory;
	}

	protected function pageIndicatorInitializer(pageIndicator:PageIndicator):void
	{
		pageIndicator.normalSymbolFactory = this.pageIndicatorNormalSymbolFactory;
		pageIndicator.selectedSymbolFactory = this.pageIndicatorSelectedSymbolFactory;
		pageIndicator.gap = 12;
		pageIndicator.paddingTop = pageIndicator.paddingRight = pageIndicator.paddingBottom =
			pageIndicator.paddingLeft = 12;
		pageIndicator.minTouchWidth = pageIndicator.minTouchHeight = 12;
	}

	protected function progressBarInitializer(progress:ProgressBar):void
	{
//			const backgroundSkin:Scale9Image = new Scale9Image(simpleBorderBackgroundSkinTextures);
//			backgroundSkin.width = backgroundSkin.height * 30;

		progress.minWidth = 15;
		progress.minHeight = 5;

		progress.backgroundSkin = new Scale9Image(progressBarBackgroundSkinTexture);
		progress.fillSkin = new Image(progressBarFillSkinTexture);

		progress.padding = 0;
	}

	private function scrollContainerInitializer(container:ScrollContainer):void
	{
		container.interactionMode = ScrollContainer.INTERACTION_MODE_MOUSE;
		container.scrollBarDisplayMode = ScrollContainer.SCROLL_BAR_DISPLAY_MODE_FIXED;

		container.horizontalScrollBarFactory = scrollBarFactory;
		container.verticalScrollBarFactory = scrollBarFactory;
	}

	protected function scrollContainerToolbarInitializer(container:ScrollContainer):void
	{
		if(!container.layout)
		{
			const layout:HorizontalLayout = new HorizontalLayout();
			layout.paddingTop = layout.paddingBottom = 2;
			layout.paddingRight = layout.paddingLeft = 6;
			layout.gap = 2;
			container.layout = layout;
		}

		container.minHeight = 22;

		container.interactionMode = ScrollContainer.INTERACTION_MODE_MOUSE;
		container.scrollBarDisplayMode = ScrollContainer.SCROLL_BAR_DISPLAY_MODE_FIXED;

		container.horizontalScrollBarFactory = scrollBarFactory;
		container.verticalScrollBarFactory = scrollBarFactory;

		container.backgroundSkin = new Scale9Image(headerBackgroundSkinTextures);
	}

	protected function panelInitializer(panel:Panel):void
	{
		panel.backgroundSkin = new Scale9Image(panelBorderBackgroundSkinTextures);

		panel.paddingTop = 0;
		panel.paddingRight = 10;
		panel.paddingBottom = 10;
		panel.paddingLeft = 10;

		panel.interactionMode = ScrollContainer.INTERACTION_MODE_MOUSE;
		panel.scrollBarDisplayMode = ScrollContainer.SCROLL_BAR_DISPLAY_MODE_FIXED;

		panel.horizontalScrollBarFactory = scrollBarFactory;
		panel.verticalScrollBarFactory = scrollBarFactory;
	}

	protected function alertInitializer(alert:Alert):void
	{
		alert.backgroundSkin = new Scale9Image(listBackgroundSkinTexture);

		alert.paddingTop = 7;
		alert.paddingRight = 14;
		alert.paddingBottom = 0;
		alert.paddingLeft = 14;
		alert.gap = 7;

		alert.maxWidth = alert.maxHeight = 300;
	}

	protected function alertButtonGroupInitializer(group:ButtonGroup):void
	{
		group.direction = ButtonGroup.DIRECTION_HORIZONTAL;
		group.horizontalAlign = ButtonGroup.HORIZONTAL_ALIGN_CENTER;
		group.verticalAlign = ButtonGroup.VERTICAL_ALIGN_JUSTIFY;
		group.gap = 4;
		group.paddingTop = 12;
		group.paddingRight = 12;
		group.paddingBottom = 12;
		group.paddingLeft = 12;
	}

	protected function alertTextFieldTextRendererInitializer(renderer:TextFieldTextRenderer):void
	{
		renderer.textFormat = ThemeStyles.getTextFormat();
		renderer.wordWrap = true;
	}

	protected function listInitializer(list:List):void
	{
		const layout:VerticalLayout = new VerticalLayout();

		layout.useVirtualLayout = true;
		layout.paddingTop = layout.paddingRight = layout.paddingBottom =
				layout.paddingLeft = 0;
		layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_JUSTIFY;
		layout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_TOP;
		layout.manageVisibility = true;
		layout.gap = 2;

		list.focusIndicatorSkin = new Scale9Image(this.focusIndicatorSkinTextures);
		list.focusPadding = -1;

		list.paddingTop = list.paddingRight = list.paddingBottom =
			list.paddingLeft = 0;

		list.interactionMode = List.INTERACTION_MODE_MOUSE;
		list.scrollBarDisplayMode = List.SCROLL_BAR_DISPLAY_MODE_FIXED;

		list.layout = layout;

		list.horizontalScrollBarFactory = scrollBarFactory;
		list.verticalScrollBarFactory = scrollBarFactory;
	}

	protected function groupedListInitializer(list:GroupedList):void
	{
		list.focusIndicatorSkin = new Scale9Image(this.focusIndicatorSkinTextures);
		list.focusPadding = -1;

		list.paddingTop = list.paddingRight = list.paddingBottom =
			list.paddingLeft = 1;

		list.interactionMode = GroupedList.INTERACTION_MODE_MOUSE;
		list.scrollBarDisplayMode = GroupedList.SCROLL_BAR_DISPLAY_MODE_FIXED;

		list.horizontalScrollBarFactory = scrollBarFactory;
		list.verticalScrollBarFactory = scrollBarFactory;
	}

	private function pickerListInitializer(list:PickerList):void
	{
		var calloutManager:CalloutPopUpContentManager = new CalloutPopUpContentManager();

		calloutManager.calloutFactory = pickerListCalloutFactory;
		calloutManager.direction = Callout.DIRECTION_DOWN;

		list.popUpContentManager = calloutManager;
	}

	private function pickerListCalloutInitializer(callout:Callout):void
	{
		callout.backgroundSkin = new Scale9Image(dropDownMenuBackgroundTexture);
		callout.padding = 3;

		callout.supportedDirections = Callout.DIRECTION_DOWN;
	}

	private function pickerListCalloutFactory():Callout
	{
		var callout:Callout = new Callout();
		callout.closeOnTouchBeganOutside = true;
		callout.closeOnTouchEndedOutside = true;
		callout.closeOnKeys = new <uint>[Keyboard.BACK, Keyboard.ESCAPE];
		callout.nameList.add(THEME_NAME_PICKER_LIST_CALLOUT);
		return callout;
	}

	protected function pickerListListInitializer(list:List):void
	{
		this.listInitializer(list);

		list.paddingTop = list.paddingRight = list.paddingBottom =
				list.paddingLeft = 7;

		list.maxHeight = 110;
		list.minWidth = 150;
	}

	protected function defaultItemRendererInitializer(renderer:BaseDefaultItemRenderer):void
	{
		const skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
		skinSelector.defaultValue = this.listItemRendererUpSkinTexture;
		skinSelector.defaultSelectedValue = this.listItemRendererSelectedUpSkinTexture;

		skinSelector.setValueForState(listItemRendererHoverSkinTexture, Button.STATE_HOVER, false);
		skinSelector.setValueForState(listItemRendererHoverSkinTexture, Button.STATE_DOWN, false);
		skinSelector.setValueForState(listItemRendererUpSkinTexture, Button.STATE_UP, false);
		skinSelector.setValueForState(listItemRendererSelectedUpSkinTexture, Button.STATE_HOVER, true);
		skinSelector.setValueForState(listItemRendererSelectedUpSkinTexture, Button.STATE_DOWN, true);
		skinSelector.setValueForState(listItemRendererSelectedUpSkinTexture, Button.STATE_UP, true);

		renderer.stateToSkinFunction = skinSelector.updateValue;

		renderer.defaultLabelProperties.textFormat = ThemeStyles.getTextFormat(ThemeStyles.TEXT_TYPE_INTERACTIVE_DEFAULT);
		renderer.disabledLabelProperties.textFormat = ThemeStyles.getTextFormat(ThemeStyles.TEXT_TYPE_INTERACTIVE_DISABLED);
		renderer.hoverLabelProperties.textFormat = ThemeStyles.getTextFormat(ThemeStyles.TEXT_TYPE_INTERACTIVE_HOVERED);
		renderer.downLabelProperties.textFormat = ThemeStyles.getTextFormat(ThemeStyles.TEXT_TYPE_INTERACTIVE_HOVERED);
		renderer.defaultSelectedLabelProperties.textFormat = ThemeStyles.getTextFormat(ThemeStyles.TEXT_TYPE_INTERACTIVE_SELECTED);

		renderer.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
		renderer.iconPosition = Button.ICON_POSITION_LEFT;
		renderer.accessoryPosition = BaseDefaultItemRenderer.ACCESSORY_POSITION_RIGHT;
		renderer.paddingLeft = 7;
		renderer.paddingRight = 7;
		renderer.accessoryGap = Number.POSITIVE_INFINITY;
		renderer.minWidth = renderer.minHeight = 25;
	}

	protected function defaultHeaderOrFooterRendererInitializer(renderer:DefaultGroupedListHeaderOrFooterRenderer):void
	{
		renderer.contentLabelProperties.textFormat = ThemeStyles.getTextFormat(ThemeStyles.TEXT_TYPE_INTERACTIVE_DEFAULT);

		renderer.paddingTop = renderer.paddingBottom = 2;
		renderer.paddingRight = renderer.paddingLeft = 6;
		renderer.minWidth = renderer.minHeight = 18;
	}

	protected function calloutInitializer(callout:Callout):void
	{
		callout.backgroundSkin = new Scale9Image(calloutBackgroundSkinTextures);

		const arrowSkin:Quad = new Quad(8, 8, 0xff00ff);
		arrowSkin.alpha = 0;
		callout.topArrowSkin =  callout.rightArrowSkin =  callout.bottomArrowSkin =
			callout.leftArrowSkin = arrowSkin;

		callout.paddingTop = callout.paddingBottom = 2;
		callout.paddingRight = callout.paddingLeft = 4;
	}

	protected function headerInitializer(header:Header):void
	{
		header.backgroundSkin = new Scale9Image(listItemRendererUpSkinTexture);

		header.minHeight = 32;

		header.titleProperties.textFormat = ThemeStyles.getTextFormat(ThemeStyles.TEXT_TYPE_SCREEN_HEADER, ThemeStyles.MEDIUM);

		header.paddingTop = header.paddingBottom = 2;
		header.paddingRight = header.paddingLeft = 6;

		header.gap = 2;
		header.titleGap = 4;
	}

	private static function panelHeaderInitializer(header:Header):void
	{
		header.titleProperties.textFormat = ThemeStyles.getTextFormat(ThemeStyles.TEXT_TYPE_PLANE, ThemeStyles.MEDIUM);

		header.minHeight = 22;

		header.paddingTop = header.paddingBottom = 2;
		header.paddingRight = header.paddingLeft = 6;

		header.gap = 2;
		header.titleGap = 4;
	}

}
}
