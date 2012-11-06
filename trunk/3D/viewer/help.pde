void writeHelp () {fill(dblue);
    int i=0;
    scribe("CS 3451 Project 4, Fall 2012 (Jim Wu and Raymond Garrison)",i++);
    scribe("CURVE c: select nearest control point and drag to move, i: insert point after nearest point,",i++);
    scribe("I: append a point to the curve, s: save points, l: load points, q: subdivide curve, x: delete curve,",i++);
    scribe("Control:  D: zoom, d: rotate and zoom, o: moves obstacle in xy, O: moves obstacle in z,  ",i++);
    scribe("g: moves particle generator in xy, G: moves particle generator in z, a: create particels and animate",i++);    

   }
void pen(color c, float width){
  stroke(c);strokeWeight(width);
}
void writeFooterHelp () {fill(brown);
    scribeFooter("Jim Wu and Raymond Garrison's Project 4.  Press ?:help",1);
  }
void scribeHeader(String S) {text(S,10,20);} // writes on screen at line i
void scribeHeaderRight(String S) {text(S,width-S.length()*15,20);} // writes on screen at line i
void scribeFooter(String S) {text(S,10,height-10);} // writes on screen at line i
void scribeFooter(String S, int i) {text(S,20,height-10-i*20);} // writes on screen at line i from bottom
void scribe(String S, int i) {text(S,10,i*30+20);} // writes on screen at line i
void scribeAtMouse(String S) {text(S,mouseX,mouseY);} // writes on screen near mouse
void scribeAt(String S, int x, int y) {text(S,x,y);} // writes on screen pixels at (x,y)
void scribe(String S, float x, float y) {text(S,x,y);} // writes at (x,y)
void scribe(String S, float x, float y, color c) {fill(c); text(S,x,y); noFill();}
;
