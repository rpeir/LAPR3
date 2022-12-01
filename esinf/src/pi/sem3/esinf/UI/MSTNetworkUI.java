package pi.sem3.esinf.UI;

import pi.sem3.esinf.Controller.MSTNetworkController;

public class MSTNetworkUI implements  Runnable{
    private final MSTNetworkController CTRL;

    public MSTNetworkUI(MSTNetworkController CTRL) {
        this.CTRL = CTRL;
    }

    public MSTNetworkUI() {
        CTRL = new MSTNetworkController();
    }

    @Override
    public void run() {
        System.out.println(CTRL.getMSTNetwork());
    }
}
