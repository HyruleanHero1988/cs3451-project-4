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
  void show() {
    C.show(r);
  }; 
  void showV() {
    arrow(C, V);
  }; 
  void move() { 
    C.translateBy(V);
  };
  void move(float t) { 
    C.translateBy(t, V);
  };
  void roll() { 
    move();
  };
}
BALL B(pt C) {
  return new BALL(C, V(0, 0), gr, 1);
}

