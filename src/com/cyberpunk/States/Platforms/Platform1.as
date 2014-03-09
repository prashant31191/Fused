package com.cyberpunk.States.Platforms 
{
	import com.cyberpunk.Setup.Config;
	/**
	 * ...
	 * @author LilyDrop
	 */
	public class Platform1 extends PlatformBase 
	{
		protected static const MAX_BRICK:Number  = 5;
		protected static const VELOCITY:Number   = 0;
		protected static const X_AXIS:String  	 = 'X_AXIS';

		protected var platforms:Array = [   'Platform1Type1', 
										    'Platform1Type2', 
										    'Platform1Type3',
										    'Platform1Type4'
		];

		public function Platform1() 
		{
			Platform1Type1;
			Platform1Type2;
			Platform1Type3;
			Platform1Type4;

			super(new PlatformType1(), {amount:MAX_BRICK, axis: X_AXIS});
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