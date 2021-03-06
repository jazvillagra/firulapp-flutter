import 'package:firulapp/constants/constants.dart';
import 'package:firulapp/src/chat/widgets/messages.dart';
import 'package:firulapp/src/chat/widgets/new_message.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  static const routeName = "/chat";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.kSecondaryColor,
        title: Text('Firulapp Chat', style: TextStyle(color: Colors.white)),
        // actions: [
        //   DropdownButton(
        //     icon: Icon(
        //       Icons.more_vert,
        //       color: Theme.of(context).primaryIconTheme.color,
        //     ),
        //     items: [
        //       DropdownMenuItem(
        //         child: Container(
        //           child: Row(
        //             children: <Widget>[
        //               Icon(Icons.exit_to_app),
        //               SizedBox(width: 8),
        //               Text('Volver'),
        //             ],
        //           ),
        //         ),
        //         value: 'volver',
        //       ),
        //     ],
        //     onChanged: (itemIdentifier) {
        //       if (itemIdentifier == 'volver') {
        //         Navigator.pop(context);
        //         // FirebaseAuth.instance.signOut();
        //       }
        //     },
        //   ),
        // ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
