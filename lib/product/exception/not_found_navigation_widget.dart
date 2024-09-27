import 'package:flutter/material.dart';

class NotFoundNavigationWidget extends StatelessWidget {
  const NotFoundNavigationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('Under construction!'),
      ),
    );
  }
}
