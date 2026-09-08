// Copyright 2026 LiveKit, Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter_test/flutter_test.dart';
import 'package:livekit_client/src/track/remote/audio.dart';
import 'package:livekit_client/src/track/web/_audio_api.dart' as audio_api;

void main() {
  group('clampRemoteAudioGain', () {
    test('piso 0.0 e NaN vira 1.0', () {
      expect(clampRemoteAudioGain(1.0), 1.0);
      expect(clampRemoteAudioGain(0.0), 0.0);
      expect(clampRemoteAudioGain(-0.5), 0.0);
      expect(clampRemoteAudioGain(double.nan), 1.0);
    });

    test('teto 4.0 (outputGain x participantGain, 2.0 cada)', () {
      expect(clampRemoteAudioGain(2.0), 2.0);
      expect(clampRemoteAudioGain(4.0), 4.0);
      expect(clampRemoteAudioGain(9.0), 4.0);
      expect(clampRemoteAudioGain(double.infinity), 4.0);
    });
  });

  group('audio api stub (VM)', () {
    test('stub fora do web não tem ganho > 1.0 e aceita setVolume', () {
      expect(audio_api.supportsOutputGain, isFalse);
      audio_api.setVolume('cid-qualquer', 1.5);
    });
  });
}
