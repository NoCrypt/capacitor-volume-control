# capacitor-volume-control

Adjust system-level volume in your Capacitor Apps. 

The value are normalized to `0-100` range

## Supported platforms

| Platform | Supported |
| -------- | --------- |
| Android  | ✅        |
| iOS      | ✅⚠️ (untested)        |
| Web      | ❌        |

## Install

```bash
npm install capacitor-volume-control
npx cap sync
```

## Usage
```typescript
import { VolumeControl } from 'capacitor-volume-control';

// Set the volume:
const volume = 50;
await VolumeControl.setvolume({ volume });

// Get the current volume:
const {volume: currentvolume} = await VolumeControl.getvolume();
```

## API

* [`getVolume(...)`](#getvolume)
* [`setVolume(...)`](#setvolume)
* [Type Aliases](#type-aliases)


### getVolume(...)

```typescript
getVolume(options?: { streamType?: StreamType | undefined; } | undefined) => Promise<{ volume: number }>
```

| Param         | Type                                                                |
| ------------- | ------------------------------------------------------------------- |
| **`options`** | <code>{ streamType?: <a href="#streamtype">StreamType</a>; }</code> |

**Returns:** <code>Promise<{ volume: number }></code>

--------------------


### setVolume(...)

```typescript
setVolume(options: { volume: number; showUI?: boolean; streamType?: StreamType; }) => Promise<void>
```

| Param         | Type                                                                                                  |
| ------------- | ----------------------------------------------------------------------------------------------------- |
| **`options`** | <code>{ volume: number; showUI?: boolean; streamType?: <a href="#streamtype">StreamType</a>; }</code> |

**Returns:** <code>Promise\<void\></code>

--------------------


### Type Aliases


#### StreamType

<code>'STREAM_VOICE_CALL' | 'STREAM_SYSTEM' | 'STREAM_RING' | 'STREAM_MUSIC' | 'STREAM_ALARM' | 'STREAM_NOTIFICATION' | 'STREAM_DTMF'</code>

