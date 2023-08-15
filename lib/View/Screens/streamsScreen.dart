import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

import '../../Services/apis/linking.dart';
import '../../main.dart';

class Streams extends StatefulWidget {
   Streams({Key? key}) : super(key: key);

  @override
  State<Streams> createState() => _StreamsState();
}

class _StreamsState extends State<Streams> {
  late IOWebSocketChannel channel;
   bool _isConnected = false;

   void connect(BuildContext context) async {
     var token = sharedPreferences!.getInt('access_id');
     channel = IOWebSocketChannel.connect(
         Uri.parse('ws://$ip/ws/live/64/'),
         headers: {'Authorization': token});
     setState(() {
       _isConnected = true;
     });
   }

   void disconnect() {

     setState(() {
       _isConnected = false;
     });
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Live Video"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () => connect(context),
                    child: const Text("Connect"),
                  ),
                  ElevatedButton(
                    onPressed: disconnect,
                    child: const Text("Disconnect"),
                  ),
                ],
              ),
              const SizedBox(
                height: 50.0,
              ),
              _isConnected
                  ? StreamBuilder(
                stream:channel.stream,
                builder: (context, snapshot) {
                  //print(snapshot.data);
                  var json=jsonDecode(snapshot.data);
                  print(json);
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }

                  if (snapshot.connectionState == ConnectionState.done) {
                    return const Center(
                      child: Text("Connection Closed !"),
                    );
                  }
                  //? Working for single frames/**/
                  // Decode the base64 encoded JSON data to bytes
                  List<int> jsonData = jsonDecode(snapshot.data);
                  Uint8List bytes = Uint8List.fromList(jsonData.cast<int>());
                  return Image.memory(
                  bytes,
                    gaplessPlayback: true,
                    excludeFromSemantics: true,
                  );
                },
              )
                  : const Text("Initiate Connection")
            ],
          ),
        ),
      ),
    );
  }
}
