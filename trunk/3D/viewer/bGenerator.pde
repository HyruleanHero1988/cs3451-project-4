class bGenerator {
  BALL source;
  BALL obstacle;
  ArrayList <BALL> balls;
  float stept; //full step
  float t = 1; //current time
  float gr = 10;
  int[] cOne = {
    -1, -1
  };
  int[] cTwo = {
    -1, -1
  };

  bGenerator() {
    balls = new ArrayList<BALL>(300);
    source = B(P(-300, 170, -360), 50, 20);
    obstacle = B(P(-230, 195, 195), 100, 20);
  }
  void step() {
    if (balls.size()<50) generateBall();
    float s = 0;
    float t = 0;
    while (t<1) {
      s = nextCollision();
      if (s==0) s = 0.05;
      if (s>1-t) s = 1-t;
      for (int i = balls.size()-1; i >= 0; i--) {
        BALL cb = balls.get(i);
        cb.remember();
        cb.move(s);
      }
      t += s;
      for (int i = 0; i <= balls.size()-1; i++) {
        BALL cb = balls.get(i);
        for (int j = i+1;j<balls.size();j++) {
          BALL cn = balls.get(j);
          if (interfere(cn, cb)) shock(cn, cb);
        }
        if (interfere(cb, obstacle)) bounce(cb);
      }
      if (t<0.9)
        println("s " + s + "   t " +t);
    }
    for (int i = balls.size()-1; i >= 0; i--) {
      BALL cb = balls.get(i);
      cb.addVel(V(.35, C.fieldOn(cb.C)));
      cb.addVel(V(0.1,U(V(cb.C, obstacle.C))));
      if (C.onEnd(cb.C)) balls.remove(i);
    }
  }
  float nextCollision() {
    float tcol = 1.0;
    cOne[0] = -1;
    cOne[1]=-1;
    cTwo[0] = -1;
    cTwo[1]=-1;
    for (int i = 0; i < balls.size()-1; i++) {
      BALL cb = balls.get(i);
      for (int j = i+1;j<balls.size();j++) {
        BALL cn = balls.get(j);
        float tnew = collision(cb, cn);
        if (tnew<tcol) {
          tcol = tnew;
        }
      }
      float tnew = collision(cb, obstacle);
      if (tnew<tcol) {
        tcol = tnew;
      }
    }
    return tcol;
  }
  void moveBy(vec V) {
    obstacle.moveBy(V);
  }
  
  void moveSourceBy(vec V) {
   source.moveBy(V); 
  }
  void generateBall() {
    vec ranDir = V(random(-1, 1), random(-1, 1), random(-1, 1));
    ranDir = U(ranDir);
    pt newOri = P(source.C, source.r, ranDir);
    BALL newball = B(newOri, gr, 1);
    balls.add(newball);
  }
  void draw() {
    pen(black,1);noFill();noStroke();
    source.drawSource();
    noStroke();fill(blue);
    obstacle.draw();
    fill(red);
    for (int i = balls.size()-1; i >= 0; i--) {
      balls.get(i).drawPart();
    }
  }

  void shock(BALL A, BALL B) {
    nc++; // computes new velocities for elastic shock
    vec N = U(V(A.C, B.C)); 
    vec D=V(dot(V(-1, A.V, 1, B.V), N), N); 
    A.V = (V(1, A.V, 2*B.m/(A.m+B.m), D)); 
    B.V = (V(1, B.V, -2*A.m/(A.m+B.m), D));
  }
  void bounce(BALL A) {
    vec N = U(V(A.C, obstacle.C));
    vec vel = A.V;
    vec D = V(dot( vel, N), N); //this gets the perpendicular portion
    A.addVel(V(vel, -1.5, D));
  }
}
float collision(BALL A, BALL B) {   // computes collision time t and returns it if 0<t<1. Otherwise, returns 2
  vec W=V(-1, A.V, 1, B.V); 
  vec D=V(A.C, B.C); 
  float a=dot(W, W); 
  float b=2*dot(D, W); 
  float c=dot(D, D)-sq(A.r+B.r); // coeffs of quadratic equation
  float d=sq(b)-4*a*c; // discriminant of quadratic equation
  if (d>=0) {
    float t1=(-b-sqrt(d))/2/a; 
    if (t1<0) t1=2; 
    float t2=(-b+sqrt(d))/2/a; 
    if (t2<0) t2=2; 
    float m=min(t1, t2); 
    if ((-0.02<=m)&&(m<=1.02)) return m;
  }
  return 2;
}

boolean interfere(BALL A, BALL B) {
  if (A.r>0) return d(A.C, B.C)<=A.r+B.r+0.01 ; 
  else return d(A.C, B.C)>=-A.r-B.r-0.01 ;
}  //* if balls interfere 
boolean approaching(BALL A, BALL B) {
  vec N = V(A.C, B.C); 
  return dot(N, V(1, B.V, -1, A.V))<0;
}  //* approaching balls 

