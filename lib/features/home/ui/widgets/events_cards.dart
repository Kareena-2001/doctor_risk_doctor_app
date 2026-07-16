// import 'package:Doctors_App/theme/app_colors.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:share_plus/share_plus.dart';
//
// import '../../../../core/constants/dimensions.dart';
// import '../../../../core/constants/responsive.dart';
// import '../../../../core/constants/values/app_text_style.dart';
// import '../../../common/ui/widgets/primary_button.dart';
//
// class EventsCards extends StatelessWidget {
//   final String userId;
//
//   String get _referralCode => userId
//       .replaceAll(RegExp(r'[^a-zA-Z0-9]'), '')
//       .toUpperCase()
//       .padRight(6, '0')
//       .substring(0, 6);
//
//   String get _inviteLink => 'https://saarthi.app/invite/$_referralCode';
//
//   String get _shareMessage =>
//       'Hey! Join me on Saathi 🚴 Use my code $_referralCode and we both get 7 days of Premium free!\n$_inviteLink';
//
//   const EventsCards({super.key, required this.userId});
//
//   @override
//   Widget build(BuildContext context) {
//     final cards = [
//       {
//         'name': 'Live Webinar',
//         'desc':
//             'Upcoming Webinar: Telemedicine Laws and How it Impacts Medical Practice?',
//         'image': 'assets/images/events.jpg',
//         'Know More': true,
//       },
//       {
//         'name': 'Collaborate',
//         'desc':
//             'Upcoming Webinar: Telemedicine Laws and How it Impacts Medical Practice?',
//         'image': 'assets/images/events.jpg',
//         'Know More': false,
//       },
//       {
//         'name': 'Your Story',
//         'desc':
//             'Upcoming Webinar: Telemedicine Laws and How it Impacts Medical Practice?',
//         'image': 'assets/images/events.jpg',
//         'Know More': false,
//       },
//     ];
//
//     return SizedBox(
//       height: Responsive.h(265),
//       child: ListView.separated(
//         scrollDirection: Axis.horizontal,
//         physics: const BouncingScrollPhysics(),
//         padding: EdgeInsets.only(left: Responsive.w(2), right: Responsive.w(4)),
//         itemCount: cards.length,
//         separatorBuilder: (_, __) => SizedBox(width: Responsive.w(14)),
//         itemBuilder: (context, index) {
//           final c = cards[index];
//           final bool avail = c['Know More'] as bool;
//           return Container(
//             width: Responsive.w(220),
//             decoration: BoxDecoration(
//               color: AppColors.white,
//               borderRadius: BorderRadius.circular(Responsive.w(20)),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withValues(alpha: 0.05),
//                   blurRadius: 16,
//                   offset: const Offset(0, 8),
//                 ),
//               ],
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.vertical(
//                     top: Radius.circular(Responsive.w(20)),
//                   ),
//                   child: Image.asset(
//                     c['image'] as String,
//                     height: Responsive.h(130),
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.fromLTRB(
//                     Responsive.w(12),
//                     Responsive.h(10),
//                     Responsive.w(12),
//                     0,
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         c['name'] as String,
//                         style: customTextStyle(
//                           fontSize: Responsive.sp(13),
//                           fontWeight: FontWeight.w700,
//                           color: AppColors.textColor,
//                         ).copyWith(overflow: TextOverflow.ellipsis),
//                       ),
//                       SizedBox(height: Responsive.h(4)),
//                       Text(
//                         c['desc'] as String,
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                         style: customTextStyle(
//                           fontSize: Responsive.sp(11),
//                           color: AppColors.homeTextMuted,
//                         ),
//                       ),
//                       SizedBox(height: Responsive.h(10)),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: PrimaryButton(
//                               text: avail ? 'Register to Join' : 'Know More',
//                               fontWeight: FontWeight.w700,
//                               fontSize: Responsive.sp(12),
//                               onPressed: () {},
//                               height: Responsive.h(42),
//                               backgroundColor: avail
//                                   ? AppColors.newPri
//                                   : AppColors.homeBorder,
//                               borderRadius: Responsive.w(10),
//                             ),
//                           ),
//                           width(Responsive.w(10)),
//                           InkWell(
//                             onTap: () => Share.share(_shareMessage),
//                             borderRadius: BorderRadius.circular(
//                               Responsive.w(10),
//                             ),
//                             child: Container(
//                               width: Responsive.w(42),
//                               height: Responsive.h(42),
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(
//                                   Responsive.w(10),
//                                 ),
//                                 border: Border.all(color: AppColors.homeBorder),
//                               ),
//                               child: Icon(
//                                 Icons.share_outlined,
//                                 size: Responsive.sp(20),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
