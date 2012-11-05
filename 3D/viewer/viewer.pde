//*********************************************************************
//**                            3D template                          **
//**                 Jarek Rossignac, Oct  2012                      **   
//*********************************************************************
import processing.opengl.*;                // load OpenGL libraries and utilities
import javax.media.opengl.*; 
import javax.media.opengl.glu.*; 
import java.nio.*;
GL gl; 
GLU glu; 

// ****************************** GLOBAL VARIABLES FOR DISPLAY OPTIONS *********************************
boolean 

showControl=true, 

showHelpText=false; 

// String SCC = "-"; // info on current corner

// ****************************** VIEW PARAMETERS *******************************************************
pt F = P(0, 0, 0); 
pt T = P(0, 0, 0); 
pt E = P(0, 0, 1000); 
vec U=V(0, 1, 0);  // focus  set with mouse when pressing ';', eye, and up vector
pt Q=P(0, 0, 0); 
vec I=V(1, 0, 0); 
vec J=V(0, 1, 0); 
vec K=V(0, 0, 1); // picked surface point Q and screen aligned vectors {I,J,K} set when picked
void initView() {
  Q=P(0, 0, 0); 
  I=V(1, 0, 0); 
  J=V(0, 1, 0); 
  K=V(0, 0, 1); 
  F = P(0, 0, 0); 
  E = P(0, 0, 1000); 
  U=V(0, 1, 0);
} // declares the local frames

// ******************************** MESHES ***********************************************

// ******************************** CURVES & SPINES ***********************************************
Curve C = new Curve(5);
int nsteps=250; // number of smaples along spine

pt sE = P(), sF = P(); 
vec sU=V(); //  view parameters (saved with 'j'

// *******************************************************************************************************************    SETUP
void setup() {
  size(800, 800, OPENGL);  
  setColors(); 
  sphereDetail(3); 
  PFont font = loadFont("GillSans-24.vlw"); 
  textFont(font, 20);  // font for writing labels on //  PFont font = loadFont("Courier-14.vlw"); textFont(font, 12); 
  // ***************** OpenGL and View setup
  glu= ((PGraphicsOpenGL) g).glu;  
  PGraphicsOpenGL pgl = (PGraphicsOpenGL) g;  
  gl = pgl.beginGL();  
  pgl.endGL();
  initView(); // declares the local frames for 3D GUI

  // ***************** Load Curve
  C.loadPts();

  // ***************** Set view

  F=P(); 
  E=P(0, 0, 1500);
}

// ******************************************************************************************************************* DRAW      
void draw() {  
  background(white);
  // -------------------------------------------------------- Help ----------------------------------
  if (showHelpText) {
    camera(); // 2D display to show cutout
    lights();
    fill(black); 
    writeHelp();
    return;
  } 

  // -------------------------------------------------------- 3D display : set up view ----------------------------------
  camera(E.x, E.y, E.z, F.x, F.y, F.z, U.x, U.y, U.z); // defines the view : eye, center, up
  vec Li=U(A(V(E, F), 0.1*d(E, F), J));   // vec Li=U(A(V(E,F),-d(E,F),J)); 
  directionalLight(255, 255, 255, Li.x, Li.y, Li.z); // direction of light: behind and above the viewer
  specular(255, 255, 0); 
  shininess(5);

  // -------------------------- display and edit control points of the spines and box ----------------------------------   
  SetFrame(Q, I, J, K);  // showFrame(Q,I,J,K,30);  // sets frame from picked points and screen axes
  // rotate view 
  if (showControl) {
    fill(red, 255); 
    C.showAll(5);
    pen(red,3);
//    C.showVec(I);
    noStroke();
  }
  if (keyPressed&&(key=='a'||key=='s')) {
    vec md = MouseDrag();
    if (!pressed) {
      C.pickMouse();
      C.showPick(15);
    }
    else if (key =='a'){
      vec exy = V(md.x,I);
      exy.add(V(-md.y,J));
      C.dragPoint(exy);
    }
    else if(key == 's'){
      vec ez = V(md.y,K);
      C.dragPoint(ez);
    }
  }
  if (!keyPressed&&mousePressed) {
    E=R(E, PI*float(mouseX-pmouseX)/width, I, K, F); 
    E=R(E, -PI*float(mouseY-pmouseY)/width, J, K, F);
  } // rotate E around F 
  if (keyPressed&&key=='D'&&mousePressed) {
    E=P(E, -float(mouseY-pmouseY), K);
  }  //   Moves E forward/backward
  if (keyPressed&&key=='d'&&mousePressed) {
    E=P(E, -float(mouseY-pmouseY), K);
    U=R(U, -PI*float(mouseX-pmouseX)/width, I, J);
  }//   Moves E forward/backward and rotatees around (F,Y)
  C.showLoop();
} // end draw


// ****************************************************************************************************************************** INTERRUPTS
boolean pressed=false;

void mousePressed() {
  pressed = true;
}

void mouseDragged() {
}

void mouseReleased() {
  U.set(M(J)); // reset camera up vector
  pressed = false;
}

void keyReleased() {
  if (key==' ') F=P(T);                           //   if(key=='c') M0.moveTo(C.Pof(10));
  U.set(M(J)); // reset camera up vector
  if (key=='q') C.subdivBy(3);
} 


void keyPressed() {

  if (key=='?') {
    showHelpText=!showHelpText;
  }
  //  for(int i=0; i<10; i++) if (key==char(i+48)) vis[i]=!vis[i];
} //------------------------------------------------------------------------ end keyPressed

// Snapping PICTURES of the screen
PImage myFace; // picture of author's face, read from file pic.jpg in data folder
int pictureCounter=0;
Boolean snapping=false; // used to hide some text whil emaking a picture
void snapPicture() {
  saveFrame("PICTURES/P"+nf(pictureCounter++, 3)+".jpg"); 
  snapping=false;
}

