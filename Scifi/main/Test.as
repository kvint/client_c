/**
 * Created by kvint on 04.11.14.
 */
package {
	import flash.display.Sprite;

	import org.igniterealtime.xiff.data.Message;

	public class Test extends Sprite {
		public function Test() {
			var message:Message = new Message();
			message.receipt = Message.RECEIPT_RECEIVED;
			trace(message.xml.toXMLString());
			message.receipt = null;
			trace(message.xml.toXMLString());
		}
	}
}
