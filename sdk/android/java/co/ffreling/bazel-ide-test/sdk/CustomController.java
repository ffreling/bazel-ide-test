package co.znly.tharp.sdk;

import android.content.Context;
import android.content.res.AssetManager;

public final class MapController {
    static {
        try {
            System.loadLibrary("tharp");
        } catch (UnsatisfiedLinkError e) {
           // It does not exist in a bazel build.
        }
    }

    public interface Listener {
        public void cameraDidMove(MapCamera newCamera);
    }

    private long mNativeMapController = 0x0;
    private final MapCamera mLastCamera = new MapCamera();
    private Listener listener = null;

    public MapController(Context context, AssetManager assetManager, float density) {
        final String fileRoot = context.getFilesDir().toString();
        mNativeMapController = nativeCreate(fileRoot, assetManager, density);
    }

    public void destroy() {
        Preconditions.checkState(mNativeMapController != 0x0);
        nativeDestroy(mNativeMapController);
        mNativeMapController = 0x0;
    }

    public void renderContextCreated() {
        nativeRenderContextCreated(mNativeMapController);
    }

    public void renderContextDestroyed() {
        nativeRenderContextDestroyed(mNativeMapController);
    }

    public void draw(int x, int y, int width, int height) {
        Preconditions.checkState(mNativeMapController != 0x0);
        nativeDraw(mNativeMapController, x, y, width, height);
    }

    public synchronized final void viewportSizeChanged(float width, float height) {
        nativeViewportSizeChanged(mNativeMapController, width, height);
    }

    public synchronized final void setCamera(MapCamera camera) {
        nativeSetCamera(mNativeMapController, camera.latitude, camera.longitude, camera.distance, camera.tilt,
                camera.roll, camera.heading);
    }

    public synchronized final void cameraDidMove(double latitude, double longitude, double distance, double tilt,
            double roll, double heading) {
        mLastCamera.latitude = latitude;
        mLastCamera.longitude = longitude;
        mLastCamera.distance = distance;
        mLastCamera.tilt = tilt;
        mLastCamera.roll = roll;
        mLastCamera.heading = heading;
        if (listener != null) {
            listener.cameraDidMove(mLastCamera);
        }
    }

    public final MapCamera getLastCamera() {
        return mLastCamera;
    }

    public synchronized final void updateTouchEvent(long[] touchIds, float[] xs, float[] ys, long[] timestamps, int[] touchTypes) {
        nativeUpdateTouchEvent(mNativeMapController, touchIds, xs, ys, timestamps, touchTypes);
    }

    public void setListener(Listener listener) {
        this.listener = listener;
    }

    private native long nativeCreate(String fileRoot, AssetManager assetManager, float density);

    private native void nativeDestroy(long nativeMapController);

    private native void nativeRenderContextCreated(long nativeMapController);

    private native void nativeRenderContextDestroyed(long nativeMapController);

    private native void nativeDraw(long nativeMapController, int x, int y, int width, int height);

    protected synchronized native void nativeViewportSizeChanged(long nativeMapController, float width, float height);

    protected synchronized native void nativeUpdateTouchEvent(long nativeMapController, long[] touchIds, float[] xs, float[] ys, long[] timestamps, int[] touchTypes);

    protected synchronized native void nativeSetCamera(long nativeMapController, double latitude, double longitude,
            double distance, double tilt, double roll, double heading);

};
