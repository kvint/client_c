/**
 * Created by kvint on 04.11.14.
 */
package {
	import flash.display.Sprite;

	import org.igniterealtime.xiff.core.UnescapedJID;

	import org.igniterealtime.xiff.data.IQ;

	import org.igniterealtime.xiff.data.Message;
	import org.igniterealtime.xiff.data.archive.ListStanza;

	public class Test extends Sprite {
		public function Test() {
			var test:IQ = new IQ(null, IQ.TYPE_GET);
			test.addExtension(new ListStanza())
			trace(test);
		}
	}
}
