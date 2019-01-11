package co.ffreling.bazelide.demo;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;

import co.ffreling.bazelide.CustomView;

/**
 * This class is the entry point of the sample application
 */
public final class MainActivity extends AppCompatActivity {
    private CustomView mView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        // Create tne superclass
        super.onCreate(savedInstanceState);

        // Set the main view
        setContentView(R.layout.activity_main);

        // Retrive map view
        mView = (CustomView) findViewById(R.id.custom_view);
    }
}
