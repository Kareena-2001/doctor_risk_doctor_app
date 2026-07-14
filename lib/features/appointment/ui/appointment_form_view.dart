import 'package:Doctors_App/core/constants/dimensions.dart';
import 'package:Doctors_App/core/constants/values/app_text_style.dart';
import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
import 'package:Doctors_App/core/widgets/custom_text_field.dart';
import 'package:Doctors_App/extensions/build_context_extension.dart';
import 'package:Doctors_App/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:uuid/uuid.dart';

import '../model/appointment_model.dart';
import '../provider/appointment_provider.dart';
import '../../profile/model/certificate_model.dart';

class AppointmentFormView extends ConsumerStatefulWidget {
  const AppointmentFormView({super.key});

  @override
  ConsumerState<AppointmentFormView> createState() =>
      _AppointmentFormViewState();
}

class _AppointmentFormViewState extends ConsumerState<AppointmentFormView> {
  final _formKey = GlobalKey<FormState>();
  final _subjectController = TextEditingController();
  final _descriptionController = TextEditingController();

  AppointmentMode _selectedMode = AppointmentMode.videoCall;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  final List<PlatformFile> _pickedFiles = [];

  @override
  void dispose() {
    _subjectController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );
    if (date != null) setState(() => _selectedDate = date);
  }

  Future<void> _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (time != null) setState(() => _selectedTime = time);
  }

  Future<void> _pickDocuments() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
    );
    if (result != null) {
      setState(() => _pickedFiles.addAll(result.files));
    }
  }

  void _removeFile(int index) {
    setState(() => _pickedFiles.removeAt(index));
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedDate == null || _selectedTime == null) {
      context.showWarningSnackBar('Please select date and time');
      return;
    }

    final appointment = AppointmentModel(
      id: const Uuid().v4(),
      mode: _selectedMode,
      date: _selectedDate!,
      time: _selectedTime!,
      subject: _subjectController.text.trim(),
      description: _descriptionController.text.trim(),
      attachments: _pickedFiles
          .map((f) => CertificateModel(name: f.name, url: f.path ?? '', id: ''))
          .toList(),
    );

    ref.read(appointmentProvider.notifier).addAppointment(appointment);

    context.showSuccessSnackBar('Appointment booked');
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: CustomAppBar(title: 'Book Appointment'),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            Text('Mode Of Appointment', style: theme.textTheme.titleMedium),
            height(10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: AppointmentMode.values.map((mode) {
                final selected = mode == _selectedMode;
                return ChoiceChip(
                  selected: selected,
                  label: Text(mode.label),
                  avatar: Icon(
                    mode.icon,
                    size: 18,
                    color: selected ? AppColors.white : AppColors.newPri,
                  ),
                  labelStyle: customTextStyle(
                    color: selected ? AppColors.white : AppColors.newPri,
                  ),
                  selectedColor: AppColors.newPri,
                  onSelected: (_) => setState(() => _selectedMode = mode),
                );
              }).toList(),
            ),
            height(24),
            Row(
              children: [
                Expanded(
                  child: _PickerTile(
                    icon: Icons.calendar_today_outlined,
                    label: 'Date',
                    value: _selectedDate == null
                        ? 'Select date'
                        : DateFormat('dd MMM yyyy').format(_selectedDate!),
                    onTap: _pickDate,
                  ),
                ),
                width(12),
                Expanded(
                  child: _PickerTile(
                    icon: Icons.access_time_outlined,
                    label: 'Time',
                    value: _selectedTime == null
                        ? 'Select time'
                        : _selectedTime!.format(context),
                    onTap: _pickTime,
                  ),
                ),
              ],
            ),
            height(20),
            CustomTextField(
              label: 'Subject',
              controller: _subjectController,
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Subject is required'
                  : null,
            ),
            height(16),
            CustomTextField(
              controller: _descriptionController,
              maxLines: 4,
              label: 'Description',
            ),
            height(20),
            Text(
              'Attach Documents',
              style: customTextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
            height(10),
            OutlinedButton.icon(
              onPressed: _pickDocuments,
              icon: const Icon(Icons.attach_file),
              label: const Text('Add Files'),
            ),
            if (_pickedFiles.isNotEmpty) ...[
              height(10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(_pickedFiles.length, (i) {
                  final file = _pickedFiles[i];
                  return Chip(
                    label: Text(file.name, overflow: TextOverflow.ellipsis),
                    onDeleted: () => _removeFile(i),
                  );
                }),
              ),
            ],
            height(32),
            FilledButton(
              onPressed: _submit,
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: AppColors.newPri,
              ),
              child: Text('Book Appointment'),
            ),
          ],
        ),
      ),
    );
  }
}

class _PickerTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  const _PickerTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: theme.colorScheme.outlineVariant),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: theme.colorScheme.primary),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: theme.textTheme.labelSmall),
                  Text(value, style: theme.textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
