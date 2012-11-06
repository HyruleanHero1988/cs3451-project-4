boolean predict = true;
int nc=0; // number of collisions
class BALL {
  pt C ; 
  vec V ; 
  float r; 
  float m;   // center, velocity, radius, mass
  pt bC ; 
  vec bV ; 
  float br; 
  float bm;  // back 
  float f=0.99; // friction
  BALL (pt pC, vec pV, float pr, float pm) {
    C=pC; 
    V=pV; 
    r=pr; 
    m=pm;
  };
  void remember () {
    bC=P(C); 
    bV=V(V); 
    br=r; 
    bm=m;
  };
  void back () {
    C=P(bC); 
    V=V(bV); 
    r=br; 
    m=bm;
  };
  /*void show() {
    C.show(r);
  }; 
  void showV() {
    arrow(C, V);
  }; */
  void move() { 
    moveBy(V);
  };
  void move(float t) { 
    moveBy(V(t, V));
  };
  void roll() { 
    move();
  };
  void moveBy(vec mV){
    C.add(mV);
  }
  void addVel(vec mV){
    V=(V(V,mV));
  }
  void showLine(vec sV){
    showLine(1.0,sV);
  }
  void showLine(float sc, vec sV){
    show(C, sc, sV);
  }
  void draw(){
    fill(blue);
    show(C,r);
  };
  
  void drawPart(){
    fill(green);
    show(C,r);
  };
  
  void drawSource(){
    fill(red);
    show(C,r);
  };
    
    
}

BALL B(pt C, float gr, float mass) {
  return new BALL(C, V(0, 0,0), gr, mass);
}

