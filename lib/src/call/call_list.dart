import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';

class CallListScreen extends StatelessWidget {
  final String currentUserId;

  const CallListScreen({super.key, required this.currentUserId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Call List")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('calls').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final calls = snapshot.data!.docs;

          for (var doc in calls) {
            final data = doc.data() as Map<String, dynamic>;
            final calleeId = data['calleeId'];
            final callerId = data['callerId'];
            final answer = data['answer'];

            if (calleeId == currentUserId && answer == null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _showIncomingCallDialog(context, callerId, calleeId);
              });
              break;
            }
          }

          return ListView(
            children: [
              ListTile(
                title: Text("Call user2"),
                trailing: ElevatedButton(
                  onPressed: () async {
                    final calleeId = 'user2';

                    await FirebaseFirestore.instance
                        .collection('calls')
                        .doc(calleeId)
                        .set({'callerId': currentUserId, 'calleeId': calleeId});

                    context.push(
                      '/call',
                      extra: {
                        'callerId': currentUserId,
                        'calleeId': calleeId,
                        'isCaller': true,
                      },
                    );
                  },
                  child: Text("Call user2"),
                ),
              ),
              ListTile(
                title: Text("Call user3"),
                trailing: ElevatedButton(
                  onPressed: () async {
                    final calleeId = 'user3';

                    await FirebaseFirestore.instance
                        .collection('calls')
                        .doc(calleeId)
                        .set({'callerId': currentUserId, 'calleeId': calleeId});

                    context.push(
                      '/call',
                      extra: {
                        'callerId': currentUserId,
                        'calleeId': calleeId,
                        'isCaller': true,
                      },
                    );
                  },
                  child: Text("Call user3"),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showIncomingCallDialog(
    BuildContext context,
    String callerId,
    String calleeId,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (_) => AlertDialog(
            title: Text('Incoming Call'),
            content: Text('$callerId is calling you'),
            actions: [
              TextButton(
                onPressed: () async {
                  await FirebaseFirestore.instance
                      .collection('calls')
                      .doc(calleeId)
                      .delete();
                  Navigator.pop(context);
                },
                child: Text('Reject'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);

                  context.go(
                    '/call',
                    extra: {
                      'callerId': callerId,
                      'calleeId': calleeId,
                      'isCaller': false,
                    },
                  );
                },
                child: Text('Accept'),
              ),
            ],
          ),
    );
  }
}
