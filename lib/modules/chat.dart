

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
final _firestore=FirebaseFirestore.instance;
User signedInUser;
class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final MessageController=TextEditingController();

  final _auth=FirebaseAuth.instance;

  String messageText;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }
  void getCurrentUser(){
    try{
      final user=_auth.currentUser;
      if(user!= null){
        signedInUser=user;
        print(signedInUser.email);
      }
    }catch(e){print(e);}

  }
  // void getMessages()async{
  //    final messages=await _firestore.collection('messages').get();
  //    for(var message in messages.docs){
  //      print(message.data());
  //    }
  // }
  // void messagesStreams()async{
  //    await for( var snapshot in _firestore.collection('messages').snapshots()){
  //      for(var message in snapshot.docs){
  //        print(message.data());
  //      }
  //    }}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: (){
              //messagesStreams();
              //   messagesStreams();
              //    _auth.signOut();
              //    Navigator.pop(context);
            },
            icon: Icon(Icons.close),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MessageStreamBuilder(),

            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 2,
                  ),
                ),
              ),
              child: Row(children: [
                Expanded(child: TextField(
                  controller: MessageController,
                  onChanged: (value){
                    messageText=value;

                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20
                    ),
                    hintText: "write your Message...",
                    border: InputBorder.none,
                  ),
                ),
                ),
                TextButton(onPressed: (){
                  MessageController.clear();
                  _firestore.collection("messages").add({
                    'text':messageText,
                    'sender':signedInUser.email,
                    'time':FieldValue.serverTimestamp(),

                  });
                },
                    child: Text("send",)
                ),

              ],),
            ),
          ],
        ),
      ),
    );
  }

}
class MessageStreamBuilder extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<QuerySnapshot>(
      stream:_firestore.collection('messages').orderBy('time').snapshots() ,
      builder: (context,snapshot){
        List<MessageLine> messagewidgets=[];
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.blue,
            ),
          );
        }

        final messages=snapshot.data.docs.reversed;
        for(var message in messages){
          final messageText=message.get('text');
          final messagesender=message.get('sender');
          final currentUser=signedInUser.email;

          final messageWidget=MessageLine(sender: messagesender,text: messageText,isMe: currentUser==messagesender,);
          messagewidgets.add(messageWidget);
        }
        return Expanded(

          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
            children: messagewidgets,
          ),
        );
      },
    );
  }
}

class MessageLine extends StatelessWidget {
  const MessageLine({this.text,this.sender,@required this.isMe });
  final String sender;
  final String text;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
          crossAxisAlignment: isMe?CrossAxisAlignment.end:CrossAxisAlignment.start,
          children: [
            Text('$sender',style: TextStyle(fontSize: 12,color: Colors.black45),),
            Material(
                elevation: 5,
                borderRadius:isMe? BorderRadius.only(topLeft: Radius.circular(30),bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)):BorderRadius.only(topRight: Radius.circular(30),bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)),
                color:isMe?Colors.blue[800]:Colors.orange,child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              child: Text('$text',style: TextStyle(color: isMe?Colors.white:Colors.black45),),
            )),]
      ),
    );
  }
}

