public class FloorCancelButton extends Button {
    PImage icon;
    float xPos, yPos;
    int width, height;
    
    public FloorCancelButton(float xPos, float yPos) {
        this.xPos = xPos;
        this.yPos = yPos;
        width = 16;
        height = 16;
        icon = loadImage("floorCancel_btn.png");
    }
    
    public void display() {
        imageMode(CENTER);
        image(icon, xPos, yPos, width, height); //<>//
    }
}
