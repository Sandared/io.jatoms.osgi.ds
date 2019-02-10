package io.jatoms.osgi.ds;

import org.osgi.service.component.annotations.Activate;
import org.osgi.service.component.annotations.Component;

@Component
public class ComponentImpl {

    @Activate
    void activate(){
        System.out.println("Greetings from OSGi and Declarative Services!");
    }

}
