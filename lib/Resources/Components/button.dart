// ignore_for_file: implementation_imports, unnecessary_import, unused_import, sized_box_for_whitespace, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../color.dart';

class MyButton extends StatelessWidget {
  final String title;
  final VoidCallback onpress;
  final Color color, textcolor;
  final bool loading;
  const MyButton(
      {super.key,
      required this.title,
      this.color = AppColors.primaryColor,
      this.textcolor = AppColors.whiteColor,
      required this.onpress,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading ? null : onpress,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(50)),
        child: loading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Center(
                child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(fontSize: 16, color: textcolor),
              )),
      ),
    );
  }
}
