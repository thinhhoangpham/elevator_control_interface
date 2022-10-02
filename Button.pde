import controlP5.*;

public class Button {
  
    String label;
    String description;
    boolean active = false;
    boolean isEnabled;
    
    public Button() {
        label = "label";
        description = "description";
        isEnabled = true;
        
    }
    
    public void setLabel(String label) {
        this.label = label;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public boolean pressed() {
        active = !active;
        return true;
    }
    
    public void deactivate() {
        active = false;
    }
    
    public String getLabel() {
        return label;
    }
    
    public String getDesciption() {
        return description;
    }
    
    public boolean isActive() {
        return active;
    }
    
    public boolean isEnabled() {
        return isEnabled;
    }
    
    public void enable() {
        isEnabled = true;
    }
    
    public void disable() {
        isEnabled = false;
    }
}
