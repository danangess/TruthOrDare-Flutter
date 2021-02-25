import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoadingWidget extends StatelessWidget {
  LoadingWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
