/*
Portrait painter

Mimics a brush's stroke to paint a portrait.

Controls:
  - Mouse click to switch to the next image.

Author:
  Jason Labbe

Site:
  jasonlabbe3d.com
  https://www.openprocessing.org/sketch/392202
*/


String[] imgNames = {
                      "https://c1.staticflickr.com/4/3735/12658290004_2005fa9845_b.jpg",
                      "http://cdn2-www.craveonline.com/assets/uploads/2015/12/Will-Ferrell-Elf.jpg"
                   };
PImage img;
int imgIndex = 0;


void setup() {
  size(950, 700);
  nextImage();
}


void draw() {
  translate(width/2, height/2);
  
  int index = 0;
  
  for (int y = 0; y < img.height; y+=1) {
    for (int x = 0; x < img.width; x+=1) {
      int odds = (int)random(20000);
      
      if (odds < 1) {
        color pixelColor = img.pixels[index];
        pixelColor = color(red(pixelColor), green(pixelColor), blue(pixelColor), 100);
        
        pushMatrix();
        translate(x-img.width/2, y-img.height/2);
        rotate(radians(random(-90, 90)));
        

        if (frameCount < 20) {
          // Big rough strokes
          paintStroke(random(150, 250), pixelColor, (int)random(20, 40));
        }
        
        // TODO: Paint layers from rough strokes to finer details.
        // Check the frameCount variable. If it is...
        // less than 50, call the paintStroke function (same as above)
        // but replace the numbers with 75, 125, 8, and 12 (in that order)
        //
        // If frameCount is less than 300, replace the # with 30, 60, 1, 4
        // if it's less than 350, use 5, 20, 5, 15
        // if it's less than 600, use 1, 10, 1, 7
        
        popMatrix();
      }
      
      index += 1;
    }
  }
  

  
  // TODO: check if the mousePressed variable is true. If it is,
  // then call the nextImage() function.
  
  // TODO: check if the frameCount variable is greater than 600. If it is,
  // then call the noLoop() function.
  
}

void nextImage() {
  background(255);
  loop();
  frameCount = 0;
  
  img = loadImage(imgNames[imgIndex]);
  img.loadPixels();
  
  imgIndex += 1;
  if (imgIndex >= imgNames.length) {
    imgIndex = 0;
  }
}


void paintStroke(float strokeLength, color strokeColor, int strokeThickness) {
  float stepLength = strokeLength/4.0;
  
  // Determines if the stroke is curved. A straight line is 0.
  float tangent1 = 0;
  float tangent2 = 0;
  
  float odds = random(1.0);
  
  if (odds < 0.7) {
    tangent1 = random(-strokeLength, strokeLength);
    tangent2 = random(-strokeLength, strokeLength);
  } 
  
  // Draw a big stroke
  noFill();
  stroke(strokeColor);
  strokeWeight(strokeThickness);
  curve(tangent1, -stepLength*2, 0, -stepLength, 0, stepLength, tangent2, stepLength*2);
  
  int z = 1;
  
  // Draw stroke's details
  for (int num = strokeThickness; num > 0; num --) {
    float offset = random(-50, 25);
    color newColor = color(red(strokeColor)+offset, green(strokeColor)+offset, blue(strokeColor)+offset, random(100, 255));
    
    stroke(newColor);
    strokeWeight((int)random(0, 3));
    curve(tangent1, -stepLength*2, z-strokeThickness/2, -stepLength*random(0.9, 1.1), z-strokeThickness/2, stepLength*random(0.9, 1.1), tangent2, stepLength*2);
    
    z += 1;
  }
}

