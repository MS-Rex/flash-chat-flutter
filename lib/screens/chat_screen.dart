import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

late User loggedUser;
late bool isMe;

class ChatScreen extends StatefulWidget {
  static const id = 'chat';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  late String messagetxt;

  final txtClear = TextEditingController();

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedUser = user;
        print(loggedUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  // void getMessages() async {
  //   try {
  //     final messgs = await _firestore.collection('messages').get();
  //     for (var msg in messgs.docs) {
  //       print(msg.data());
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // void messageStream() async {
  //   await for (var streamTxt in _firestore.collection('messages').snapshots()) {
  //     for (var msg in streamTxt.docs) {
  //       print(msg.data()['text']);
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () async {
                // await _auth.signOut();
                // Navigator.pop(context);
                // messageStream();
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuildWidget(_firestore),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: txtClear,
                      onChanged: (value) {
                        //Do something with the user input.
                        messagetxt = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      txtClear.clear();
                      _firestore.collection('messages').add({
                        'text': messagetxt,
                        'email': loggedUser.email,
                      });
                      //Implement send functionality.
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StreamBuildWidget extends StatelessWidget {
  StreamBuildWidget(this._firestore);

  final FirebaseFirestore _firestore;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('messages').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final messages = snapshot.data?.docs;
            List<MsgBubble> messagesWidgets = [];

            //Map<String, dynamic> data = messages as Map<String, dynamic>;
            if (messages != null) {
              for (var message in messages) {
                final messageText = message['text'];
                final messageSender = message['email'];
                final messageWidget = MsgBubble(messageSender, messageText);
                //checkUser(messageSender);
                messagesWidgets.add(messageWidget);
              }
            }

            return Expanded(
              child: ListView(
                //physics: const AlwaysScrollableScrollPhysics(),
                children: messagesWidgets,
                //scrollDirection: Axis.vertical,
                shrinkWrap: true,
              ),
            );
          } else {
            return Text('Hello');
          }
        });
  }
}

class MsgBubble extends StatelessWidget {
  final messageText;
  final messageSender;
  MsgBubble(this.messageSender, this.messageText);

  @override
  Widget build(BuildContext context) {
    loggedUser.email == messageSender ? isMe = true : isMe = false;
    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                messageSender,
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
              Material(
                borderRadius: isMe
                    ? BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))
                    : BorderRadius.only(
                        topRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                elevation: 10,
                color: isMe ? Colors.green : Colors.lightBlueAccent,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text(
                    '$messageText',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
