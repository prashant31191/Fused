package com.fused.States.Background
{
	import flash.display.Bitmap;
	import flash.display.BlendMode;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author Zachary Foley
	 */
	public class Decal extends Bitmap
	{
		private var matrix:Matrix;
		public var parallaxAmount:Number = 1;
		
		public function Decal() 
		{
			matrix = this.transform.matrix.clone();
			//this.blendMode = BlendMode.MULTIPLY;
			this.smoothing = true;
		}

		public function move(dx:Number, dy:Number):void 
		{
			matrix = this.transform.matrix.clone();
			matrix.translate(dx*parallaxAmount, dy*parallaxAmount);
			this.transform.matrix = matrix;
			if (stage == null) { return };
			if (this.getBounds(stage).intersects(new Rectangle(0,0,stage.stageWidth, stage.stageHeight))) {
				this.visible = true;
			} else {
				this.visible = false;
			}
		}
	}
}
