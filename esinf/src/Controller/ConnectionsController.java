package Controller;

import graph.Algorithms;

public class ConnectionsController {
     private final App app;
    public ConnectionsController() {
        app = App.getInstance();
    }


    public int minConnevtions(){
       return Algorithms.minConnections(app.getGraph(), Integer::compare, Integer::sum, 0);

    }


}
