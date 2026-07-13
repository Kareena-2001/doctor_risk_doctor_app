// import 'dart:io';
//
// import 'package:Doctors_App/features/helpdesk/model/suppport_enums.dart';
// import 'package:Doctors_App/features/helpdesk/ui/state/help_state.dart';
// import 'package:Doctors_App/features/helpdesk/ui/view_model/help_view_model.dart';
// import 'package:Doctors_App/features/helpdesk/ui/widgets/support_dropdown.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../../../../core/constants/dimensions.dart';
// import '../../../../core/widgets/custom_app_bar.dart';
// import '../../../../extensions/build_context_extension.dart';
// import '../../../../theme/app_colors.dart';
// import 'widgets/success_view.dart';
// import 'widgets/support_attachment_field.dart';
//
// // TODO: replace with your actual admin/service support line
// const _serviceCallNumber = '+911234567892';
//
// class ServiceSupportScreen extends ConsumerStatefulWidget {
//   const ServiceSupportScreen({super.key});
//
//   @override
//   ConsumerState<ServiceSupportScreen> createState() =>
//       _ServiceSupportScreenState();
// }
//
// class _ServiceSupportScreenState extends ConsumerState<ServiceSupportScreen> {
//   int _tabIndex = 0; // 0 = Chat Support, 1 = On Call Support
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(title: 'Service Support'),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: _ServiceToggle(
//               index: _tabIndex,
//               onChanged: (i) => setState(() => _tabIndex = i),
//             ),
//           ),
//           Expanded(
//             child: _tabIndex == 0
//                 ? const _ChatSupportForm()
//                 : const _ServiceOnCallView(),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _ChatSupportForm extends ConsumerStatefulWidget {
//   const _ChatSupportForm();
//
//   @override
//   ConsumerState<_ChatSupportForm> createState() => _ChatSupportFormState();
// }
//
// class _ChatSupportFormState extends ConsumerState<_ChatSupportForm> {
//   final TextEditingController _detailsController = TextEditingController();
//
//   ChatSupportCategory? _category;
//   PlatformFile? _selectedFile;
//   bool isSubmitted = false;
//
//   @override
//   void dispose() {
//     _detailsController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     ref.listen<HelpState>(helpViewModelProvider, (prev, next) {
//       if (prev?.isSuccess == false && next.isSuccess) {
//         context.showSuccessSnackBar('Request submitted successfully');
//         setState(() => isSubmitted = true);
//       }
//       if (next.error != null && next.error != prev?.error) {
//         context.showErrorSnackBar(next.error!);
//       }
//     });
//
//     final helpState = ref.watch(helpViewModelProvider);
//
//     if (isSubmitted) return const SuccessView();
//
//     return SingleChildScrollView(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SupportDropdown<ChatSupportCategory>(
//             label: 'What do you need help with?',
//             value: _category,
//             items: ChatSupportCategory.values,
//             displayName: (v) => v.displayName,
//             onChanged: (v) => setState(() => _category = v),
//           ),
//           height(16),
//           TextField(
//             controller: _detailsController,
//             maxLines: 5,
//             decoration: InputDecoration(
//               hintText: 'Describe your query...',
//               filled: true,
//               fillColor: context.secondaryWidgetColor,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//           ),
//           height(16),
//           SupportAttachmentField(
//             selectedFile: _selectedFile,
//             onChanged: (f) => setState(() => _selectedFile = f),
//           ),
//           height(24),
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton(
//               onPressed: helpState.isLoading ? null : _submit,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.primary,
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               child: helpState.isLoading
//                   ? const SizedBox(
//                 height: 20,
//                 width: 20,
//                 child: CircularProgressIndicator(
//                   color: Colors.white,
//                   strokeWidth: 2,
//                 ),
//               )
//                   : const Text(
//                 'Submit',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//           height(20),
//         ],
//       ),
//     );
//   }
//
//   void _submit() {
//     if (_category == null) {
//       context.showErrorSnackBar('Please select a category');
//       return;
//     }
//     ref
//         .read(helpViewModelProvider.notifier)
//         .submitChatSupport(
//       category: _category!,
//       details: _detailsController.text,
//       userAttachment: _selectedFile?.path != null
//           ? File(_selectedFile!.path!)
//           : null,
//     );
//   }
// }
//
// class _ServiceOnCallView extends StatelessWidget {
//   const _ServiceOnCallView();
//
//   Future<void> _call() async {
//     final uri = Uri.parse('tel:$_serviceCallNumber');
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(Icons.headset_mic_rounded, size: 48, color: AppColors.primary),
//           height(12),
//           const Text(
//             'Talk to our Support Team',
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//           height(4),
//           const Text(
//             'For service documents, account changes, or general queries',
//           ),
//           height(24),
//           SizedBox(
//             width: double.infinity,
//             child: ElevatedButton.icon(
//               onPressed: _call,
//               icon: const Icon(Icons.call, color: Colors.white),
//               label: const Text(
//                 'Call Now',
//                 style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//               ),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.primary,
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _ServiceToggle extends StatelessWidget {
//   final int index;
//   final ValueChanged<int> onChanged;
//
//   const _ServiceToggle({required this.index, required this.onChanged});
//
//   @override
//   Widget build(BuildContext context) {
//     const labels = ['Chat Support', 'On Call Support'];
//     return Container(
//       padding: const EdgeInsets.all(4),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade100,
//         borderRadius: BorderRadius.circular(30),
//       ),
//       child: Row(
//         children: List.generate(labels.length, (i) {
//           final selected = i == index;
//           return Expanded(
//             child: GestureDetector(
//               onTap: () => onChanged(i),
//               child: AnimatedContainer(
//                 duration: const Duration(milliseconds: 200),
//                 padding: const EdgeInsets.symmetric(vertical: 10),
//                 decoration: BoxDecoration(
//                   color: selected ? AppColors.primary : Colors.transparent,
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 child: Text(
//                   labels[i],
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: selected ? Colors.white : Colors.black87,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 13,
//                   ),
//                 ),
//               ),
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }