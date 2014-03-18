package com.cyberpunk.States.Background 
{

	/**
	 * ...
	 * @author LilyDrop
	 */
	public class InfiniteScrolling extends ScrollingLayer
	{
		[Embed(source = '../../../../../img/background.jpg')]
		private var bitmapClass:Class;

		public function InfiniteScrolling() 
		{
			scrollingBitmap = new bitmapClass().bitmapData;
		}
	}
}
