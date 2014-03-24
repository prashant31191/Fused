package com.fused.States.Background
{
	import flash.display.Sprite;
	import com.fused.Setup.Config;
	import flash.display.BitmapData;

    public class ScrollingBackground extends Sprite
    {
    	protected var infiniteScrolling:InfiniteScrolling;
		protected var earth:Decal;

		[Embed(source = '../../../../../img/earth.png')]
		private var earthPNG:Class

        public function ScrollingBackground ()
        {
            infiniteScrolling = new InfiniteScrolling();
            addChild(infiniteScrolling);

            earth = new Decal();
			earth.bitmapData = new BitmapData(new Background().width, new Background().height); 
			earth.move(Config.STAGE_WIDTH / 2, Config.STAGE_HEIGHT / 2);
			earth.parallaxAmount = 2;

			addChild(earth);
        }

        public function move(dx:Number, dy:Number):void 
        {
        	infiniteScrolling.move(dx, dy);
			earth.move(dx, dy);
        }
    }
}
