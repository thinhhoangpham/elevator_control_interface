import controlP5.*;
ControlP5 cp5;


//Declaring variables
int width = 400;
int height = 900;
int lcdPosX, lcdPosY;
int lcdWidth, lcdHeight;
Floor[] floors;
float floorsX, floorsY;

boolean locked = false;
boolean overLCD = true;
float xOffset = 0.0; 
float yOffset = 0.0;
float mouseXBefore, mouseYBefore;

boolean moving = false;
boolean goUp;

ArrayList<Floor> queue;
Floor currentFloor, nextFloor;

Timer moveTimer, doorTimer;

CloseDoorButton closeDoorBtn;
OpenDoorButton openDoorBtn;



void setup() {
    
    // Initializing
    frameRate(30);
    size(400, 900);
    pixelDensity(2);
    background(0);
    cp5 = new ControlP5(this);
    
    lcdPosX = 20;
    lcdPosY = 20;
    lcdWidth = 360;
    lcdHeight = 640;
    
    
    floorsX = lcdPosX;
    floorsY = lcdPosY + lcdHeight - 20;
    
    floors = new Floor[9];
    queue = new ArrayList<>();
    
    
    closeDoorBtn = new CloseDoorButton(lcdPosX + lcdWidth - 80, lcdPosY + lcdHeight - 15);
    openDoorBtn = new OpenDoorButton(lcdPosX + lcdWidth - 40, lcdPosY + lcdHeight - 15);
    
    
    

    //Initializing floors
    for (int i = 0; i < floors.length; i++) {
        Floor temp = new Floor(i, floorsX, floorsY, lcdWidth);
        temp.setLabel(i + 1);
        temp.deactivate();
        floors[i] = temp;
        floorsY = floorsY - temp.height;
    }
    
    //Floors' descriptions
    for (int i = 0; i < floors.length; i++) {
        floors[i].setDescription("Bank of America\nMcDonalds\nBurger King\nSeven Eleven\nRestrooms");
    }
    
    //Setting up floors' order
    for (int i = 0; i < floors.length; i++) {
        floors[i].setYPos(floors[i].yPos - floors[i].height);
    }
    
    currentFloor = floors[0];
    nextFloor = currentFloor;
    queue.add(floors[0]);
    
    
    moveTimer = new Timer(4000);
    doorTimer = new Timer(4000);
    
    
    
    
}

void draw() {
  
    background(0); // Background color is black
    
    //Display floors on screen
    for (int i = 0; i < floors.length; i++) {
        floors[i].display();
    }
    
    
    
    

    //Drawing the LCD panel
    fill(14);
    noStroke();
    rect(0, 0, 20, height);
    rect(lcdPosX + lcdWidth, 0, 20, height);
    rect(0, 0, lcdWidth + 40, lcdPosX);
    rect(0, lcdPosY + lcdHeight, lcdWidth + 40, height - lcdHeight - lcdPosY);
    fill(0);
    noStroke();
    rect(lcdPosX, lcdPosY, lcdWidth, 40);
    rect(lcdPosX, lcdHeight, lcdWidth, 40);
    
    //Check if mouse cursor is in the LCD area
    overLCD();
    
    //Elevator operating actions
    startElevator();
    
    
    
    
    
    closeDoorBtn.display();
    openDoorBtn.display();
}

void mouseClicked() {
  
    // Check if user has selected a floor
    if(mouseButton==LEFT) {
        for (int i = 0; i < floors.length; i++) {
            if (floors[i].isActive() == false && floors[i].isEnabled() == true && !queue.contains(floors[i])) {
              floors[i].pressed();
              if (floors[i].isActive()) {
                queue.add(floors[i]);
              }
            }
        }
    }
    
    if (mouseButton==RIGHT) {
        closeDoor();
    }
    
    closeDoorBtn.pressed();
    
    openDoorBtn.pressed();
    
    
    redraw();
}

void mousePressed() {
  
  //Check if the mouse is inside LCD area when it is pressed
  if(overLCD) { 
    locked = true; 
  } else {
    locked = false;
  }
  mouseXBefore = mouseX;
  mouseYBefore = mouseY;
}

void mouseDragged() {
  
  //Implementing mouse drag to simulate scrolling
  if(locked) {
    xOffset = mouseX - mouseXBefore;
    yOffset = mouseY - mouseYBefore;
    
    if ((floors[0].yPos + yOffset/20 > lcdPosY + lcdHeight - floors[0].height - 36) && (floors[floors.length - 1].yPos + yOffset/20 < lcdPosY + 36)) {
        for (int i = 0; i < floors.length; i++) {
            float tempY = floors[i].yPos; 
                floors[i].setYPos(tempY + yOffset/20);
        }
    }
    
  }
  
  redraw();
}

void mouseReleased() {
  locked = false;
  
}

void overLCD() {
    if (mouseX >= lcdPosX && mouseX <= lcdPosX + lcdWidth && 
            mouseY >= lcdPosY && mouseY <= lcdPosX + height) {
            overLCD = true;
        } else {
            overLCD = false;
        }
}

void gotoFloor(Floor floor) {
    
    int distance = floor.getID() - currentFloor.getID();
    while (distance != 0) {
        delay(5000);
        if (goUp) {
            distance--;
        }
        else {
            distance++;
        }
        
    }
    
}

void startElevator() {
    if (moving == true && queue.size() > 1) {
        println("Current floor: " + (currentFloor.getID() + 1));
        if(currentFloor.getID() < queue.get(1).getID()) {
            goUpOneFloor();
            if (queue.contains(currentFloor)) {
                openDoor();
                currentFloor.deactivate();
                queue.remove(currentFloor);
            }
        }
        else if (currentFloor.getID() > queue.get(1).getID()) {
            goDownOneFloor();
            if (queue.contains(currentFloor)) {
                openDoor();
                currentFloor.deactivate();
                queue.remove(currentFloor);
            }
        }
        else if (currentFloor.getID() == queue.get(1).getID()) {
            openDoor();
            currentFloor.deactivate();
            queue.remove(currentFloor);
        }
    }
}

void goUpOneFloor() {
    moveTimer.start();
    while (moveTimer.complete() == false) {
        
    }
    currentFloor = floors[(currentFloor.getID() + 1)];
}

void goDownOneFloor() {
    moveTimer.start();
    while (moveTimer.complete() == false) {
        
    }
    currentFloor = floors[(currentFloor.getID() - 1)];
}

void closeDoor() {
    //if (closeDoorBtn.isActive()) {
        closeDoorBtn.pressed();
        doorTimer.start();
        println("Door closing...");
        while (doorTimer.complete() == false) {
              if (openDoorBtn.isActive()) {
                  closeDoorBtn.pressed();
                  return;
              }
        }
        
        if (queue.size() > 1) {
            println("Running...");
            moving = true;
        }
        else {
            println("Closed");
            closeDoorBtn.deactivate();
            
        }

    //}
}

void openDoor() {
    //if (openDoorBtn.isActive()) {
        doorTimer.start();
        println("Door opening...");
        while (doorTimer.complete() == false) {
            
        }
        
        println("Arrived at floor " + (currentFloor.getID() + 1));
        moving = false;

    //}
    
    
}
