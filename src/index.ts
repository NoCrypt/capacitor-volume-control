import { registerPlugin } from '@capacitor/core';

import type { VolumeControlPlugin } from './definitions';

const VolumeControl = registerPlugin<VolumeControlPlugin>('VolumeControl', {});

export * from './definitions';
export { VolumeControl };
