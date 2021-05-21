
import peasy.PeasyCam;

public Configure confs; //配置
public Camera camera;  //摄像机
public Interpreter main; //主控

public void settings() {
    size(800, 600, P3D);
}


public void setup(){
    confs = new Configure();
    camera = new Camera( this, confs );
    main = new Interpreter( confs );
}


public void draw(){
    lights();
    background(100);
    main.Run();
}
