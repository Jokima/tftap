import 'package:flutter/material.dart';

class AppBarWidget extends PreferredSize {
  AppBarWidget()
      : super(
          preferredSize: Size.fromHeight(80),
          child: Container(
            decoration: BoxDecoration(color: Colors.transparent),
            height: 50,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.menu),
                  color: Colors.white,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        );
}
