import controlP5.*;

public class LCD {
    int width;
    int height;
    ControlP5 cp5;
    color c;
    PImage image;
    
    
    
    public LCD() {
        width = 400;
        height = 900;
        this.cp5 = cp5;
        c = color(0, 0, 0);
        imageMode(CENTER);
        image = loadImage("frame.png");
        
        
    }
    
    public void display() {
        //noStroke();
        noStroke();
        fill(c);
        //rect(0, 0, width, height);
        image(image, 200, 450);
    }
}
