const tf = require('@tensorflow/tfjs');
export {tf};

// wasm....
// :(
// require('@tensorflow/tfjs-backend-wasm');
// tf.setBackend('wasm');

//@ts-ignore
import AudioRecorder from 'audio-recorder-polyfill';
export {AudioRecorder};

import * as audio_loader from './audio_loading_utils';
import * as audio_model from './audio_model';
import * as audio_utils from './audio_utils';
import * as spectrogram_utils from './spectrogram_utils';
import * as ui_utils from './ui_utils';

export {
    ui_utils,
    audio_loader,
    audio_model,
    audio_utils,
    spectrogram_utils
};