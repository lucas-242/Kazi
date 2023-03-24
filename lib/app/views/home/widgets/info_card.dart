import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_services/app/shared/themes/themes.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String icon;
  final Color color;
  const InfoCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: SizedBox(
        height: 98,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.cardTitle,
                  ),
                  Text(
                    subtitle,
                    style: context.cardSubtitle,
                  ),
                ],
              ),
              SvgPicture.asset(
                icon,
                height: 35,
                colorFilter: ColorFilter.mode(
                  context.colorsScheme.background,
                  BlendMode.srcIn,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
