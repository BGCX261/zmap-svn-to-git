package com.uc55.utils
{
    import mx.containers.*;

    public class BasicToolTip extends Canvas
    {

        public function BasicToolTip() : void
        {
            return;
        }

        public function hide() : void
        {
            visible = false;
            return;
        }

        public function setPos() : void
        {
            x = stage.mouseX;
            y = stage.mouseY;
            parent.setChildIndex(this, parent.numChildren - 1);
            if (y + height > stage.stageHeight)
            {
                y = stage.stageHeight - height;
            }
            if (x + width > stage.stageWidth)
            {
                x = x - width - 40;
            }
            return;
        }

        public function set text(Canvas:String) : void{
        }

        public function get Text() : String
        {
            return null;
        }

        public function show(Canvas:Object = null) : void
        {
            setPos();
            visible = true;
            return;
        }
    }
}
