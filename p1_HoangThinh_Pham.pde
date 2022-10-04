import controlP5.*;
ControlP5 cp5;


//Declaring variables
int width = 400;
int height = 900;
LCD frame;
int lcdPosX, lcdPosY;
int lcdWidth, lcdHeight;
Floor[] floors;
float floorsX, floorsY;
FloorCancelButton[] cancelBtns;

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
    frame = new LCD();
    //cp5 = new ControlP5(this);
    
    lcdPosX = 20;
    lcdPosY = 20;
    lcdWidth = 360;
    lcdHeight = 640;
    
    
    floorsX = lcdPosX;
    floorsY = lcdPosY + lcdHeight - 20;
    
    floors = new Floor[9];
    cancelBtns = new FloorCancelButton[9];
    queue = new ArrayList<>();
    
    
    closeDoorBtn = new CloseDoorButton();
    openDoorBtn = new OpenDoorButton();
    
    
    
    

    //Initializing floors
    for (int i = 0; i < floors.length; i++) {
        Floor temp = new Floor(i, floorsX, floorsY, lcdWidth);
        temp.setLabel(i + 1);
        temp.deactivate();
        floors[i] = temp;
        floorsY = floorsY - temp.height;
    }
    
    //Initializing cancel buttons
    
    //Floors' descriptions
    //for (int i = 0; i < floors.length; i++) {
    //    floors[i].setDescription("Bank of America\nMcDonalds\nBurger King\nSeven Eleven\nRestrooms");
    //}
    
    floors[0].setDescription("Registration\nRestaurant / Lobby Lounge\nSwimming Pool");
    floors[1].setDescription("ABC Workout Fitness Studio\nABC Executive Club");
    floors[2].setDescription("\nDel Mar Medical Imaging\nDel Mar Chiropratic Sports Group\n  Dr. Brian P. Milligan, D.C.\n  Dr. Atherton L. Sorrenti, D.C.P");
    floors[3].setDescription("M.K. Batra, M.D., F.A.C.S.\n  Coastal Medical Group\n  Skin Authority");
    floors[4].setDescription("Torrey Pines Orthodontics\n  Mary Lynn Merz, D.D.S.\nRadiance International\nOral and Maxillofacial Surgery Center");
    floors[5].setDescription("Coastal Plastic Surgeons\n  Skin and Brows by Tina\n. Elena T Beauty");
    floors[6].setDescription("Club Pilates\nCoastal Medical Group\nBrain PentorMAX\n  A Aesthetic\n. Isabela Skincare");
    floors[7].setDescription("Psycare. Inc.\n  Prychiatry & Counseling\nSpecialty Obstetrics of San Diego\n  David D. Dowling, Mil\n  Janet Horenstein. Ml\n  Yvonne G. Gollin, MD");
    floors[8].setDescription("Brain PentorMAX\n  A Aesthetic\n. Isabela Skincare\nCarmel Valley Endodonties\n  Anthony L. Korbar II. D.M.D\n  Justin N. Naylor, D.D.S.");
    
    //Setting up floors' order
    for (int i = 0; i < floors.length; i++) {
        floors[i].setYPos(floors[i].yPos - floors[i].height);
        cancelBtns[i] = new FloorCancelButton(floors[i].xPos + floors[i].width - 20, floors[i].yPos + floors[i].height / 2);
    }
    
    currentFloor = floors[0];
    //nextFloor = currentFloor;
    //queue.add(currentFloor);
    
    
    moveTimer = new Timer(5000);
    doorTimer = new Timer(4000);
    
    
    
    
}

void draw() {
    frameRate(30);
    background(0); // Background color is black
    
    //Display floors on screen
    for (int i = 0; i < floors.length; i++) {
        floors[i].display();
    }
    
    // Display cancel button
    for (int i = 0; i < floors.length; i++) {
        if (floors[i].isActive()) {
            cancelBtns[i].display();
        }
    }
    
    //println(cancelBtns.length);
    
    

    //Drawing the LCD panel
    rectMode(CORNER);
    fill(14);
    noStroke();
    rect(0, 0, 20, height);
    rect(lcdPosX + lcdWidth, 0, 20, height);
    rect(0, 0, lcdWidth + 40, lcdPosX);
    rect(0, lcdPosY + lcdHeight, lcdWidth + 40, height - lcdHeight - lcdPosY);
    fill(0);
    noStroke();
    rect(lcdPosX, lcdPosY, lcdWidth, 40);
    rect(lcdPosX, lcdHeight - 20, lcdWidth, 40);
    
    
    frame.display();
    
    closeDoorBtn.display();
    openDoorBtn.display();
    
    
    //Check if mouse cursor is in the LCD area
    thread("overLCD");
    
    
    
    
    //Elevator operating actions
    if (frameCount % 30 == 0) {
        startElevator();
    }
    
    
    //frame.display();
    closeDoorBtn.display();
    openDoorBtn.display();
    
    
    
    
}

