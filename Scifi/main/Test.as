/**
 * Created by kvint on 04.11.14.
 */
package {
	import flash.display.Sprite;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;

	public class Test extends Sprite {

		private var _pastTime:Number;
		private var _ping:Number;

		public function Test() {
			runTest();
		}

		private function runTest():void {
			_pastTime = new Date().time;
			_ping = getTimer();
			setTimeout(onTimer, Math.random() * 1000);
		}

		public function onTimer():void {
			_ping = getTimer() - _ping;
			var nowTime:Number = new Date().time;

			var correct:Boolean = (nowTime == (_pastTime + _ping));

			if(correct){
				trace("All is good!");
			}else{
				throw new Error();
			}

			runTest();
		}
	}
}
