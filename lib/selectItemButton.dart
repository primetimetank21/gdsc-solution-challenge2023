import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:network_image_search/network_image_search.dart';

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
    return Padding(
        padding: EdgeInsets.all(20),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
            ),
          ),
          onPressed: () {

            print("clicked ${(widget.itemInfo[1]).toString().substring(2)}");
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('${(widget.itemInfo[0]).toString().substring(2)}'),
              Unsplash(
                width: '40',
                height: '40',
                category:
                    'picture of ${(widget.itemInfo[0]).toString().substring(2)}',
                subcategory:
                    'picture of ${(widget.itemInfo[0]).toString().substring(2)}',
              ),
            ],
          ),
          //substring(1, (widget.itemInfo[0]).toString().length)
        ));
  }
}
