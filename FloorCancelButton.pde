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
        active = true;
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
            active = false;
            //println("cancel");
            return true;
            
        }
        //println("not cancel");
        return false;
    }
    
    public void setXPos(float x) {
        xPos = x;
    }
    
    public void setYPos(float y) {
        yPos = y;
    }
    
}
