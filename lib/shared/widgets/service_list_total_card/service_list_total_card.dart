import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_services/shared/themes/themes.dart';

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
      children: [
        Text(NumberFormat.currency(symbol: 'R\$').format(value),
            style: context.bodyLarge),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon),
            Text(title, style: context.bodyMedium),
            const SizedBox(width: 8),
          ],
        ),
      ],
    );
  }
}
