import 'package:flutter/material.dart';

class Messages {
  final Key? key;
  final  message;
  final  userName;
  final  userImage;
  final  urlImage;
  final  isMe;
  final TimeSent;
  final String urlVoice;
  final isTyping;
  final id;
  final selected;
  final isReplied;
  Messages( {
    this.key,
    required this.id,
    required this.message,
    required this.userName,
    required this.userImage,
    required this.urlImage,
    required this.isMe,
    required this.TimeSent,
    required this.urlVoice,
    required this.selected,
    required this.isTyping,
    required this.isReplied,
  });
}
