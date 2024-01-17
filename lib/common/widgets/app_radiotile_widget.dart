
import 'package:flutter/material.dart';
import 'package:inquiryapp/common/app_colors.dart';

class AppRadioTileWidget extends StatelessWidget {
  const AppRadioTileWidget({
    super.key,
    required this.title,
    required this.value,
    required this.groupValue,
    this.subtitle,
    this.onChanged,
  });

  final String title;
  final Widget? subtitle;
  final dynamic value;
  final dynamic groupValue;
  final void Function(dynamic)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(-10, 0),
      child: RadioListTile(
        activeColor: AppColors.primary,
        contentPadding: EdgeInsets.zero,
        title: Transform.translate(
          offset: const Offset(-18, 0),
          child: Text(title),
        ),
        subtitle: subtitle,
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
      ),
    );
  }
}