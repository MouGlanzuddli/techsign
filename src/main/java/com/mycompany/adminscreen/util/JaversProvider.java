package com.mycompany.adminscreen.util;

import org.javers.core.Javers;
import org.javers.core.JaversBuilder;

public class JaversProvider {
    private static final Javers javers = JaversBuilder.javers().build();
    public static Javers get() { return javers; }
} 