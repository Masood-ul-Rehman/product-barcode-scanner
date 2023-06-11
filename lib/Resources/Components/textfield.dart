// ignore_for_file: implementation_imports, unnecessary_import, unused_import, sized_box_for_whitespace, deprecated_member_use, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../color.dart';

class InputTextFormField extends StatelessWidget {
  const InputTextFormField({
    super.key,
    required this.myController,
    required this.focusNode,
    required this.onfieldSubmittedvalue,
    required this.onValidator,
    required this.keyboardtype,
    required this.hint,
    required this.obsecuretext,
    this.autofocus = false,
    this.enable = false,
    required this.prefixicon,
  });
  final TextEditingController myController;
  final FocusNode focusNode;
  final FormFieldSetter onfieldSubmittedvalue;
  final FormFieldValidator onValidator;
  final TextInputType keyboardtype;
  final String hint;
  final bool obsecuretext;
  final bool enable, autofocus;
  final Icon prefixicon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: myController,
      obscureText: obsecuretext,
      focusNode: focusNode,
      onFieldSubmitted: onfieldSubmittedvalue,
      validator: onValidator,
      style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 19),
      keyboardType: keyboardtype,
      decoration: InputDecoration(
          hintText: hint,
          prefixIcon: prefixicon,
          contentPadding: EdgeInsets.all(15),
          hintStyle: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: AppColors.primaryTextTextColor.withOpacity(.8)),
          border: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.textFieldDefaultFocus,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.secondaryColor,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.alertColor,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.textFieldDefaultBorderColor,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8)))),
    );
  }
}
