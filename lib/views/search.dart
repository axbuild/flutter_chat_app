import 'package:chatapp/widgets/widget.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      decoration: textFieldInputDecoration('search'),
                    ),
                  ),

                  Icon(
                      Icons.search,
                      color: Colors.black38,
                      size: 28.0
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
