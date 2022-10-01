import controlP5.*;


public class Floor extends Button {
    int floorID;
    float xPos, yPos;
    int width, height;
    PFont labelFont = createFont("HelveticaNeue-Light.otf", 64);
    PFont desFont = createFont("HelveticaNeue-Light.otf", 13);
    //FloorCancelButton cancelBtn;
    
    
    public Floor(int floorID, float xPos, float yPos, int width) {
        this.floorID = floorID;
        this.xPos = xPos;
        this.yPos = yPos;
        this.width = width;
        height = 120;
        //cancelBtn = new FloorCancelButton((xPos + width) - 20, yPos/2);
    }
    
    public void setLabel(String label) {
        this.label = label;
    }
    
    public void setLabel(int label) {
        this.label = "" + label;
    }
    
    public void setXPos(float x) {
        xPos = x;
    }
    
    public void setYPos(float y) {
        yPos = y;
    }
    
    public void setHeight(int height) {
      this.height = height;
    
    }
    
    public int getID() {
        return floorID;
    }
    
    public void display() {
        noStroke();
        noFill();
        rect(xPos,yPos, width, height);
        if (active == true) {
            fill(250);
            cancelBtn.display();
        }
        else if (active == false) {
            fill(100);
        }
        
        textFont(labelFont);
        text(label, xPos + 30, yPos + 60);
        rect(xPos + 90, yPos, 4, height);
        textFont(desFont);
        text(description, xPos + 110, yPos+ 20);
        
    }
    
    public boolean mouseOver() {
        if (mouseX >= xPos && mouseX <= xPos + width && 
            mouseY >= yPos && mouseY <= yPos + height) {
            return true;
        } else {
            return false;
        }
    }
    
    public void pressed() {
        if (mouseOver() == true) {
            active = true;
        }
    }
    
}
