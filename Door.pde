public class Door {
    float lDoorX, lDoorY;
    int lDoorWidth, lDoorHeight;
    float rDoorX, rDoorY;
    int rDoorWidth, rDoorHeight;
    
    public Door(int x, int y, int width, int height) {
        lDoorX = x;
        lDoorY = Y;
        lDoorWidth = width / 2;
        lDoorHeight = height;
        rDoorX = lDoorX + lDoorWidth;
        rDoorY = y;
        rDoorWidth = width / 2;
        rDoorHeight = height;
    }
    
    public void display() {
        stroke(35);
        strokeWeight(10);
        fill(14);
        rect(lDoorX, lDoorY, lDoorWidth, lDoorHeight);
        rect(rDoorX, rDoorY, rDoorWidth, rDoorHeight);
    }
    
    public void open() {
        int increment = lDoorWidth;
        while (increment > 0) {
            lDoorX = lDoorX - 1;
            rDoorX = rDoorX + 1;
            increment--;
        }
    }
}
