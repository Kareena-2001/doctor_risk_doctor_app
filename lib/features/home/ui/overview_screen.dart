// import 'package:Doctors_App/features/home/ui/view_model/home_view_model.dart';
// import 'package:Doctors_App/features/home/ui/widgets/order_status_card.dart';
// import 'package:Doctors_App/theme/app_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
//
// import '../../../core/constants/dimensions.dart';
// import '../../../core/constants/values/app_constants.dart';
// import '../../../core/constants/values/app_text_style.dart';
// import '../../../routing/routes.dart';
// import '../../common/ui/widgets/common_dialog.dart';
//
// class OverviewScreen extends ConsumerStatefulWidget {
//   const OverviewScreen({super.key});
//
//   @override
//   ConsumerState<OverviewScreen> createState() => _OverviewScreenState();
// }
//
// class _OverviewScreenState extends ConsumerState<OverviewScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // height(10),
//         // _buildQuickStatsRow(isDark),
//         height(30),
//         _buildSectionHeader('Quick Access', isDark),
//         height(16),
//         // _buildQuickAccessGrid(),
//         height(30),
//         // _buildSectionHeader('Recent Activity', isDark),
//         // height(16),
//         // _buildRecentActivityList(isDark),
//       ],
//     );
//   }
//
//   Widget _buildQuickStatsRow(bool isDark) {
//     return Row(
//       children: [
//         Expanded(
//           child: _buildStatCard(
//             isDark: isDark,
//             icon: Icons.calendar_today_outlined,
//             label: 'Present Days',
//             value: '22',
//             color: Colors.green,
//           ),
//         ),
//         width(12),
//         Expanded(
//           child: _buildStatCard(
//             isDark: isDark,
//             icon: Icons.access_time_outlined,
//             label: 'Hours Logged',
//             value: '176',
//             color: Colors.blue,
//           ),
//         ),
//         width(12),
//         Expanded(
//           child: _buildStatCard(
//             isDark: isDark,
//             icon: Icons.event_available_outlined,
//             label: 'Leave Balance',
//             value: '12',
//             color: Colors.orange,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildStatCard({
//     required bool isDark,
//     required IconData icon,
//     required String label,
//     required String value,
//     required Color color,
//   }) {
//     return GestureDetector(
//       onTap: () {},
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: color.withValues(alpha: 0.08),
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(color: color.withValues(alpha: 0.2), width: 1),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: color.withValues(alpha: 0.15),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Icon(icon, size: 18, color: color),
//             ),
//             height(12),
//             Text(
//               value,
//               style: customTextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: isDark ? Colors.white : Colors.black87,
//               ),
//             ),
//             height(4),
//             Text(
//               label,
//               style: customTextStyle(
//                 fontSize: 11,
//                 fontWeight: FontWeight.w500,
//                 color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
//               ),
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSectionHeader(String title, bool isDark) {
//     return Row(
//       children: [
//         Container(
//           width: 4,
//           height: 22,
//           decoration: BoxDecoration(
//             color: AppColors.primary,
//             borderRadius: BorderRadius.circular(2),
//           ),
//         ),
//         width(12),
//         Text(
//           title,
//           style: customTextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: isDark ? Colors.white : Colors.black87,
//           ).copyWith(letterSpacing: 0.3),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildQuickAccessGrid() {
//     final state = ref.watch(homeViewModelProvider);
//     final attendanceEnabled = state.value?.data.attendance == true;
//
//     return GridView.count(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       crossAxisCount: 2,
//       crossAxisSpacing: 16,
//       mainAxisSpacing: 16,
//       childAspectRatio: 1.18,
//       children: [
//         // _buildAnimatedCard(
//         //   delay: 0,
//         //   child: OrderStatusCard(
//         //     title: 'Attendance',
//         //     count: 0,
//         //     accentColor: const Color(0xFF6366F1),
//         //     onTap: () {
//         //       showComingSoonDialog(context, "Attendance");
//         //       // context.push(Routes.attendanceScreen, extra: true);
//         //     },
//         //     icons: Icons.calendar_today_sharp,
//         //   ),
//         // ),
//         _buildAnimatedCard(
//           delay: 200,
//           child: OrderStatusCard(
//             title: 'Profile',
//             count: 0,
//             accentColor: const Color(0xFF6366F1),
//             // Pink
//             onTap: () {
//               // showComingSoonDialog(context, "Payslip");
//               context.push(Routes.myProfile, extra: true);
//             },
//             icons: Icons.supervised_user_circle,
//           ),
//         ),
//         _buildAnimatedCard(
//           delay: 100,
//           child: OrderStatusCard(
//             title: 'Offer Letter',
//             count: 0,
//             accentColor: const Color(0xFF14B8A6),
//             onTap: () async {
//               final profileResponse = await ref.read(
//                 homeViewModelProvider.future,
//               );
//
//               if (profileResponse?.data != null) {
//                 final olGenerateStatus = profileResponse!.data.olGenerate;
//                 debugPrint(
//                   '${AppConstants.tag} [olGenerateStatus] Fresh status = $olGenerateStatus',
//                 );
//
//                 if (olGenerateStatus == 'Generated') {
//                   if (context.mounted) {
//                     context.push(Routes.offerLetter);
//                   }
//                 } else if (olGenerateStatus == 'Pending' ||
//                     olGenerateStatus == null) {
//                   if (context.mounted) {
//                     showDialog(
//                       context: context,
//                       barrierDismissible: false,
//                       builder: (_) => const CommonDialog(
//                         title: 'Offer Letter',
//                         content:
//                             "Your application is currently under review by our HR team.\n\n"
//                             "Once your profile is verified and approved, your offer letter "
//                             "will be generated automatically and will be available here.",
//                         primaryButtonLabel: 'OK',
//                       ),
//                     );
//                   }
//                 }
//               }
//             },
//             icons: Icons.mark_email_read_rounded,
//           ),
//         ),
//         _buildAnimatedCard(
//           delay: 200,
//           child: OrderStatusCard(
//             title: 'Payslip',
//             count: 0,
//             accentColor: const Color(0xFFEC4899),
//             // Pink
//             onTap: () {
//               // showComingSoonDialog(context, "Payslip");
//               context.push(Routes.payslip, extra: true);
//             },
//             icons: Icons.payment,
//           ),
//         ),
//         if (attendanceEnabled)
//           _buildAnimatedCard(
//             delay: 200,
//             child: OrderStatusCard(
//               title: 'Attendance',
//               count: 0,
//               accentColor: const Color(0xFFF94854),
//               onTap: () {
//                 context.push(Routes.productList, extra: true);
//               },
//               icons: Icons.calendar_month,
//             ),
//           ),
//         if (attendanceEnabled)
//           _buildAnimatedCard(
//             delay: 200,
//             child: OrderStatusCard(
//               title: 'Holiday',
//               count: 0,
//               accentColor: const Color(0xFF8B5CF6),
//               onTap: () {
//                 context.push(Routes.productList, extra: true);
//               },
//               icons: Icons.celebration,
//             ),
//           ),
//         if (attendanceEnabled)
//           _buildAnimatedCard(
//             delay: 200,
//             child: OrderStatusCard(
//               title: 'Leave',
//               count: 0,
//               accentColor: const Color(0xFFF59E0B),
//               onTap: () {
//                 context.push(Routes.leaveList, extra: true);
//               },
//               icons: Icons.today,
//             ),
//           ),
//         _buildAnimatedCard(
//           delay: 200,
//           child: OrderStatusCard(
//             title: 'Submit Query',
//             count: 0,
//             accentColor: const Color(0xFFF97316),
//             // Pink
//             onTap: () {
//               // showComingSoonDialog(context, "Payslip");
//               context.push(Routes.myQueries, extra: true);
//             },
//             icons: Icons.query_builder_sharp,
//           ),
//         ),
//         // _buildAnimatedCard(
//         //   delay: 300,
//         //   child: OrderStatusCard(
//         //     title: 'Leave',
//         //     count: 0,
//         //     accentColor: const Color(0xFFF97316),
//         //     onTap: () {
//         //       showComingSoonDialog(context, "Leave");
//         //       // context.push(Routes.uploadDocuments, extra: {'isEditMode': true});
//         //     },
//         //     icons: Icons.library_books_outlined,
//         //   ),
//         // ),
//       ],
//     );
//   }
//
//   Widget _buildRecentActivityList(bool isDark) {
//     final activities = [
//       {
//         'icon': Icons.login_outlined,
//         'title': 'Clock In',
//         'time': 'Today at 9:30 AM',
//         'color': const Color(0xFF10B981),
//         'route': Routes.productList,
//       },
//       {
//         'icon': Icons.description_outlined,
//         'title': 'Payslip Generated',
//         'time': 'Yesterday at 5:00 PM',
//         'color': const Color(0xFF3B82F6),
//         'route': Routes.payslip,
//       },
//       {
//         'icon': Icons.event_available_outlined,
//         'title': 'Leave Approved',
//         'time': '2 days ago',
//         'color': const Color(0xFFF59E0B),
//         'route': null,
//       },
//     ];
//
//     return Column(
//       children: activities.map((activity) {
//         return GestureDetector(
//           onTap: () {
//             if (activity['route'] != null) {
//               context.push(activity['route'] as String, extra: true);
//             }
//           },
//           child: Container(
//             margin: const EdgeInsets.only(bottom: 12),
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: isDark
//                   ? Colors.white.withValues(alpha: 0.05)
//                   : Colors.black.withValues(alpha: 0.02),
//               borderRadius: BorderRadius.circular(16),
//               border: Border.all(
//                 color: isDark
//                     ? Colors.white.withValues(alpha: 0.1)
//                     : Colors.black.withValues(alpha: 0.08),
//               ),
//             ),
//             child: Row(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     color: (activity['color'] as Color).withValues(alpha: 0.1),
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(
//                       color: (activity['color'] as Color).withValues(
//                         alpha: 0.2,
//                       ),
//                       width: 1,
//                     ),
//                   ),
//                   child: Icon(
//                     activity['icon'] as IconData,
//                     size: 20,
//                     color: activity['color'] as Color,
//                   ),
//                 ),
//                 width(16),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         activity['title'] as String,
//                         style: customTextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                           color: isDark ? Colors.white : Colors.black87,
//                         ),
//                       ),
//                       height(4),
//                       Text(
//                         activity['time'] as String,
//                         style: customTextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                           color: isDark
//                               ? Colors.grey.shade400
//                               : Colors.grey.shade600,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Icon(
//                   Icons.chevron_right,
//                   color: isDark ? Colors.grey.shade600 : Colors.grey.shade400,
//                 ),
//               ],
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   }
//
//   Widget _buildAnimatedCard({required int delay, required Widget child}) {
//     return TweenAnimationBuilder<double>(
//       duration: Duration(milliseconds: 500 + delay),
//       tween: Tween(begin: 0.0, end: 1.0),
//       curve: Curves.easeOutCubic,
//       builder: (context, value, _) {
//         return Transform.translate(
//           offset: Offset(0, 20 * (1 - value)),
//           child: Opacity(opacity: value, child: child),
//         );
//       },
//     );
//   }
// }
