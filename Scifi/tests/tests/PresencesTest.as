/**
 * Created by AlexanderSla on 21.11.2014.
 */
package tests {
	import com.chat.model.presences.Presences;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertFalse;
	import org.flexunit.asserts.assertNull;
	import org.flexunit.asserts.assertTrue;
	import org.igniterealtime.xiff.core.UnescapedJID;
	import org.igniterealtime.xiff.data.Presence;

	import robotlegs.bender.framework.impl.RobotlegsInjector;

	public class PresencesTest {

		private var injector:RobotlegsInjector;
		private var presences:Presences;

		private var bob:FakePresence;
		private var joe:FakePresence;

		[Before]
		public function setUp():void {
			injector = new RobotlegsInjector();
			presences = new Presences();

			bob = new FakePresence("bob@localhost");
			joe = new FakePresence("joe@localhost");
		}

		[Test(order=1)]
		public function testCreation():void {

			var bobPresence:Presence = new Presence(null, new UnescapedJID(bob.uid).escaped);
			presences.handlePresence(bobPresence);

			presences.subscribe(bob);
			presences.subscribe(joe);

			assertTrue(bob.online);
			assertFalse(joe.online);


		}

		[Test(order=2)]
		public function testChangeStatus():void {
			var bobPresence:Presence = new Presence(null, new UnescapedJID(bob.uid).escaped, Presence.TYPE_UNAVAILABLE);
			presences.handlePresence(bobPresence);

			assertNull(presences.getByUID(""));
			assertFalse(bob.online);

		}
	}
}

import com.chat.model.presences.IPresenceStatus;

class FakePresence implements IPresenceStatus {

	private var _online:Boolean;
	private var _uid:String;

	public function FakePresence(uid:String) {
		_uid = uid;
	}

	public function get online():Boolean {
		return _online;
	}
	public function set online(value:Boolean):void {
		_online = value;
	}

	public function get uid():String {
		return _uid;
	}
}
