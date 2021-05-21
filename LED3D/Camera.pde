//3D观察

class Camera{
    public PeasyCam cam;  //照相机
    Camera( PApplet tParent, Configure tConfs ){
        Ini( tParent, tConfs );
    }
    
    //初始化
    public void Ini( PApplet tParent, Configure tConfs ){
        cam = new PeasyCam( tParent, (tConfs.camDistanceMax+tConfs.camDistanceMin)/2 );
        cam.setMinimumDistance( tConfs.camDistanceMin );
        cam.setMaximumDistance( tConfs.camDistanceMax );
        cam.lookAt( tConfs.camLookAt.x, tConfs.camLookAt.y, tConfs.camLookAt.z );
    }
  
}
