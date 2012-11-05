boolean predict = true;
int nc=0; // number of collisions
class BALL {
  pt C ; vec V ; float r; float m;   // center, velocity, radius, mass
  pt bC ; vec bV ; float br; float bm;  // back 
  float f=0.99; // friction
  BALL (pt pC, vec pV, float pr, float pm) {C=pC; V=pV; r=pr; m=pm;};
  void remember () {bC=P(C); bV=V(V); br=r; bm=m;};
  void back () {C=P(bC); V=V(bV); r=br; m=bm;};
  void show() {C.show(r);}; 
  void showV() {arrow(C,V);}; 
  void move() { C.translateBy(V); };
  void move(float t) { C.translateBy(t,V); };
  void roll() { move();};
  }
BALL B(pt C) {return new BALL(C, V(0,0),gr,1);}
float gr=30;                     // radius of small balls
int nB = 5;                // number of balls
int sB = 0;                // selected ball
BALL[] B = new BALL[nB];   // table of balls
void declareBalls() {for(int i=0; i<nB; i++) B[i]=B(P((i+1)*width/(nB+2),height/2));}; 
void resetBalls(){B[0].m=pow(2,20); B[1].V=S(0.5,V(B[1].C,B[3].C)); B[2].V=S(0.5,V(B[2].C,B[4].C)); rememberBalls(); };
void setBalls(float x0, float y0, float x1, float y1, float dx1, float dy1, float x2, float y2, float dx2, float dy2){
   B[0].C.setTo(x0,y0); B[1].C.setTo(x1,y1); B[2].C.setTo(x2,y2); 
   B[0].V.setTo(0,0); B[1].V.setTo(dx1,dy1); B[2].V.setTo(dx2,dy2); 
   B[3].C=S(B[1].C,2,B[1].V); B[4].C=S(B[2].C,2,B[2].V);
   rememberBalls(); }
void printBalls() {println("setBalls("+B[0].C.x+","+B[0].C.y+","+B[1].C.x+","+B[1].C.y+","+B[1].V.x+","+B[1].V.y+","+B[2].C.x+","+B[2].C.y+","+B[2].V.x+","+B[2].V.y +");");}
void rememberBalls() {for(int i=0; i<3; i++) B[i].remember();}
void backBalls() {for(int i=0; i<3; i++) B[i].back();}
void rollBalls() {for(int i=0; i<3; i++) B[i].roll();}
void rollBalls(float t) {for(int i=0; i<3; i++) B[i].move(t);}
void selectBall() {for(int i=0; i<nB; i++) if (B[i].C.disToMouse()<B[sB].C.disToMouse()) sB=i;};
void dragSelectedBall() {B[sB].C.translateBy(mouseDrag()); };
void showStart() {
  noFill(); stroke(dgreen);  strokeWeight(3);B[1].showV();  strokeWeight(1); B[3].show();
  noFill(); stroke(dblue);  strokeWeight(3); B[2].showV(); strokeWeight(1); B[4].show(); 
   }
void showBalls() {
  // Colors c= new Colors(nB); c.reset(); for(int i=0; i<nB; i++) {fill(c.next(),60); B[i].show(); };
  fill(red,60); B[0].show();
  fill(green,60); B[1].show(); 
  fill(blue,60); B[2].show(); 
   }
void drawBalls() {
  noFill(); 
  stroke(orange); B[1].show(); 
  stroke(yellow); B[2].show(); 
  noStroke();
   }

void showPath() {
  nc=0;
  rememberBalls();
  stroke(black); showBalls(); noStroke();
  for (int i=0; i<5; i++) { 
    if(predict) {
      float rm=1;
      while(rm>0) {
        float t01,t12,t02; // collision times (-1 if no collision)
        t01=collision(B[0],B[1]); if(!approaching(B[0],B[1])) t01=2;
        t02=collision(B[0],B[2]); if(!approaching(B[0],B[2])) t02=2;
        t12=collision(B[1],B[2]); if(!approaching(B[1],B[2])) t12=2;
        float m = min(min(rm,t01),min(t02,t12));
        rollBalls(m); 
        if((m==t01)||(m==t12)) {stroke(dyellow); noFill(); B[1].show(); noStroke();}
        if((m==t02)||(m==t12)) {stroke(orange); noFill(); B[2].show(); noStroke();}
        if(m==t01) shock(B[0],B[1]); if(m==t02) shock(B[0],B[2]); if(m==t12) shock(B[1],B[2]);
        rm-=m;
      };

      }
    else {
      rollBalls(); 
      if(interfere(B[1],B[2])&&approaching(B[1],B[2])) shock(B[1],B[2]); 
      if(interfere(B[0],B[1])&&approaching(B[0],B[1])) shock(B[0],B[1]); 
      if(interfere(B[0],B[2])&&approaching(B[0],B[2])) shock(B[0],B[2]); 
      };
      showBalls();
    };  
  backBalls();
  scribe(nc+" collisions",1);
  }
float collision(BALL A, BALL B) {   // computes collision time t and returns it if 0<t<1. Otherwise, returns 2
  vec W=M(-1,A.V,1,B.V); vec D=V(A.C,B.C); float a=dot(W,W); float b=2*dot(D,W); float c=dot(D,D)-sq(A.r+B.r); // coeffs of quadratic equation
  float d=sq(b)-4*a*c; // discriminant of quadratic equation
  if (d>=0) {float t1=(-b-sqrt(d))/2/a; if(t1<0) t1=2; float t2=(-b+sqrt(d))/2/a; if(t2<0) t2=2; float m=min(t1,t2); 
              if ((-0.02<=m)&&(m<=1.02)) return m; } //* 
  return 2; }
  
void shock(BALL A, BALL B) {nc++; // computes new velocities for elastic shock
   vec N = U(V(A.C,B.C)); vec D=S(dot(M(-1,A.V,1,B.V),N),N); A.V.setTo(M(1,A.V,2*B.m/(A.m+B.m),D)); B.V.setTo(M(1,B.V,-2*A.m/(A.m+B.m),D));} 

boolean interfere(BALL A, BALL B) {if(A.r>0) return d(A.C,B.C)<=A.r+B.r+0.01 ; else return d(A.C,B.C)>=-A.r-B.r-0.01 ; }  //* if balls interfere 
boolean approaching(BALL A, BALL B) {vec N = V(A.C,B.C); return dot(N,M(1,B.V,-1,A.V))<0; }  //* approaching balls 

