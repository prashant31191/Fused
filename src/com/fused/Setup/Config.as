package com.fused.Setup 
{
	/**
	 * ...
	 * @author LilyDrop
	 */
	public class Config 
	{
		// Movements - Arrows
		public static const LEFT_ARROW:Number  = 37;
		public static const UP_ARROW:Number    = 38;
		public static const RIGHT_ARROW:Number = 39;
		public static const DOWN_ARROW:Number  = 40;
		
		// Movements - Letters
		public static const A_LETTER:Number = 65;
		public static const W_LETTER:Number = 87;
		public static const S_LETTER:Number = 83;
		public static const D_LETTER:Number = 68;
		
		public static const STAGE_WIDTH:Number  = 640;
		public static const STAGE_HEIGHT:Number = 480;

		public static const Y_SPEED:Number  = 15;
		public static const X_SPEED:Number  = 20;

		/*Platforms to be added, below the player 
		every time he goes further down*/
		public static const MIN_PLATFORMS:Number = 10;
		public static const MAX_PLATFORMS:Number = 15;

		public static const MIN_ENEMY:Number = 1;
		public static const MAX_ENEMY:Number = 5;
	}
}
