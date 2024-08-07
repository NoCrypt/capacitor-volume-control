export interface VolumeControlPlugin {
  getVolume(options?: { streamType?: StreamType }): Promise<{ volume: number }>;
  setVolume(options: { volume: number; showUI?: boolean; streamType?: StreamType }): Promise<void>;
}

export type StreamType = 
  | 'STREAM_VOICE_CALL'
  | 'STREAM_SYSTEM'
  | 'STREAM_RING'
  | 'STREAM_MUSIC'
  | 'STREAM_ALARM'
  | 'STREAM_NOTIFICATION'
  | 'STREAM_DTMF';

declare global {
  interface PluginRegistry {
    VolumeControl: VolumeControlPlugin;
  }
}