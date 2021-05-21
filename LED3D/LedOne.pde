//单个LED

class LedOne{
    public PVector point; //坐标
    public color lightRGB;  //颜色
    public int lightAlpha;  //透明度
    public PVector size; //大小
    
    LedOne(){
        
    }
    
    LedOne( PVector tPoint, color tColor, int tAlpha, PVector tSize ){
        SetLed( tPoint, tColor, tAlpha, tSize );
    }
    
    //设置LED
    public void SetLed( PVector tPoint, color tColor, int tAlpha, PVector tSize ){
        point = tPoint.copy();
        size = tSize;
        SetColors( tColor, tAlpha );
    }
    //设置颜色
    public void SetColors( color tColor, int tAlpha ){
        lightRGB = tColor;
        lightAlpha = tAlpha;
    }
    
    //更新状态
    public void Update(){
        pushMatrix();
        translate( point.x, point.y, point.z );
        stroke( lightRGB, lightAlpha );
        fill( lightRGB, lightAlpha );
        
        box( size.x, size.y, size.z );
        popMatrix();
    }
    
}
