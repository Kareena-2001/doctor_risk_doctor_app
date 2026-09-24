import 'package:Doctors_App/features/document_vault/model/company_document_response.dart';
import 'package:Doctors_App/features/document_vault/model/doctor_document_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'document_vault_state.freezed.dart';

@freezed
class DocumentVaultState with _$DocumentVaultState {
  const factory DocumentVaultState({
    @Default(true) bool isUploadedLoading,
    @Default(<DoctorDocument>[]) List<DoctorDocument> uploadedDocs,
    String? uploadedError,

    @Default(true) bool isCompanyLoading,
    @Default(<CompanyDocument>[]) List<CompanyDocument> companyDocs,
    String? companyError,

    String? uploadingDocName,
  }) = _DocumentVaultState;
}
