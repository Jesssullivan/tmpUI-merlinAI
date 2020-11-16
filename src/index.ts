//@ts-ignore
import AudioRecorder from 'audio-recorder-polyfill';
export {AudioRecorder};

const tf = require('@tensorflow/tfjs');
export {tf};

import * as audio_loader from './audio_loading_utils';
import * as audio_utils from './audio_utils';
import * as spectrogram_utils from './spectrogram_utils';
import * as audio_model from './audio_model';
import * as ui_utils from './ui_utils';

export {
    audio_model,
    audio_loader,
    audio_utils,
    spectrogram_utils,
    ui_utils,
};
