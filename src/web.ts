import { WebPlugin } from '@capacitor/core';

import type { VolumeControlPlugin } from './definitions';

export class VolumeControlWeb extends WebPlugin implements VolumeControlPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
