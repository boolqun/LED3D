//配置

class Configure{
    public String fileLedRun;   //LED运行文件
    public PVector sideLength; //3DLED的边长（以LED个数为单位）
    public PVector step; //每一个LED的间隔距离（以像素为单位）
    public PVector sizeLed;  //单个LED的大小（以像素为单位）
    public color colorLedIni;  //LED初始颜色
    public int alphaLedIni; //LED初始透明度
    public int camDistanceMax; //照相机最远距离
    public int camDistanceMin; //照相机最近距离
    public PVector camLookAt; //照相机观察点
    Configure(){
        Setting();
    }
    
    //设置
    public void Setting(){
        fileLedRun = "./work/LedRun.csv";   //LED运行文件
        
        sideLength = new PVector( 10, 10, 10 ); //3DLED的边长（决定LED的数量）
        step = new PVector( 5, 5, 5 );; //每一个LED的间隔距离
        sizeLed = new PVector( 5, 5, 5 );  //单个LED的大小
        colorLedIni = color( 0, 0, 255 );  //LED初始颜色
        alphaLedIni = 255; //LED初始透明度
        
        camDistanceMax = 500; //照相机最远距离
        camDistanceMin = 10; //照相机最近距离
        camLookAt = new PVector( (sizeLed.x+step.x)*sideLength.x/2, (sizeLed.y+step.y)*sideLength.y/2, (sizeLed.z+step.z)*sideLength.z/2 ); //照相机观察点
    }
    
    
}
