import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchInputWidget extends StatelessWidget {
  const SearchInputWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: TextField(
            decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: 'Search For Products',
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Icon(CupertinoIcons.search),
          ),
        )),
      ),
    );
  }
}
