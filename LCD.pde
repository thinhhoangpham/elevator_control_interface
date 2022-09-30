import controlP5.*;

public class LCD {
    int width;
    int height;
    ControlP5 cp5;
    color c;
    
    
    
    public LCD(ControlP5 cp5) {
        width = 360;
        height = 640;
        this.cp5 = cp5;
        c = color(0, 0, 0);
        
        
    }
    
    public void display() {
        //noStroke();
        noStroke();
        fill(c);
        rect(0, 0, width, height);
    }
}
