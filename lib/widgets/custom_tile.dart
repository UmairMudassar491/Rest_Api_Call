import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {super.key, required this.leadingText, required this.titleText});
  final String leadingText, titleText;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: width,
      height: height * 0.07,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
        leading: SizedBox(width: width * 0.2, child: Text(leadingText)),
        title: Text(
          titleText,
          style: const TextStyle(fontSize: 10),
        ),
      ),
    );
  }
}
