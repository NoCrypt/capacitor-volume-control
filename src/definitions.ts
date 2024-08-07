export interface VolumeControlPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
