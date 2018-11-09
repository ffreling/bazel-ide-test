#include "core/foo/foo.hpp"
#include "core/bar/bar.hpp"

#include <cassert>
#include <jni.h>

extern "C" {
static JavaVM *g_java = nullptr;
void register_native_events(JNIEnv *jni, jobject object, tharp::map::MapController *map_controller) {
    jni->GetJavaVM(&g_java);
    jclass activity_class = jni->GetObjectClass(object);
    jmethodID method_id = jni->GetMethodID(activity_class, "cameraDidMove", "(DDDDDD)V");
    jobject object_ref = jni->NewGlobalRef(object);
    map_controller->setCameraMoveListener([=](const tharp::map::MapCamera &camera) {
        JNIEnv *env;
        int getEnvStat = g_java->GetEnv((void **)(&env), JNI_VERSION_1_6);
        if (getEnvStat == JNI_EDETACHED) {
            if (g_java->AttachCurrentThread(&env, NULL) != 0) {
                env->CallVoidMethod(object_ref, method_id, camera.center.x, camera.center.y, camera.distance, camera.tilt, camera.roll, camera.heading);
                g_java->DetachCurrentThread();
            }
        } else if (getEnvStat == JNI_OK) {
            env->CallVoidMethod(object_ref, method_id, camera.center.x, camera.center.y, camera.distance, camera.tilt, camera.roll, camera.heading);
        }
    });
}
}

std::string jstring2string(JNIEnv *jni, jstring jStr) {
    const char *cStr = jni->GetStringUTFChars(jStr, NULL);
    std::string str = std::string(cStr);
    jni->ReleaseStringUTFChars(jStr, cStr);
    return str;
}

extern "C" {
JNIEXPORT jlong JNICALL Java_co_znly_tharp_sdk_MapController_nativeCreate(JNIEnv *jni, jobject object, jstring j_file_root, jobject asset_manager, jfloat scale) {
    DLOG(debug, "Creating native map controller...");

    std::string file_root = jstring2string(jni, j_file_root);
    tharp::io::impl::set_android_file_root(file_root);
    tharp::io::platform::detail::set_android_asset_manager(AAssetManager_fromJava(jni, asset_manager));

    auto context = std::make_unique<tharp::map::MapContext>();
    auto map_controller = new tharp::map::MapController(std::move(context), scale);
    register_native_events(jni, object, map_controller);
    DLOG(debug, "Created native controller...");
    return reinterpret_cast<jlong>(map_controller);
}
}

extern "C" {
JNIEXPORT void JNICALL Java_co_znly_tharp_sdk_MapController_nativeDestroy(JNIEnv *jni, jobject object, jlong native_map_controller) {
    DLOG(debug, "Destroying native map controller...");
    if (auto map_controller = reinterpret_cast<tharp::map::MapController *>(native_map_controller)) {
        delete map_controller;
    }
    DLOG(debug, "Destroyed native map controller...");
}
}

extern "C" {
JNIEXPORT void JNICALL Java_co_znly_tharp_sdk_MapController_nativeRenderContextCreated(JNIEnv *jni, jobject object, jlong native_map_controller) {
    DLOG(debug, "Creating native render context...");
    if (auto map_controller = reinterpret_cast<tharp::map::MapController *>(native_map_controller)) {
        map_controller->resume();
    }
    DLOG(debug, "Created native render context...");
}
}

extern "C" {
JNIEXPORT void JNICALL Java_co_znly_tharp_sdk_MapController_nativeRenderContextDestroyed(JNIEnv *jni, jobject object, jlong native_map_controller) {
    DLOG(debug, "Destroying native render context...");
    if (auto map_controller = reinterpret_cast<tharp::map::MapController *>(native_map_controller)) {
        map_controller->pause();
    }
    DLOG(debug, "Destroyed native render context...");
}
}

extern "C" {
JNIEXPORT void JNICALL Java_co_znly_tharp_sdk_MapController_nativeDraw(JNIEnv *jni, jobject object, jlong native_map_controller, jint x, jint y, jint width, jint height) {
    if (auto map_controller = reinterpret_cast<tharp::map::MapController *>(native_map_controller)) {
        map_controller->draw(x, y, width, height);
    }
}
}

extern "C" {
JNIEXPORT void JNICALL Java_co_znly_tharp_sdk_MapController_nativeViewportSizeChanged(JNIEnv *jni, jobject object, jlong native_map_controller, jfloat width, jfloat height) {
    if (auto *map_controller = reinterpret_cast<tharp::map::MapController *>(native_map_controller)) {
        map_controller->viewport_size_changed(glm::vec2(width, height));
    }
}
}

extern "C" {
JNIEXPORT void JNICALL Java_co_znly_tharp_sdk_MapController_nativeUpdateTouchEvent(JNIEnv *jni_env,
                                                                                   jobject object,
                                                                                   jlong native_map_controller,
                                                                                   jlongArray touch_ids,
                                                                                   jfloatArray xs,
                                                                                   jfloatArray ys,
                                                                                   jlongArray timestamps,
                                                                                   jintArray touch_types) {
    JNIEnv &env = *(JNIEnv *)jni_env;

    jsize s_values = env.GetArrayLength(touch_ids);

    jlong *p_touch_ids = env.GetLongArrayElements(touch_ids, 0);
    jfloat *p_xs = env.GetFloatArrayElements(xs, 0);
    jfloat *p_ys = env.GetFloatArrayElements(ys, 0);
    jlong *p_timestamps = env.GetLongArrayElements(timestamps, 0);
    jint *p_touch_types = env.GetIntArrayElements(touch_types, 0);

    if (auto *map_controller = reinterpret_cast<tharp::map::MapController *>(native_map_controller)) {
        std::vector<uint32_t> _ids;
        std::vector<glm::vec2> _positions;
        std::vector<double> _timestamps;
        std::vector<tharp::map::TouchEventType> _touch_types;

        for (int i = 0; i < s_values; ++i) {
            _ids.push_back(p_touch_ids[i]);
            _positions.push_back(glm::vec2(p_xs[i], p_ys[i]));
            _timestamps.push_back(p_timestamps[i] / 1000.0);
            _touch_types.push_back(static_cast<tharp::map::TouchEventType>(p_touch_types[i]));
        }
        map_controller->update_touch_event(_ids, _positions, _timestamps, _touch_types);
    }

    env.ReleaseLongArrayElements(touch_ids, p_touch_ids, 0);
    env.ReleaseFloatArrayElements(xs, p_xs, 0);
    env.ReleaseFloatArrayElements(ys, p_ys, 0);
    env.ReleaseLongArrayElements(timestamps, p_timestamps, 0);
    env.ReleaseIntArrayElements(touch_types, p_touch_types, 0);
}
}
extern "C" {
JNIEXPORT void JNICALL Java_co_znly_tharp_sdk_MapController_nativeSetCamera(JNIEnv *jni,
                                                                            jobject object,
                                                                            jlong native_map_controller,
                                                                            jdouble latitude,
                                                                            jdouble longitude,
                                                                            jdouble distance,
                                                                            jdouble tilt,
                                                                            jdouble roll,
                                                                            jdouble heading) {
    if (auto *map_controller = reinterpret_cast<tharp::map::MapController *>(native_map_controller)) {
        tharp::map::MapCamera cam;
        cam.center.xy = tharp::map::Coordinates2D(latitude, longitude);
        cam.tilt = tilt;
        cam.roll = roll;
        cam.distance = distance;
        cam.heading = heading;
        map_controller->camera(cam);
    }
}
}
