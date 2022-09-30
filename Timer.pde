public class Timer {
    int startTime;
    int interval;
    
    public Timer(int interval) {
      this.interval = interval;
        
    }
    
    public void start() {
        startTime = millis();
    }
    
    public boolean complete() {
        int elapsedTime = millis() - startTime;
        if (elapsedTime > interval) {
            return true;
        }
        else {
            return false;
        }
    }
}
