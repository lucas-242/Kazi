import 'package:flutter/material.dart';
import '../../themes/themes.dart';
import '../../utils/number_format_helper.dart';

class ServiceListTotalCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final num value;
  const ServiceListTotalCard(
      {super.key,
      required this.value,
      required this.icon,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon),
        Text(
          NumberFormatHelper.formatCurrency(context, value),
          style: context.bodyLarge,
        ),
        Text(title, style: context.bodyMedium),
      ],
    );
  }
}
