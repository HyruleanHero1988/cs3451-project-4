//*****************************************************************************
// TITLE:         Disk collision with PGS (PLANAR GEOMETRY SANDBOX)
// DESCRIPTION:   Demonstrate the benefit of collision prediction over interference detection
// AUTHOR:        Prof Jarek Rossignac
// DATE CREATED:  September 2008
// EDITS:
//*****************************************************************************
boolean showHelpText=true;       // toggled by keys to show/hide help text
boolean printIt=false;           // temporarily set when key '?' is pressed and used to print some debugging values

void setup() { size(600, 600); smooth();   strokeJoin(ROUND); strokeCap(ROUND);  // set up window and drawing modes
  PFont font = loadFont("ArialMT-24.vlw"); textFont(font, 12);      // load font
  setColors();
  declareBalls(); resetBalls();  // initialize
  } 

void draw() { background(121);  strokeWeight(1);                        // sets background
  if (showHelpText) showHelp(); else myActions(); 
  printIt=false;
  };  // end of draw
  
 


  
 
