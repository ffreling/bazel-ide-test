package co.ffreling.bazelide.demo;

import android.app.Application;

public class MainApplication extends Application {
    static {
        System.loadLibrary("bazelide");
    }
}
