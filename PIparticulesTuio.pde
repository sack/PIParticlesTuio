import TUIO.*;
TuioProcessing tuioClient;


ArrayList<Particle> particles;
color fin;
float amt = 0.0;
color partColor;
void setup() {
  size(800,600);
  particles = new ArrayList<Particle>();
  smooth();
  fin = color(random(255),random(255),random(255));
tuioClient  = new TuioProcessing(this);
}

void draw() {
  background(0);

 Vector tuioCursorList = tuioClient.getTuioCursors();
   for (int i=0;i<tuioCursorList.size();i++) {
      TuioCursor tcur = (TuioCursor)tuioCursorList.elementAt(i);
      Vector pointList = tcur.getPath();
      
      if (pointList.size()>0) {
        //stroke(0,0,255);
        TuioPoint start_point = (TuioPoint)pointList.firstElement();;
        for (int j=0;j<pointList.size();j++) {
           TuioPoint end_point = (TuioPoint)pointList.elementAt(j);
          // line(start_point.getScreenX(width),start_point.getScreenY(height),end_point.getScreenX(width),end_point.getScreenY(height));
           start_point = end_point;
        }
         if (tcur.getMotionSpeed()>0.03){
             particles.add(new Particle(new PVector(tcur.getScreenX(width),tcur.getScreenY(height)))); 
         }
      }
   }

 
  Iterator<Particle> it = particles.iterator();
  while (it.hasNext()) {
    Particle p = it.next();
    p.run();
    if (p.isDead()) {
      it.remove();
    }
  }
}




