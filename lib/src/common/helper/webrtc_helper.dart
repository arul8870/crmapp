import 'package:flutter_webrtc/flutter_webrtc.dart';

Future<RTCPeerConnection> createPeerConnectionWithMedia() async {
  final config = {
    'iceServers': [
      {'urls': 'stun:stun.l.google.com:19302'},
    ],
  };
  final peer = await createPeerConnection(config);

  final localStream = await navigator.mediaDevices.getUserMedia({
    'audio': true,
    'video': true,
  });

  for (var track in localStream.getTracks()) {
    peer.addTrack(track, localStream);
  }

  return peer;
}
