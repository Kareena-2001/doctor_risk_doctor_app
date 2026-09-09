import 'package:Doctors_App/features/authentication/model/login/login_response.dart';
import 'package:Doctors_App/features/authentication/model/register/category_response.dart';
import 'package:Doctors_App/features/authentication/model/register/degree_response.dart';
import 'package:Doctors_App/features/authentication/model/register/sign_up_response.dart';
import 'package:Doctors_App/features/authentication/model/register/speciality_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'authentication_state.freezed.dart';


@freezed
class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState({
    LoginResponse? response,
    SignUpResponse? signUpResponse,

    @Default(AsyncLoading<CategoryResponse>())
    AsyncValue<CategoryResponse> categoryAsync,

    @Default(AsyncData<SpecialityResponse?>(null))
    AsyncValue<SpecialityResponse?> specialityAsync,

    @Default(AsyncLoading<DegreeResponse>())
    AsyncValue<DegreeResponse> degreeAsync,
  }) = _AuthenticationState;
}