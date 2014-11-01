/**
 * Created by kuts on 2/28/14.
 */
package com.scifi.view.utils {
import flash.geom.Point;

public class PointUtils {

	public static function isEqual(pt1:Point, pt2:Point):Boolean
	{
		return pt1.x == pt2.x && pt1.y == pt2.y;
	}

}
}
