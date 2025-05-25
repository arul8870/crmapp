import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CallPage extends StatefulWidget {
  final String callerId;
  final String calleeId;
  final bool isCaller;

  const CallPage({
    super.key,
    required this.callerId,
    required this.calleeId,
    required this.isCaller,
  });

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  late RTCPeerConnection _peerConnection;
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();

  @override
  void initState() {
    super.initState();
    _initRenderers();

    if (widget.isCaller) {
      _startCallerFlow();
    } else {
      _startReceiverFlow();
    }
  }

  Future<void> _initRenderers() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
  }

  Future<void> _startCallerFlow() async {
    final Map<String, dynamic> config = {
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'},
      ],
    };

    _peerConnection = await createPeerConnection(config);

    final localStream = await navigator.mediaDevices.getUserMedia({
      'audio': true,
      'video': true,
    });
    _localRenderer.srcObject = localStream;
    localStream.getTracks().forEach((track) {
      _peerConnection.addTrack(track, localStream);
    });

    _peerConnection.onTrack = (event) {
      if (event.track.kind == 'video') {
        setState(() {
          _remoteRenderer.srcObject = event.streams[0];
        });
      }
    };

    final offer = await _peerConnection.createOffer();
    await _peerConnection.setLocalDescription(offer);

    final callDoc = FirebaseFirestore.instance
        .collection('calls')
        .doc(widget.calleeId);

    await callDoc.update({
      'callerId': widget.callerId,
      'calleeId': widget.calleeId,
      'offer': offer.toMap(),
    });

    callDoc.snapshots().listen((snapshot) async {
      final data = snapshot.data();
      if (data != null && data['answer'] != null) {
        final answer = RTCSessionDescription(
          data['answer']['sdp'],
          data['answer']['type'],
        );
        await _peerConnection.setRemoteDescription(answer);
      }
    });
  }

  Future<void> _startReceiverFlow() async {
    final callDoc = FirebaseFirestore.instance
        .collection('calls')
        .doc(widget.calleeId);

    _peerConnection = await createPeerConnection({
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'},
      ],
    });

    final localStream = await navigator.mediaDevices.getUserMedia({
      'audio': true,
      'video': true,
    });
    _localRenderer.srcObject = localStream;

    localStream.getTracks().forEach((track) {
      _peerConnection.addTrack(track, localStream);
    });

    _peerConnection.onTrack = (event) {
      if (event.track.kind == 'video') {
        setState(() {
          _remoteRenderer.srcObject = event.streams[0];
        });
      }
    };

    callDoc.snapshots().listen((snapshot) async {
      final data = snapshot.data();
      if (data != null && data['offer'] != null) {
        final offer = RTCSessionDescription(
          data['offer']['sdp'],
          data['offer']['type'],
        );

        await _peerConnection.setRemoteDescription(offer);

        final answer = await _peerConnection.createAnswer();
        await _peerConnection.setLocalDescription(answer);

        await callDoc.update({'answer': answer.toMap()});
      }
    });
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    _peerConnection.close();

    FirebaseFirestore.instance
        .collection('calls')
        .doc(widget.calleeId)
        .delete();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Call'),
        actions: [
          IconButton(
            icon: Icon(Icons.call_end),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          RTCVideoView(
            _remoteRenderer,
            objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
          ),
          Positioned(
            right: 20,
            bottom: 20,
            width: 120,
            height: 160,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
              ),
              child: RTCVideoView(_localRenderer, mirror: true),
            ),
          ),
        ],
      ),
    );
  }
}
