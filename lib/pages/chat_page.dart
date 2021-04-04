import 'dart:io';

import 'package:chatapp/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = new TextEditingController();
  final _focusNode = new FocusNode();
  bool _estaEscribiendo = false;

  final List<ChatMessage> messagess = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              maxRadius: 15,
              child: Text(
                'TE',
                style: TextStyle(fontSize: 14),
              ),
              backgroundColor: Colors.blue[100],
            ),
            Text(
              'Teresa',
              style: TextStyle(color: Colors.black87, fontSize: 10),
            )
          ],
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: Container(
          child: Column(
        children: [
          Flexible(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: messagess.length,
              itemBuilder: (BuildContext context, int index) {
                return messagess[index];
              },
              reverse: true,
            ),
          ),
          Divider(
            height: 1,
          ),
          Container(
            //Caja de texto
            decoration: BoxDecoration(color: Colors.white),
            child: _inputChat(),
          )
        ],
      )),
    );
  }

  Widget _inputChat() {
    return SafeArea(
        child: Container(
      margin: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Flexible(
              child: TextField(
            controller: _textController,
            onSubmitted: _handleSubmit,
            onChanged: (String texto) {
              setState(() {
                _estaEscribiendo = texto.trim().length > 0;
              });
            },
            decoration: InputDecoration(
              hintText: 'Enviar Mensaje',
            ),
            focusNode: _focusNode,
          )),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            child: Platform.isIOS
                ? CupertinoButton(
                    child: Text("Enviar"),
                    onPressed: _estaEscribiendo
                        ? () => _handleSubmit(_textController.text)
                        : null)
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    child: IconTheme(
                      data: IconThemeData(color: Colors.blue[400]),
                      child: IconButton(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          icon: Icon(Icons.send),
                          onPressed: _estaEscribiendo
                              ? () => _handleSubmit(_textController.text.trim())
                              : null),
                    ),
                  ),
          )
        ],
      ),
    ));
  }

  void _handleSubmit(String text) {
    if (text.trim().length == 0) return;
    print(text);

    final newMessagess = new ChatMessage(
      uid: "123",
      text: text,
      animationController: AnimationController(
          vsync: this, duration: Duration(milliseconds: 400)),
    );
    messagess.insert(0, newMessagess);
    newMessagess.animationController.forward();
    _textController.clear();
    setState(() {
      _estaEscribiendo = false;
    });

    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    //TODO : OFF del socket
    for (ChatMessage message in messagess) {
      message.animationController.dispose();
    }
    super.dispose();
  }
}
