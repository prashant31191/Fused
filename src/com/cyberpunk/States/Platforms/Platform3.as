package com.cyberpunk.States.Platforms 
{
	import com.cyberpunk.Setup.Config;
	
	/**
	 * ...
	 * @author LilyDrop
	 */
	public class Platform3 extends PlatformBase 
	{
		protected static const MAX_BRICK:Number  = 2;
		protected static const VELOCITY:Number   = -1;
		protected static const X_AXIS:String  	 = 'X_AXIS';

		protected var platforms:Array = [ 'Platform3Type1' ];

		public function Platform3() 
		{
			Platform3Type1;

			super(new PlatformType3(), {amount:MAX_BRICK, axis: X_AXIS});
		}

		// override public function breakPlatform():void 
		// {
			
		// }

		override public function get velocity():Number 
		{
			return VELOCITY;
		}

		override public function get platformTypeName():Array 
		{
			return platforms;
		}
	}

}