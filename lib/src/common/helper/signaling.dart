import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class CallSignaling {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> sendOffer(String toUserId, RTCSessionDescription offer) async {
    await firestore.collection('calls').doc(toUserId).set({
      'offer': offer.toMap(),
    });
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> onCall(String myUserId) {
    return firestore.collection('calls').doc(myUserId).snapshots();
  }

  Future<void> sendAnswer(String toUserId, RTCSessionDescription answer) async {
    await firestore.collection('calls').doc(toUserId).update({
      'answer': answer.toMap(),
    });
  }
}
