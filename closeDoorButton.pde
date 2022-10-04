public class CloseDoorButton extends Button {
    PImage inactiveImg, activeImg;
    PImage img;
    float xPos, yPos;
    int width, height;
    
    public CloseDoorButton(int xPos, int yPos) {
        this.xPos = xPos;
        this.yPos = yPos;
        width = 33;
        height = 33;
        inactiveImg = loadImage("closeDoor_btn_inactive.png");
        activeImg = loadImage("closeDoor_btn_active.png");
        img = loadImage("closeDoor_btn_inactive.png");
    }
    
    public CloseDoorButton() {
        xPos = 90;
        yPos = 700;
        width = 30;
        height = 30;
        inactiveImg = loadImage("closeDoor_btn_inactive.png");
        activeImg = loadImage("closeDoor_btn_active.png");
        img = loadImage("closeDoor_btn_inactive.png");
    }
    
    public void display() {
        //if (active == true) {
        //    image(activeImg, xPos, yPos, width, height);
        //}
        //else {
        //    image(inactiveImg, xPos, yPos, width, height);
        //}
        imageMode(CENTER);
        image(img, xPos, yPos, width, height);
    }
    
    public void displayActive() {
        image(activeImg, xPos, yPos, width, height);
    }
    
    public void displayInactive() {
        image(inactiveImg, xPos, yPos, width, height);
    }
    
    public boolean mouseOver() {
        if (mouseX >= xPos && mouseX <= xPos + width && 
            mouseY >= yPos && mouseY <= yPos + height) {
            return true;
        } else {
            return false;
        }
    }
    
    public boolean pressed() {
        if (mouseOver() == true) {
            active = true;
            img = loadImage("closeDoor_btn_active.png");
            return true;
        }
        return false;
    }
}
