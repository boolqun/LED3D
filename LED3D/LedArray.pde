//LED阵列

class LedArray{
    
    public ArrayList<LedOne[][]> leds; //LED集合
    
    LedArray(){
        
    }
    
    //初始化
    public void Ini( Configure tConfs ){
        leds = new ArrayList<LedOne[][]>();
        IniLeds( tConfs.sideLength, tConfs.step, tConfs.sizeLed, tConfs.colorLedIni, tConfs.alphaLedIni );
    }
    //初始化LED集合
    public void IniLeds( PVector tSideLength, PVector tStep, PVector tSize, color tColor, int tAlpha ){
        PVector tPoint = new PVector( 0, 0, 0 );
        leds.clear();
        for( int z=0; z<tSideLength.z; z++ ){
            tPoint.z = z * ( tStep.z + tSize.z );
            leds.add( new LedOne[int(tSideLength.y)][int(tSideLength.x)] );
            for( int y=0; y<tSideLength.y; y++ ){
                tPoint.y = y * ( tStep.y + tSize.y );
                for( int x=0; x<tSideLength.x; x++ ){
                    tPoint.x = x * ( tStep.x + tSize.x );
                    leds.get(leds.size()-1)[y][x] = new LedOne( tPoint, tColor, tAlpha, tSize );
                }
            }
        }
    }
    
    //更新状态
    public void Update(){
        for( LedOne[][] tLedZ : leds ){
            for( LedOne[] tLedY : tLedZ ){
                for( LedOne tLedX : tLedY ){
                    tLedX.Update();
                }
            }
        }
    }
    
    
    //设置颜色
    public void SetColorsAll( color tColor, int tAlpha ){
        for( LedOne[][] tLedZ : leds ){
            for( LedOne[] tLedY : tLedZ ){
                for( LedOne tLedX : tLedY ){
                    tLedX.SetColors( tColor, tAlpha );
                }
            }
        }
    }
    //设置颜色
    public void SetColorsAll( color[][] tColor ){
        SetColorsAll( tColor[0][0], tColor[1][0] );
    }
    //设置颜色
    public void SetColorsArea( PVector tPoints, color[][] tColors ){
        int tIndex = 0;
        for( int z=0; z<leds.size(); z++ ){
            for( int y=0; y<leds.get(z).length; y++ ){
                for( int x=0; x<leds.get(z)[y].length; x++ ){
                    if( (tPoints.x==-1||tPoints.x==x) && (tPoints.y==-1||tPoints.y==y)  && (tPoints.z==-1||tPoints.z==z) ){
                        leds.get(z)[y][x].SetColors( tColors[0][tIndex], tColors[1][tIndex] );
                        tIndex ++;
                    }
                }
            }
        }
    }
    
}
