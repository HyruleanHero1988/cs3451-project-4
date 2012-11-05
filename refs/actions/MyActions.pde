 boolean showVertexIds=true, showVertices=true;
 pt XX[] = new pt [4];
 void myActions() { // actions to be executed at each frame
    if(predict) scribe("Exact collision "); else scribe("sampled collision ");                 // prints the value of t on the screen
    if ((mousePressed)&&(!keyPressed)) 
      {dragSelectedBall(); resetBalls(); showPath();  showStart();  } // edit balls
      else {    showPath();  showStart(); }
    strokeWeight(3);          // set fill color to black and stroke width to 3
   };