void mouseClicked() {
  
    // Check if user has selected a floor
    //selectFloor();
    if(overLCD) {
        thread("selectFloor");
    }
    //deSelectFloor();
    if(overLCD) {
        thread("deSelectFloor");
    }
    
    if (mouseButton==RIGHT) {
        thread("closeDoor");
    }
    
    if (closeDoorBtn.pressed()) {
        
        thread("closeDoor");
    }
    if (openDoorBtn.pressed()) {
        
        thread("openDoor");
    }
    

    //redraw();
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
  scrollList();
  //thread("scrollList");
  
  //redraw();
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


void startElevator() {
    
    if (moving == true && queue.size() > 0) {
        println("Current floor: " + (currentFloor.getID() + 1));
        if(currentFloor.getID() < queue.get(0).getID()) {
            goUpOneFloor();
            if (queue.contains(currentFloor)) {
                openDoor();
                currentFloor.deactivate();
                queue.remove(currentFloor);
                
            }
        }
        else if (currentFloor.getID() > queue.get(0).getID()) {
            goDownOneFloor();
            if (queue.contains(currentFloor)) {
                openDoor();
                currentFloor.deactivate();
                queue.remove(currentFloor);
                
            }
        }
        else if (currentFloor.getID() == queue.get(0).getID()) {
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
    currentFloor.enable();
    currentFloor = floors[(currentFloor.getID() + 1)];
    currentFloor.disable();
}

void goDownOneFloor() {
    moveTimer.start();
    while (moveTimer.complete() == false) {
        
    }
    currentFloor.enable();
    currentFloor = floors[(currentFloor.getID() - 1)];
    currentFloor.disable();
}

void closeDoor() {
    //if (closeDoorBtn.isActive()) {
        openDoorBtn.deactivate();
        doorTimer.start();
        println("Door closing...");
        while (doorTimer.complete() == false) {
              if (openDoorBtn.isActive()) {
                  closeDoorBtn.display();
                  return;
              }
        }
        
        if (queue.size() > 0) {
            println("Running...");
            moving = true;
        }
        else {
            println("Closed");
            closeDoorBtn.deactivate();
            
        }
        
        redraw();

    //}
}

void openDoor() {
    //if (openDoorBtn.isActive()) {
        closeDoorBtn.deactivate();
        doorTimer.start();
        println("Door opening...");
        while (doorTimer.complete() == false) {
            if (closeDoorBtn.isActive()) {
                openDoorBtn.display();
                return;
            }
        }
        
        if (moving == true) {
            println("Arrived at floor " + (currentFloor.getID() + 1));
            moving = false;
            openDoorBtn.deactivate();
        }
        else {
            println("Openned");
            openDoorBtn.deactivate();
        }
        
        //for (Floor floor : queue) {
        //    println("Floor in queue: " + (floor.getID() + 1));
        //}
        redraw();

    //}
    
    
}

void selectFloor() {
    if(mouseButton == LEFT) {
        for (int i = 0; i < floors.length; i++) {
            if (floors[i].isActive() == false && floors[i].isEnabled() == true && !queue.contains(floors[i])) {
              floors[i].pressed();
              if (floors[i].isActive()) {
                queue.add(floors[i]);
              }
            }
        }
    }
    
    
}

void deSelectFloor() {
    if(mouseButton == LEFT) {
        for (int i = 0; i < cancelBtns.length; i++) {
            if (cancelBtns[i].isActive() == true) {
              if (cancelBtns[i].pressed()) {
                  floors[i].deactivate();
                  floors[i].enable();
              }
              if (!floors[i].isActive()) {
                queue.remove(floors[i]);
              }
            }
        }
    }
    //println(queue.size());
}

void scrollList() {
    if(locked) {
        xOffset = mouseX - mouseXBefore;
        yOffset = mouseY - mouseYBefore;
        
        if ((floors[0].yPos + yOffset/20 > lcdPosY + lcdHeight - floors[0].height - 36) && (floors[floors.length - 1].yPos + yOffset/20 < lcdPosY + 36)) {
            for (int i = 0; i < floors.length; i++) {
                float tempY = floors[i].yPos; 
                    floors[i].setYPos(tempY + yOffset/20);
                    cancelBtns[i].setYPos(floors[i].yPos + floors[i].height / 2);
            }
        }
        
    }
}
