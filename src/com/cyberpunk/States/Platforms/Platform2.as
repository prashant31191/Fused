package com.cyberpunk.States.Platforms 
{
	import com.cyberpunk.Setup.Config;
	
	/**
	 * ...
	 * @author LilyDrop
	 */
	public class Platform2 extends PlatformBase 
	{
		protected static const BRICK_TYPE:Number = 3;
		protected static const MAX_BRICK:Number  = 5;
		protected static const VELOCITY:Number   = -10;
		protected static const Y_AXIS:String  	 = 'Y_AXIS';

		public function Platform2() 
		{
			super(new PlatformType2(), {type: BRICK_TYPE, amount:MAX_BRICK, axis: Y_AXIS});
		}

		override public function get velocity():Number 
		{
			return VELOCITY;
		}
	}

}