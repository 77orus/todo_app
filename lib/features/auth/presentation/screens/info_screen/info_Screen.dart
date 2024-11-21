import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 280.h,
          ),
          Center(
            child: Text(
              'Created By :',
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Center(
            child: Text(
              'Hossam Magdy',
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.facebook,
              size: 45,
            ),
          ),
        ],
      )),
    );
  }
}
