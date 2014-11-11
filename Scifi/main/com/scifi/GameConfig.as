package com.scifi {

import com.chat.config.ChatConfig;
import com.scifi.config.CommandsConfig;
import com.scifi.config.MembershipConfig;
import com.scifi.config.ViewConfig;

import flash.events.IEventDispatcher;

import robotlegs.bender.framework.api.IConfig;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.IInjector;
import robotlegs.bender.framework.api.LogLevel;

public class GameConfig implements IConfig {

	[Inject]
	public var injector		:IInjector;

	[Inject]
	public var context		:IContext;

	[Inject]
	public var bus			:IEventDispatcher;

	public function configure():void
	{
		context.logLevel = LogLevel.WARN;

		context.configure(ViewConfig);
		context.configure(ChatConfig);
		context.configure(CommandsConfig);
		context.configure(MembershipConfig);
	}

}
}