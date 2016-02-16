
Process child;
File dir = new File("/Users/boyoungkim/Documents/CMU/SPRING16/IACD/Drawing_program/handWritingX/sketch/");
String envp[] = {};
String cmd = "/usr/local/bin/tesseract letter.jpg out bazaar";

void setup() {
  background(255);
  size(1000,750);
  textAlign(CENTER);
  defaultText();
  
}

void draw() {
  float areaX = width/11; 
  float areaY = height/6; 
  float w = 10;
  
  noFill();
  stroke(220);
  strokeWeight(4);
  rectMode(CORNERS);
  rect(areaX - w, areaY - w, width - (areaX-w), height - (areaY-w));
  
  if (mousePressed &&
      mouseX < width - areaX && mouseX > areaX &&
      mouseY < height - areaY && mouseY > areaY) {
    stroke(0);
    strokeWeight(3);
    smooth();
    line(mouseX, mouseY, pmouseX, pmouseY);
  } 
}

void keyPressed() {
  switch (key) {
    case ' '  : //clear canvas
                background(255); 
                break;
    case 'p'  : //example guideline
                fill(255, 0, 0, 50);
                strokeWeight(5);
                textSize(40);
                textAlign(CENTER);
                text("The quick brown fox", width/2, height/2);  
                break;
    case ENTER: //run tesseract
                try {
                  save("sketch/letter.jpg"); 
                  child = Runtime.getRuntime().exec(cmd, envp, dir);
                  child.waitFor(); 
                } 
                catch (Exception e) {
                  println("ERROR!" + e); 
                }
                readWriting();
                println("done!");
                break;
    }
}

void readWriting() {
    //read txt.file
    String[] text = loadStrings("sketch/out.txt");
    int nText = text.length;
    
    if (nText != 0) {
      for (int i=0; i<nText; i++) {
         fill(0);
         textSize(20);
         float y = 50 + i*20;
         text(text[i], width/2, y);        
      }  save("sketch/save.jpg");
    } else {
         fill(0);
         text("Please write more like a computer", width/2, 50); 
    }    
}


void defaultText() { 
   fill(200);
   textSize(18);
   int spacing = height/10;
   text("Press enter to read your handwriting", width/2, height - spacing);
   text("Press space to clear canvas", width/2, height - (spacing*0.75));
   text("Press p to pracetice writing like a computer", width/2, height - (spacing*0.5));
}


  
 