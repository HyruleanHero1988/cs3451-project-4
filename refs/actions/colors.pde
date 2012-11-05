color red, yellow, green, cyan, blue, magenta, dred, dyellow, dgreen, dcyan, dblue, dmagenta, white, black, orange, grey, metal;  // declares color names
void setColors() {
  colorMode(HSB,121);
  red = color(0, 120, 120); yellow = color(20, 120, 120); green = color(40, 120, 120); cyan = color(60, 120, 120); blue = color(80, 120, 120); magenta = color(100, 120, 120); 
  dred = color(0, 120, 60); dyellow = color(20, 120, 60); dgreen = color(40, 120, 60); dcyan = color(60, 120, 60); dblue = color(80, 120, 60); dmagenta = color(100, 120, 60); 
  white = color(0, 0, 120); black = color(0, 120,0); grey = color(0, 0,60); orange = color(10, 100, 120); metal = color(70, 60, 100); };
color ramp(int c, int m) {float f=255.*c/m; return color(f,255.-f,255.-f/2);}
void showColors() {
   pt q=new pt(0,0); translate(30,height-50); 
   pushMatrix();
   fill(red); q.show(10); translate(20,0);
   fill(yellow); q.show(10); translate(20,0);
   fill(green); q.show(10); translate(20,0);
   fill(cyan); q.show(10); translate(20,0);
   fill(blue); q.show(10); translate(20,0);
   fill(magenta); q.show(10); translate(20,0);
   fill(grey); q.show(10); translate(20,0);
   popMatrix();
   translate(0,20);
   pushMatrix();
   fill(dred); q.show(10); translate(20,0);
   fill(dyellow); q.show(10); translate(20,0);
   fill(dgreen); q.show(10); translate(20,0);
   fill(dcyan); q.show(10); translate(20,0);
   fill(dblue); q.show(10); translate(20,0);
   fill(dmagenta); q.show(10); translate(20,0);
   fill(black); q.show(10); translate(20,0);
   popMatrix();
   }

class Colors {
  int c=0; 
  int nc=10;
  Colors (){};
  Colors (int n){nc=n;};
  void total(int n) {nc=n; }
  void reset() {c=nc-1; }
  color next() {c=(c+1)%nc; return color(121*c/nc,121,121); }
}

