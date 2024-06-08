import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kazi/app/core/themes/themes.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.width,
  });

  final String title;
  final String subtitle;
  final String icon;
  final Color color;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: SizedBox(
        height: 92,
        width: width,
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
                colorFilter: const ColorFilter.mode(
                  AppColors.white,
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
