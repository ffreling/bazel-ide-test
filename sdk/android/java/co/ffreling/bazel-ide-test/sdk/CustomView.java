package co.ffreling.bazel-ide-test.sdk;

import android.content.Context;
import android.view;

import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

public final class CustomView extends View {
    private CustomController mCustomController = null;

    public CustomView(Context context) {
        super(context);
        onSetup();
    }

    public CustomView(Context context, AttributeSet attrs) {
        super(context, attrs);
        onSetup();
    }

    private void onSetup() {
        mDensity = getContext().getResources().getDisplayMetrics().density;
        mCustomController = new CustomController(getContext(), getContext().getAssets(), mDensity);
        setEGLConfigChooser(this);
        setEGLContextFactory(this);
        setRenderer(this);
        setRenderMode(GLSurfaceView.RENDERMODE_WHEN_DIRTY);
        requestRender();
    }

    public void onDestroy() {
        if (mCustomController != null) {
            mCustomController.destroy();
            mCustomController = null;
        } else {
            Log.w("CustomView::onDestroy > Tried to access invalid controller instance!");
        }
    }

    public CustomController getController() {
        return mCustomController;
    }

    @Override
    public boolean onTouchEvent(MotionEvent event) {
        final int pointerIndex = (event.getAction()
                & MotionEvent.ACTION_POINTER_INDEX_MASK) >> MotionEvent.ACTION_POINTER_INDEX_SHIFT;
        final int pointerId = event.getPointerId(pointerIndex);

        int actionId = 0;
        long time = event.getEventTime();
        boolean applyToAllTouches = false;

        switch (event.getActionMasked()) {
        case MotionEvent.ACTION_MOVE:
            applyToAllTouches = true;
            actionId = 1;
            break;
        case MotionEvent.ACTION_DOWN:
            actionId = 0;
            break;
        case MotionEvent.ACTION_CANCEL:
            actionId = 3;
            break;
        case MotionEvent.ACTION_UP:
            actionId = 2;
            break;
        case MotionEvent.ACTION_POINTER_DOWN:
            actionId = 0;
            break;
        case MotionEvent.ACTION_POINTER_UP:
            actionId = 2;
            break;
        }

        final int pointerCount = event.getPointerCount();

        if (pointerCount > 0) {
            int event_size = applyToAllTouches ? pointerCount : 1;

            long[] ids = new long[event_size];
            float[] xs = new float[event_size];
            float[] ys = new float[event_size];
            long[] timestamps = new long[event_size];
            int[] actionIds = new int[event_size];

            if (applyToAllTouches) {
                for (int i = 0; i < event.getPointerCount(); ++i) {
                    float x = event.getX(i);
                    float y = mViewport.height() - event.getY(i);

                    ids[i] = event.getPointerId(i);
                    xs[i] = x / mDensity;
                    ys[i] = y / mDensity;
                    timestamps[i] = time;
                    actionIds[i] = actionId;
                }
            } else {
                float x = event.getX(pointerIndex);
                float y = mViewport.height() - event.getY(pointerIndex);

                ids[0] = pointerId;
                xs[0] = x / mDensity;
                ys[0] = y / mDensity;
                timestamps[0] = time;
                actionIds[0] = actionId;
            }
            if (mCustomController != null) {
                mCustomController.updateTouchEvent(ids, xs, ys, timestamps, actionIds);
            } else {
                Log.w("CustomView::onTouchEvent > Tried to access invalid map controller instance!");
            }
        }
        return true;
    }

}
