// import 'package:flutter/material.dart';
// import 'package:kazi/app/shared/constants/app_onboarding.dart';
// import 'package:kazi/app/shared/l10n/generated/l10n.dart';
// import 'package:kazi/app/shared/themes/themes.dart';
// import 'package:kazi/app/shared/widgets/buttons/buttons.dart';

// class OnboardingTooltip extends StatelessWidget {
//   const OnboardingTooltip({
//     super.key,
//     required this.title,
//     required this.description,
//     required this.currentPage,
//     this.onPreviousCallback,
//     this.onNextCallback,
//     this.width,
//   });

//   final String title;
//   final String description;
//   final int currentPage;
//   final VoidCallback? onPreviousCallback;
//   final VoidCallback? onNextCallback;
//   final double? width;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: width ?? context.width * 0.918,
//       decoration: const BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.all(Radius.circular(18)),
//       ),
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(
//               top: AppSizeConstants.largeSpace,
//               bottom: AppSizeConstants.smallSpace,
//               left: AppSizeConstants.largeSpace,
//               right: AppSizeConstants.largeSpace,
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(title, style: context.titleMedium),
//                 Text(
//                   '$currentPage of ${AppOnboarding.instance.targets.length}',
//                   style: context.labelMedium,
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(
//                 horizontal: AppSizeConstants.largeSpace),
//             child: Text(
//               description,
//               style: context.bodyMedium,
//             ),
//           ),
//           AppSizeConstants.mediumVerticalSpacer,
//           const Divider(
//             color: AppColors.lightGrey,
//             thickness: 0.9,
//           ),
//           AppSizeConstants.mediumVerticalSpacer,
//           Padding(
//             padding: const EdgeInsets.only(
//               bottom: AppSizeConstants.mediumSpace,
//               left: AppSizeConstants.largeSpace,
//               right: AppSizeConstants.largeSpace,
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Visibility(
//                   visible: currentPage > 1,
//                   child: CircularButton(
//                     onTap: () {
//                       if (onPreviousCallback != null) onPreviousCallback!();
//                     },
//                     child: const Icon(Icons.chevron_left),
//                   ),
//                 ),
//                 PillButton(
//                   onTap: () {
//                     if (onNextCallback != null) onNextCallback!();
//                   },
//                   child: Text(
//                     currentPage == AppOnboarding.instance.targets.length
//                         ? AppLocalizations.current.finish
//                         : AppLocalizations.current.next,
//                   ),
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
