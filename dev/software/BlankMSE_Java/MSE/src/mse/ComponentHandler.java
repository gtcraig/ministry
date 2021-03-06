//package com.asidua.mse;

import java.awt.Component;
import java.awt.Dimension;
import java.awt.event.ComponentAdapter;
import java.awt.event.ComponentEvent;
import java.awt.Toolkit;

public class ComponentHandler extends ComponentAdapter {
    int minWidth;
    int minHeight;

    public ComponentHandler(Component c, int p_minWidth,
            int p_minHeight) {
        super();
        minWidth = p_minWidth;
        minHeight = p_minHeight;
        c.setSize(minWidth, minHeight);
        Dimension d = Toolkit.getDefaultToolkit().getScreenSize();
        c.setLocation((d.width - c.getSize().width) / 2,
            (d.height - c.getSize().height) / 2);
    }

    public void componentResized(ComponentEvent e) {
        boolean changed = false;
        Component c = e.getComponent();
        int intNewWidth = c.getWidth();
        int intNewHeight = c.getHeight();
        if (intNewWidth < minWidth) {
            intNewWidth = minWidth;
            changed = true;
        }
        if (intNewHeight < minHeight) {
            intNewHeight = minHeight;
            changed = true;
        }
        if (changed) {
            c.setSize(intNewWidth, intNewHeight);
        }
    }//componentResized
}//ComponentHandler