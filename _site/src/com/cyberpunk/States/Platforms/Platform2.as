package com.cyberpunk.States.Platforms 
{
	import com.cyberpunk.Setup.Config;
	
	/**
	 * ...
	 * @author LilyDrop
	 */
	public class Platform2 extends PlatformBase 
	{
		protected static const MAX_BRICK:Number  = 5;
		protected static const VELOCITY:Number   = -10;
		protected static const Y_AXIS:String  	 = 'Y_AXIS';

		protected var platforms:Array = [   'Platform2Type1', 
										    'Platform2Type2', 
										    'Platform2Type3'
		];

		public function Platform2() 
		{
			Platform2Type1;
			Platform2Type2;
			Platform2Type3;

			super(new PlatformType2(), {amount:MAX_BRICK, axis: Y_AXIS});
		}

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