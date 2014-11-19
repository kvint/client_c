/**
 * Created by kvint on 19.11.14.
 */
package {
	import com.chat.Chat;
	import com.chat.IChat;
	import com.chat.controller.ChatController;
	import com.chat.model.ChatModel;
	import com.chat.model.communicators.ICommunicatorProvider;
	import com.chat.model.communicators.factory.CommunicatorFactory;

	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNotNull;
	import org.flexunit.asserts.assertNull;
	import org.igniterealtime.xiff.data.Message;
	import org.swiftsuspenders.Injector;

	import robotlegs.bender.framework.api.IInjector;
	import robotlegs.bender.framework.impl.RobotlegsInjector;

	public class AsyncTest {

		public var injector:Injector;
		private var chat:IChat;

		[Before]
		public function setUp():void {
			var bus:IEventDispatcher = new EventDispatcher();
			injector = new RobotlegsInjector();
			injector.map(IChat).toSingleton(Chat);
			injector.map(ChatModel).toSingleton(ChatModel);
			injector.map(ChatController).toSingleton(ChatController);
			injector.map(ICommunicatorProvider).toSingleton(CommunicatorFactory);
			injector.map(IInjector).toValue(injector);
			injector.map(IEventDispatcher).toValue(bus);
			chat = injector.getInstance(IChat);
		}
		[Test]
		public function testFactory():void {
			assertNull(chat.model.communicators.getFor(null));
			assertNotNull(chat.model.communicators.getAll());
			assertEquals(chat.model.communicators.getAll().length, 0);
		}
		[Test]
		public function testCreators():void {
			var msg:Message = new Message();
			assertNull(chat.model.communicators.getFor(123));
			assertNull(chat.model.communicators.getFor({}));
			assertNull(chat.model.communicators.getFor(null));
			assertNull(chat.model.communicators.getFor(msg));
		}

		[After]
		public function tearDown():void {
		}

	}
}
