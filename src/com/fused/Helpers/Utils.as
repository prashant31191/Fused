package com.fused.Helpers 
{
	/**
	 * ...
	 * @author LilyDrop
	 */
	public class Utils 
	{
		/**
		* Pass a min and max value
		* and return a random integer inbetween.
		*/
		public static function getRandomInt(min:int, max:int):int 
		{
			return Math.floor(Math.random() * (max - min + 1)) + min;
		}
		
		/**
		* Pass an array
		* and return a random integer from this array.
		*/
		public static function getRandomIntFromArray(array:Array):int
		{
			return array[Math.floor(Math.random() * array.length)];
		}
		
		/**
		* Return the distance between 
		* two given points.
		*/
		public static function calculateDistance(xPos:int, yPos:int, xPos2:int, yPos2:int):int 
		{
			var diffX:int    = xPos - xPos2;
			var diffY:int    = yPos - yPos2;
			var distance:int = Math.sqrt(diffX * diffX + diffY * diffY);
			if (distance < 0) distance *= 1;
			return distance;
		}

		/**
		 * Get distance
		 * @param	delta_x
		 * @param	delta_y
		 * @return
		 */
		public static function getDistance(delta_x:Number, delta_y:Number):Number
		{
			return Math.sqrt((delta_x * delta_x) + (delta_y * delta_y));
		}
		
		/**
		 * Get radians
		 * @param	delta_x
		 * @param	delta_y
		 * @return
		 */
		public static function getRadians(delta_x:Number, delta_y:Number):Number
		{
			var r:Number = Math.atan2(delta_y, delta_x);
			
			if (delta_y < 0)
			{
				r += (2 * Math.PI);
			}
			return r;
		}
		
		/**
		 * Get degrees
		 * @param	radians	Takes radians
		 * @return	Returns degrees
		 */
		public static function getDegrees(radians:Number):Number
		{
			return Math.floor(radians / (Math.PI / 180));
		}
	}
}
