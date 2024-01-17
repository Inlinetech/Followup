
import 'package:flutter/material.dart';
import 'package:inquiryapp/common/app_colors.dart';

class AppCheckBoxTileWidget extends StatelessWidget {
  const AppCheckBoxTileWidget({
    super.key,
    required this.title,
    required this.value,
    required this.groupValue,
    this.subtitle,
    this.onChanged,
  });

  final String title;
  final Widget? subtitle;
  final bool value;
  final dynamic groupValue;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(-10, 0),
      child: CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: AppColors.primary,
        contentPadding: EdgeInsets.zero,
        title: Transform.translate(
          offset: const Offset(-18, 0),
          child: Text(title),
        ),
        subtitle: subtitle,
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}