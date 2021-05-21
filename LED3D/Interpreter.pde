//解释输入内容

class Interpreter{
    public LedArray led3D;
    private String fileWork;   //工作文件
    private Table tableWork;  //表格
    private int counter;  //计数器
    private int sysTimeStart; //起始时间
    private int colorStartCol; //颜色数据的起始列号//工作表格
    Interpreter( Configure tConfs ){
        Setting();
        Ini( tConfs );
    }
    //设置
    public void Setting(){
        colorStartCol = 5;
    }
    
    //初始化
    public void Ini( Configure tConfs ){
        led3D = new LedArray();
        led3D.Ini( tConfs );
        fileWork = tConfs.fileLedRun;
        FileWorkLoad();
        sysTimeStart = 0;
    }
    
    //工作文件加载
    public void FileWorkLoad(){
        if( fileWork.equals( "" ) == true ){
            println("LED工作文件名称为空！");
            return;
        }
        try {
            tableWork = loadTable( fileWork, "header" );
            counter = 0;
        } catch ( Exception e ) {
            println("LED工作文件路径不存在！");
        }
        
    }
    
    //运行
    public void Run(){
        if( counter < tableWork.getRowCount() ){
            counter = RunInstructions( tableWork.getRow(counter), counter );
        }
        led3D.Update();
        fill( 255, 255, 255 );
        textSize( 30 );
        //text( counter, -20, height/3, 0 );
        text( "FRONT", -20, height/2, 0 );
    }
    
    //执行指令
    public int RunInstructions( TableRow tRowNow, int tCounter ){
        switch( tRowNow.getString("COMMAND") ){
            case "SHINE_YZ":
                led3D.SetColorsArea( new PVector(-1,GetParameter(tRowNow)[0],GetParameter(tRowNow)[1]), GetColors(tRowNow) );
                break;
            case "SHINE_XZ":
                led3D.SetColorsArea( new PVector(GetParameter(tRowNow)[0],-1,GetParameter(tRowNow)[1]), GetColors(tRowNow) );
                break;
            case "SHINE_XY":
                led3D.SetColorsArea( new PVector(GetParameter(tRowNow)[0],GetParameter(tRowNow)[1],-1), GetColors(tRowNow) );
                break;
            
            case "DARK_ALL":
                led3D.SetColorsAll( #000000, 0 );
                break;
            case "FILL_ALL":
                led3D.SetColorsAll( GetColors(new StringList(GetParameterStr(tRowNow)[0])) );
                break;
                
            case "JUMP_LOOP":
                return int( GetParameter(tRowNow)[0] );
            case "JUMP_LIMIT":
                if( GetParameter(tRowNow)[1] <= 0 ){
                    break;
                }
                SetParameter( tRowNow, new int[]{GetParameter(tRowNow)[0],GetParameter(tRowNow)[1]-1} );
                return GetParameter(tRowNow)[0];
            
            case "DELAY":
                if( sysTimeStart == 0 ){
                    sysTimeStart = millis();
                }
                if( (millis()-sysTimeStart) < GetParameter(tRowNow)[0] ){
                    return tCounter;
                }
                sysTimeStart = 0;
                break;
            default:
                println("执行工作的命令标记错误  id:"+tCounter+"  COMMAND:"+tRowNow.getString("COMMAND") );
        }
        return tCounter + 1;
    }
    
    //获取参数
    private int[] GetParameter( TableRow tRowNow ){
        return new int[]{ tRowNow.getInt("PARAMETER_A"), tRowNow.getInt("PARAMETER_B") };
    }
    //获取参数
    private String[] GetParameterStr( TableRow tRowNow ){
        return new String[]{ tRowNow.getString("PARAMETER_A"), tRowNow.getString("PARAMETER_B") };
    }
    //设置参数
    private void SetParameter( TableRow tRowNow, int[] tNum ){
        tRowNow.setFloat( "PARAMETER_A", tNum[0] );
        tRowNow.setFloat( "PARAMETER_B", tNum[1] );
    }
    //获取颜色
    private color[][] GetColors( TableRow tRowNow ){
        StringList tColorStrs = new StringList();
        for( int k=colorStartCol; k<tRowNow.getColumnCount(); k++ ){
            tColorStrs.append( tRowNow.getString(k) );
        }
        return GetColors( tColorStrs );
    }
    //获取颜色
    private color[][] GetColors( StringList tColorStr ){
        color[][] tOutColor = new color[2][tColorStr.size()];
        String tempStr;
        for( int k=0; k<tColorStr.size(); k++ ){
            tempStr = tColorStr.get(k).replaceAll("#","");
            if( tempStr.length() <= 6 ){
                tempStr = "FF" + tempStr;
            }
            if( tempStr.length() != 8 ){
                println("颜色数值错误  " + tempStr );
            }
            tOutColor[0][k] = unhex( "FF" + tempStr.substring(2) );
            tOutColor[1][k] = Integer.parseInt( tempStr.substring(0,2), 16 );
        }
        return tOutColor;
    }
  
}
