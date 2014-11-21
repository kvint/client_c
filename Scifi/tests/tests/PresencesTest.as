/**
 * Created by AlexanderSla on 21.11.2014.
 */
package tests {
	import com.chat.model.presences.IPresences;
	import com.chat.model.presences.IPresencesHandler;
	import com.chat.model.presences.Presences;

	import org.flexunit.asserts.assertEquals;

	import robotlegs.bender.framework.impl.RobotlegsInjector;

	public class PresencesTest {

		private var injector:RobotlegsInjector;

		[Before]
		public function setUp():void {
			injector = new RobotlegsInjector();
			var presences:Presences = new Presences();
			injector.map(IPresences).toValue(presences);
			injector.map(IPresencesHandler).toValue(presences);
		}

		[Test]
		public function testInstance():void {
			var instance:* = injector.getInstance(IPresences);
			var instance2:* = injector.getInstance(IPresencesHandler);
			assertEquals(instance, instance2);
		}
	}
}
