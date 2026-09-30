import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/widgets/custom_dropdown_field.dart';
import 'package:Doctors_App/core/widgets/custom_text_field.dart';
import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/features/appointment/model/appointment_item.dart';
import 'package:Doctors_App/features/appointment/ui/view_model/appointment_view_model.dart';
import 'package:Doctors_App/features/common/ui/widgets/primary_button.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:Doctors_App/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<bool?> showAppointmentEditSheet(
  BuildContext context,
  AppointmentItem appointment,
) {
  return showModalBottomSheet<bool>(
    context: context,
    backgroundColor: context.primaryBackgroundColor,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => AppointmentEditSheet(appointment: appointment),
  );
}

class AppointmentEditSheet extends ConsumerStatefulWidget {
  final AppointmentItem appointment;

  const AppointmentEditSheet({super.key, required this.appointment});

  @override
  ConsumerState<AppointmentEditSheet> createState() =>
      _AppointmentEditSheetState();
}

class _AppointmentEditSheetState extends ConsumerState<AppointmentEditSheet> {
  static const _priorities = ['Normal', 'High', 'Urgent'];

  late final TextEditingController _descCtrl;
  late String _priority;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _descCtrl = TextEditingController(
      text: widget.appointment.description ?? '',
    );
    _priority = _priorities.contains(widget.appointment.priority)
        ? widget.appointment.priority
        : _priorities.first;
  }

  @override
  void dispose() {
    _descCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_saving) return;
    setState(() => _saving = true);

    final ok = await ref
        .read(appointmentViewModelProvider.notifier)
        .updateAppointment(
          id: widget.appointment.id.toString(),
          description: _descCtrl.text.trim(),
          priority: _priority,
        );

    if (mounted) Navigator.pop(context, ok);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Edit Appointment', style: AppTheme.title16),
              height(8),
              Text(
                'Update your appointment details below.',
                style: AppTheme.subtitle12.copyWith(
                  color: context.secondaryTextColor,
                ),
              ),
              height(16),
              CustomDropdownField<String>(
                value: _priority,
                label: 'Priority',
                items: _priorities,
                onChanged: (v) => setState(() => _priority = v ?? _priority),
              ),
              height(12),
              CustomTextField(
                controller: _descCtrl,
                maxLines: 4,
                label: 'Description',
              ),
              height(20),
              SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                  height: 50,
                  fontSize: 14,
                  gradient: LinearGradient(
                    colors: [AppColors.newPri, AppColors.primary],
                  ),
                  text: _saving ? 'Saving...' : 'Save Changes',
                  onPressed: _save,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
