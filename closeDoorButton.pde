public class CloseDoorButton extends Button {
    PImage inactiveImg, activeImg;
    float xPos, yPos;
    int width, height;
    
    public CloseDoorButton(float xPos, float yPos) {
        this.xPos = xPos;
        this.yPos = yPos;
        width = 50;
        height = 50;
        inactiveImg = loadImage("closeDoor_btn_inactive.png");
        activeImg = loadImage("closeDoor_btn_active.png");
    }
    
    public void display() {
        if (active == true) {
            image(activeImg, xPos, yPos);
        }
        else {
            image(inactiveImg, xPos, yPos);
        }
    }
}
