class bGenerator {
  
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
  } //* 
  return 2;
}

void shock(BALL A, BALL B) {
  nc++; // computes new velocities for elastic shock
  vec N = U(V(A.C, B.C)); 
  vec D=V(dot(V(-1, A.V, 1, B.V), N), N); 
  A.V = (V(1, A.V, 2*B.m/(A.m+B.m), D)); 
  B.V = (V(1, B.V, -2*A.m/(A.m+B.m), D));
} 

boolean interfere(BALL A, BALL B) {
  if (A.r>0) return d(A.C, B.C)<=A.r+B.r+0.01 ; 
  else return d(A.C, B.C)>=-A.r-B.r-0.01 ;
}  //* if balls interfere 
boolean approaching(BALL A, BALL B) {
  vec N = V(A.C, B.C); 
  return dot(N, V(1, B.V, -1, A.V))<0;
}  //* approaching balls 

