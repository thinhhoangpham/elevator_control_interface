public class OpenDoorButton extends Button {
    PImage inactiveImg, activeImg;
    float xPos, yPos;
    int width, height;
    
    public OpenDoorButton(int xPos, int yPos) {
        this.xPos = xPos;
        this.yPos = yPos;
        width = 30;
        height = 30;
        inactiveImg = loadImage("openDoor_btn_inactive.png");
        activeImg = loadImage("openDoor_btn_active.png");
    }
    
    public void display() {
        if (active == true) {
            image(activeImg, xPos, yPos, width, height);
        }
        else {
            image(inactiveImg, xPos, yPos, width, height);
        }
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
