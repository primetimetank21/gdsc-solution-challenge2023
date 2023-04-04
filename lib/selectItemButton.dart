import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

class itemButton extends StatefulWidget {
  itemButton(this.itemInfo);

  List itemInfo;

  @override
  _itemButton createState() => _itemButton();
}

class _itemButton extends State<itemButton> {
  @override


  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.large(

      onPressed: () {
        // Add your onPressed code here!
      },
      child: Text('${(widget.itemInfo[0]).toString().substring(2)}'),
      //substring(1, (widget.itemInfo[0]).toString().length)
    );
  }
}
