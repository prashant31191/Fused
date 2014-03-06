package com.cyberpunk.States.Platforms 
{
	import com.cyberpunk.Setup.Config;
	
	/**
	 * ...
	 * @author LilyDrop
	 */
	public class Platform3 extends PlatformBase 
	{
		protected static const BRICK_TYPE:Number = 1;
		protected static const MAX_BRICK:Number  = 2;
		protected static const VELOCITY:Number   = Config.Y_SPEED;
		protected static const X_AXIS:String  	 = 'X_AXIS';

		public function Platform3() 
		{
			super(new PlatformType3(), {type: BRICK_TYPE, amount:MAX_BRICK, axis: X_AXIS});
		}

		override public function get velocity():Number 
		{
			return VELOCITY;
		}
	}

}