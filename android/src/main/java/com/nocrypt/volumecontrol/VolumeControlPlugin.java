package com.nocrypt.volumecontrol;

import com.getcapacitor.JSObject;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.CapacitorPlugin;
import android.content.Context;
import android.media.AudioManager;
import android.os.Build;

import androidx.annotation.RequiresApi;

@CapacitorPlugin(name = "VolumeControl")
public class VolumeControlPlugin extends Plugin {

    private AudioManager audioManager;

    @Override
    public void load() {
        audioManager = (AudioManager) getContext().getSystemService(Context.AUDIO_SERVICE);
    }

    private int getAudioStreamType(String streamType) {
        return switch (streamType) {
            case "STREAM_VOICE_CALL" -> AudioManager.STREAM_VOICE_CALL;
            case "STREAM_SYSTEM" -> AudioManager.STREAM_SYSTEM;
            case "STREAM_RING" -> AudioManager.STREAM_RING;
            case "STREAM_ALARM" -> AudioManager.STREAM_ALARM;
            case "STREAM_NOTIFICATION" -> AudioManager.STREAM_NOTIFICATION;
            case "STREAM_DTMF" -> AudioManager.STREAM_DTMF;
            default -> AudioManager.STREAM_MUSIC;
        };
    }

    @PluginMethod
    public void getVolume(PluginCall call) {
        String streamTypeString = call.getString("streamType", "STREAM_MUSIC");
        int streamType = getAudioStreamType(streamTypeString);

        int currentVolume = audioManager.getStreamVolume(streamType);
        int maxVolume = audioManager.getStreamMaxVolume(streamType);
        int normalizedVolume = (int) (((float) currentVolume / maxVolume) * 100);

        JSObject ret = new JSObject();
        ret.put("volume", normalizedVolume);
        call.resolve(ret);
    }

    @PluginMethod
    public void setVolume(PluginCall call) {
        int volume = call.getInt("volume", -1);
        boolean showUI = call.getBoolean("showUI", false);
        String streamTypeString = call.getString("streamType", "STREAM_MUSIC");
        int streamType = getAudioStreamType(streamTypeString);

        if (volume < 0 || volume > 100) {
            call.reject("Volume must be between 0 and 100");
            return;
        }

        int maxVolume = audioManager.getStreamMaxVolume(streamType);
        int setVolume = (int) (((float) volume / 100) * maxVolume);

        int flags = showUI ? AudioManager.FLAG_SHOW_UI : 0;
        audioManager.setStreamVolume(streamType, setVolume, flags);

        call.resolve();
    }
}