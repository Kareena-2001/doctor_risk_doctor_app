import 'package:Doctors_App/core/widgets/custom_app_bar.dart';
import 'package:Doctors_App/core/widgets/custom_date_picker.dart';
import 'package:Doctors_App/core/widgets/custom_dropdown_field.dart';
import 'package:Doctors_App/core/widgets/custom_text_field.dart';
import 'package:Doctors_App/core/widgets/section_card.dart';
import 'package:Doctors_App/features/profile/model/address_form_model.dart';
import 'package:Doctors_App/features/profile/model/address_view_model.dart';
import 'package:Doctors_App/features/profile/model/certificate_model.dart';
import 'package:Doctors_App/features/profile/model/doctor_profile_data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/responsive.dart';
import '../../../core/constants/dimensions.dart';
import '../../../extensions/build_context_extension.dart';
import '../../../theme/app_colors.dart';
import '../../common/ui/widgets/primary_button.dart';
import '../model/certificate_upload_field.dart';
import 'profile_view_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<AddressFormModel> addresses = [AddressFormModel()];

  final _prefixCtrl = TextEditingController(text: 'Dr.');
  final _firstNameCtrl = TextEditingController();
  final _middleNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();

  final _degreeCtrl = TextEditingController();

  final _emailCtrl = TextEditingController();
  final _mobileCtrl = TextEditingController();
  final _altMobileCtrl = TextEditingController();

  final _organisationCtrl = TextEditingController();
  final _specialityCtrl = TextEditingController();

  final _dobCtrl = TextEditingController();
  final _genderCtrl = TextEditingController();
  final _religionCtrl = TextEditingController();

  List<CertificateModel> _doctorCertificates = [];
  List<CertificateModel> _organisationCertificates = [];

  final categories = [
    'General Practitioner All Pathy',
    'Physician Consultant',
    'Dental Surgeon',
    'Plastic / Cosmetic',
  ];

  DateTime? _dob;

  @override
  void dispose() {
    for (final c in [
      _prefixCtrl,
      _firstNameCtrl,
      _middleNameCtrl,
      _lastNameCtrl,
      _degreeCtrl,
      _emailCtrl,
      _mobileCtrl,
      _altMobileCtrl,
      _organisationCtrl,
      _specialityCtrl,
      _dobCtrl,
      _genderCtrl,
      _religionCtrl,
    ]) {
      c.dispose();
    }
    for (final address in addresses) {
      address.dispose();
    }
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate() || _dob == null) {
      if (_dob == null) {
        context.showWarningSnackBar('Please select date of birth');
      }
      return;
    }

    if (_doctorCertificates.isEmpty) {
      context.showWarningSnackBar(
        'Please upload at least one doctor certificate',
      );
      return;
    }

    // TODO: build multipart request with _doctorCertificates / _organisationCertificates
    // (upload only entries where `file` is not null and `isUploaded` is false)
    // and call your profile update API here.
  }

  Future<void> _pickDob() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1990, 1, 1),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _dob = picked;
        _dobCtrl.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  void _openViewProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProfileViewScreen(
          data: _buildViewDataFromForm(),
          // policies: ref.read(polsicyRepositoryProvider).myPolicies,
        ),
      ),
    );
  }

  // Lets you preview exactly what's currently filled in, before saving.
  // Once you have a real "get profile" API, build DoctorProfileData from the
  // response instead of from these controllers.
  DoctorProfileData _buildViewDataFromForm() {
    return DoctorProfileData(
      prefix: _prefixCtrl.text,
      firstName: _firstNameCtrl.text,
      middleName: _middleNameCtrl.text,
      lastName: _lastNameCtrl.text,
      degree: _degreeCtrl.text,
      email: _emailCtrl.text,
      mobile: _mobileCtrl.text,
      alternateMobile: _altMobileCtrl.text,
      organisation: _organisationCtrl.text,
      speciality: _specialityCtrl.text,
      dob: _dob,
      gender: _genderCtrl.text,
      religion: _religionCtrl.text,
      addresses: addresses
          .map(
            (a) => AddressViewData(
              address1: a.address1.text,
              address2: a.address2.text,
              landmark: a.landmark.text,
              pinCode: a.pinCode.text,
              city: a.city.text,
              state: a.state.text,
            ),
          )
          .toList(),
      doctorCertificates: _doctorCertificates,
      organisationCertificates: _organisationCertificates,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Edit Profile',
        // actions: [
        //   IconButton(
        //     tooltip: 'View Profile',
        //     onPressed: _openViewProfile,
        //     icon: const Icon(Icons.remove_red_eye_outlined),
        //   ),
        // ],
        showView: true,
        onView: () {
          _openViewProfile();
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionCard(
                title: 'Personal   Address',
                icon: Icons.person,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: CustomTextField(
                          label: 'Prefix',
                          controller: _prefixCtrl,
                        ),
                      ),
                      width(10),
                      Expanded(
                        flex: 3,
                        child: CustomTextField(
                          label: 'First name',
                          controller: _firstNameCtrl,
                          hint: 'Enter First Name',
                          isRequired: true,
                        ),
                      ),
                    ],
                  ),
                  height(Responsive.h(10)),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          label: 'Middle name',
                          controller: _middleNameCtrl,
                          hint: 'Enter Middle Name',
                        ),
                      ),
                      width(10),
                      Expanded(
                        child: CustomTextField(
                          label: 'Last name',
                          controller: _lastNameCtrl,
                          isRequired: true,
                          hint: 'Enter Last Name',
                        ),
                      ),
                    ],
                  ),
                  height(10),
                  CustomTextField(
                    label: 'Email ID',
                    controller: _emailCtrl,
                    hint: 'Enter Email Id',
                    isRequired: true,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  height(10),
                  CustomTextField(
                    label: 'Mobile number',
                    hint: 'Enter Mobile No.',
                    controller: _mobileCtrl,
                    isRequired: true,
                    keyboardType: TextInputType.phone,
                  ),
                  height(10),
                  CustomTextField(
                    label: 'Alternate number',
                    hint: 'Enter Alternate No.',
                    controller: _altMobileCtrl,
                    keyboardType: TextInputType.phone,
                  ),
                  height(10),
                  CustomDropdownField(
                    label: 'Degree',
                    hint: 'Select Degree',
                    controller: _degreeCtrl,
                    isRequired: true,
                    items: ['MBBS'],
                  ),
                  height(10),
                  CustomDropdownField(
                    label: 'Category',
                    hint: 'Select Category',
                    items: categories,
                  ),
                  height(10),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          label: 'Organisation/Association',
                          hint: 'Enter Organisation',
                          controller: _organisationCtrl,
                        ),
                      ),
                      width(24),
                      Expanded(
                        child: CustomTextField(
                          label: 'Speciality',
                          hint: 'Enter Speciality',
                          controller: _specialityCtrl,
                        ),
                      ),
                    ],
                  ),
                  height(10),
                  Row(
                    children: [
                      Expanded(
                        child: CustomDatePicker(
                          label: 'Date of birth',
                          hint: 'Select DOB',
                          controller: _dobCtrl,
                          onTap: _pickDob,
                        ),
                      ),
                      width(10),
                      Expanded(
                        child: CustomDropdownField(
                          label: 'Gender',
                          hint: 'Select Gender',
                          controller: _genderCtrl,
                          items: const ['Male', 'Female'],
                        ),
                      ),
                    ],
                  ),
                  height(10),
                  CustomDropdownField(
                    label: 'Religion',
                    hint: 'Enter Religion',
                    controller: _religionCtrl,
                    items: ['Hindu','Muslim'],
                  ),
                ],
              ),
              height(10),
              SectionCard(
                title: 'Clinic/Hospital Addresses',
                icon: Icons.location_on,
                children: [
                  ...List.generate(addresses.length, (index) {
                    final item = addresses[index];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (addresses.length > 1)
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  item.dispose();
                                  addresses.removeAt(index);
                                });
                              },
                              icon: const Icon(Icons.delete, color: Colors.red),
                            ),
                          ),

                        CustomTextField(
                          label: 'Address Line 1',
                          hint: 'Enter Address Line 1',
                          controller: item.address1,
                          isRequired: true,
                        ),

                        height(10),

                        CustomTextField(
                          label: 'Address Line 2',
                          hint: 'Enter Address Line 2',
                          controller: item.address2,
                        ),

                        height(10),

                        CustomTextField(
                          label: 'Landmark',
                          hint: 'Enter Landmark',
                          controller: item.landmark,
                        ),

                        height(10),

                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                label: 'Pincode',
                                hint: 'Enter Pincode',
                                controller: item.pinCode,
                                keyboardType: TextInputType.number,
                                isRequired: true,
                              ),
                            ),
                            width(10),
                            Expanded(
                              child: CustomTextField(
                                label: 'City',
                                hint: 'Enter City',
                                controller: item.city,
                                isRequired: true,
                              ),
                            ),
                          ],
                        ),

                        height(10),

                        CustomTextField(
                          label: 'State',
                          hint: 'Enter State',
                          controller: item.state,
                          isRequired: true,
                        ),

                        const Divider(height: 30),
                      ],
                    );
                  }),

                  Center(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        setState(() {
                          addresses.add(AddressFormModel());
                        });
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Add Another Address'),
                    ),
                  ),
                ],
              ),
              height(10),
              SectionCard(
                title: 'Doctor Certificates',
                icon: Icons.badge_outlined,
                children: [
                  CertificateUploadField(
                    title: 'Doctor Certificate',
                    isRequired: true,
                    certificates: _doctorCertificates,
                    onChanged: (updated) {
                      setState(() => _doctorCertificates = updated);
                    },
                  ),
                ],
              ),
              height(10),
              SectionCard(
                title: 'Organisation Certification',
                icon: Icons.apartment_outlined,
                children: [
                  CertificateUploadField(
                    title: 'Organisation Certificate',
                    certificates: _organisationCertificates,
                    onChanged: (updated) {
                      setState(() => _organisationCertificates = updated);
                    },
                  ),
                ],
              ),
              height(20),
              PrimaryButton(
                height: 50,
                text: 'Update',
                backgroundColor: AppColors.newPri,
                onPressed: _submit,
              ),
              height(100),
            ],
          ),
        ),
      ),
    );
  }
}
