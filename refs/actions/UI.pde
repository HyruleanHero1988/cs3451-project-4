void scribe(String S) {fill(black); text(S,20,20); noFill();}
void scribe(String S, int i) {fill(black); text(S,20,20+i*20); noFill();}

void mousePressed() { if (mouse().isInWindow()) selectBall(); else ; } 
void mouseReleased() { resetBalls(); printBalls();}

void keyPressed() {  
  if (key=='0') setBalls(426.0,235.0,99.0,509.0,93.5,-83.0,85.0,285.0,98.0,2.0);  // example
  if (key=='1') setBalls(300,150,116,300,71,0,300,300,0,0);  // time
  if (key=='2') setBalls(300,150,65,325,125,0,300,300,0,0); // angle
  if (key=='3') setBalls(300,150,165,370,90,0,300,300,0,0);  // miss
  if (key=='4') setBalls(300,130,100,500,100,-100,300,240,0,0); // multiple
  if (key=='5') setBalls(300.0,150.0,101.0,360.0,82.0,-4.5,300.0,300.0,0.0,0.0);// multiple
  if (key=='6') setBalls(258.0,164.0,100.0,500.0,79.5,-90.0,300.0,240.0,0.0,0.0);
  if (key=='7') setBalls(291.0,72.0,121.0,450.0,74.5,-95.0,291.0,157.0,0.0,0.0);
  if (key=='8') setBalls(463.0,289.0,295.0,452.0,36.5,-82.0,178.0,196.0,64.0,8.0);
  if (key=='9') setBalls(330.0,179.0,145.0,401.0,55.5,-55.0,435.0,424.0,-62.0,-86.5);
  if (key=='!') setBalls(313.0,152.0,123.0,436.0,72.5,-53.5,300.0,240.0,0.0,0.0);
  if (key==' ') showHelpText=!showHelpText ; 
  if (key=='z') predict=!predict ; 
  if (key=='X') {String S=" "+"-####.tif"; saveFrame(S);};   ;
  if (key=='?') printIt=true;  // toggle debug mode
   };     

void showHelp() {
    fill(dblue); pushMatrix(); translate(20,20);
     text("Collisions by Jarek Rossignac",0,0); translate(0,20);
     text("  ",0,0); translate(0,20);
     text("First click in the window to activate it ",0,0); translate(0,20);
     text("Press SPACE to show/hide this help text",0,0); translate(0,20);
     text("Click & drag balls ",0,0); translate(0,20);
     text("Press z to toggle between exact and sampled collision",0,0); translate(0,20);
     text("  ",0,0); translate(0,20);
     text("Press 'X' top snap a picture (when running Processing, not in browser)",0,0); translate(0,20);
     text("'?' print debugging stuff (when running Processing, not in browser)   ",0,0); translate(0,20);
     popMatrix(); noFill();
   }
     
