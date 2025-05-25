import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VoiceCallPage extends StatefulWidget {
  final String callerId;
  final String calleeId;
  final bool isCaller;

  const VoiceCallPage({
    Key? key,
    required this.callerId,
    required this.calleeId,
    required this.isCaller,
  }) : super(key: key);

  @override
  _VoiceCallPageState createState() => _VoiceCallPageState();
}

class _VoiceCallPageState extends State<VoiceCallPage> {
  late RTCPeerConnection _peerConnection;
  MediaStream? _localStream;
  bool _isMuted = false;
  String _callStatus = "";

  @override
  void initState() {
    super.initState();
    _callStatus =
        widget.isCaller
            ? "Calling to ${widget.calleeId}..."
            : "Incoming call from ${widget.callerId}";
    if (widget.isCaller) {
      _startCallerFlow();
    } else {
      _startReceiverFlow();
    }
  }

  Future<void> _startCallerFlow() async {
    final config = {
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'},
      ],
    };

    _peerConnection = await createPeerConnection(config);

    _localStream = await navigator.mediaDevices.getUserMedia({
      'audio': true,
      'video': false,
    });

    _localStream!.getTracks().forEach((track) {
      _peerConnection.addTrack(track, _localStream!);
    });

    final offer = await _peerConnection.createOffer();
    await _peerConnection.setLocalDescription(offer);

    final callDoc = FirebaseFirestore.instance
        .collection('calls')
        .doc(widget.calleeId);

    await callDoc.set({
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
        setState(() {
          _callStatus = "Connected";
        });
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

    _localStream = await navigator.mediaDevices.getUserMedia({
      'audio': true,
      'video': false,
    });

    _localStream!.getTracks().forEach((track) {
      _peerConnection.addTrack(track, _localStream!);
    });

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

        setState(() {
          _callStatus = "Connected";
        });
      }
    });
  }

  @override
  void dispose() {
    _localStream?.dispose();
    _peerConnection.close();
    FirebaseFirestore.instance
        .collection('calls')
        .doc(widget.calleeId)
        .delete();
    super.dispose();
  }

  void _toggleMute() {
    if (_localStream == null) return;
    setState(() {
      _isMuted = !_isMuted;
      for (var track in _localStream!.getAudioTracks()) {
        track.enabled = !_isMuted;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: widget.isCaller ? _buildCallerUI() : _buildReceiverUI(),
      ),
    );
  }

  Widget _buildCallerUI() {
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white12,
                child: Icon(Icons.person, size: 60, color: Colors.white70),
              ),
              const SizedBox(height: 20),
              Text(
                _callStatus,
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 50,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  _isMuted ? Icons.mic_off : Icons.mic,
                  color: Colors.white,
                ),
                iconSize: 30,
                onPressed: _toggleMute,
              ),
              const SizedBox(width: 30),
              IconButton(
                icon: const Icon(Icons.call_end, color: Colors.red),
                iconSize: 40,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReceiverUI() {
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white12,
                child: Icon(Icons.person, size: 60, color: Colors.white70),
              ),
              const SizedBox(height: 20),
              Text(
                _callStatus,
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 50,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                heroTag: 'accept',
                backgroundColor: Colors.green,
                child: const Icon(Icons.call),
                onPressed: () {},
              ),
              FloatingActionButton(
                heroTag: 'reject',
                backgroundColor: Colors.red,
                child: const Icon(Icons.call_end),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
