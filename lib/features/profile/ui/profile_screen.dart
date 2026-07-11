import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/languages.dart';
import '../../../core/constants/values/app_constants.dart';
import '../../authentication/ui/view_model/authentication_view_model.dart';
import '../../authentication/ui/view_model/user_data_provider.dart';
import '../../common/ui/widgets/loading.dart';
import '../../delete_account/ui/viewmodel/delete_view_model.dart';
import '../../home/ui/view_model/home_view_model.dart';
import '/extensions/build_context_extension.dart';
import '/routing/routes.dart';
import '/theme/app_colors.dart';
import '/theme/app_theme.dart';
import '/utils/global_loading.dart';
import '../../../../features/common/ui/widgets/common_dialog.dart';
import 'widgets/avatar.dart';
import 'widgets/profile_item.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  var _version = '';

  @override
  void initState() {
    super.initState();
    _getPackageInfo();
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(homeViewModelProvider);
    final dangerousColor = context.isDarkMode
        ? AppColors.rambutan80
        : AppColors.rambutan100;
    return Scaffold(
      backgroundColor: context.secondaryBackgroundColor,
      body: ListView(
        padding: EdgeInsets.fromLTRB(
          16,
          MediaQuery.paddingOf(context).top + 48,
          16,
          48,
        ),
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: context.secondaryWidgetColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Transform.translate(
                  offset: Offset(0, -48),
                  child: Column(
                    children: [
                      profileAsync.when(
                        data: (profileResponse) {
                          final userData = profileResponse?.data;
                          final name = userData?.fullName ?? 'Guest User';
                          final photo = userData?.photo;
                          final vendorCode = userData?.vendorEmployeeCode;
                          return Column(
                            children: [
                              Avatar(url: photo),
                              height(12),
                              Center(
                                child: Text(name, style: AppTheme.title24),
                              ),
                              if ((vendorCode ?? '').trim().isNotEmpty) ...[
                                height(12),

                                Center(
                                  child: Text(
                                    vendorCode!,
                                    style: AppTheme.body14.copyWith(
                                      color: context.secondaryTextColor,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          );
                        },
                        loading: () => Column(
                          children: [
                            const Loading(),
                            height(12),
                            const Text('Loading...'),
                          ],
                        ),
                        error: (_, __) => Column(
                          children: [
                            const Avatar(),
                            height(12),
                            const Text('Guest User'),
                            height(12),
                            const Text('guest@email.com'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          height(8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(Languages.general, style: AppTheme.title20),
          ),
          height(8),
          ProfileItem(
            icon: HugeIcons.strokeRoundedIdea,
            text: Languages.appearances,
            onTap: () {
              context.push(Routes.appearances);
            },
            isFirst: true,
            isLast: true,
          ),
          // ProfileItem(
          //   icon: HugeIcons.strokeRoundedCoinsSwap,
          //   text: Languages.language,
          //   isLast: true,
          //   onTap: () {
          //     context.push(Routes.languages);
          //   },
          // ),
          height(24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(Languages.preferences, style: AppTheme.title20),
          ),
          height(8),
          ProfileItem(
            icon: HugeIcons.strokeRoundedNews,
            text: Languages.termAndCondition,
            isFirst: true,
            onTap: () {
              context.push(Routes.termsAndCondition);
            },
          ),
          ProfileItem(
            icon: HugeIcons.strokeRoundedShield01,
            text: Languages.privacyPolicy,
            onTap: () {
              context.push(Routes.privacyPolicy);
            },
          ),
          ProfileItem(
            icon: HugeIcons.strokeRoundedUserMultiple,
            text: Languages.aboutUs,
            onTap: () {
              context.push(Routes.aboutUs, extra: true);
            },
            // isLast: true,
          ),
          ProfileItem(
            icon: HugeIcons.strokeRoundedStar,
            text: Languages.rateUs,
            onTap: () => context.tryLaunchUrl(
              Platform.isIOS ? AppConstants.appStore : AppConstants.playStore,
            ),
            isLast: true,
          ),
          height(24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(Languages.dangerousZone, style: AppTheme.title20),
          ),
          height(8),
          ProfileItem(
            icon: HugeIcons.strokeRoundedLogout01,
            text: Languages.logOut,
            textColor: dangerousColor,
            isFirst: true,
            onTap: () => _signOut(context),
          ),
          ProfileItem(
            icon: HugeIcons.strokeRoundedDelete01,
            text: Languages.deleteAccount,
            textColor: dangerousColor,
            isLast: true,
            onTap: () => _deleteAccount(context),
          ),
          height(24),
          Center(child: Text('Version $_version', style: AppTheme.body12)),
        ],
      ),
    );
  }

  void _getPackageInfo() {
    PackageInfo.fromPlatform()
        .then((info) {
          setState(() {
            _version = info.version;
          });
        })
        .catchError((error) {
          debugPrint(
            '${AppConstants.tag} [_ProfileScreenState._getPackageInfo] Error: $error',
          );
        });
  }

  void _signOut(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => CommonDialog(
        title: Languages.logOutTitle,
        content: Languages.logOutMessage,
        primaryButtonLabel: Languages.logOut,
        primaryButtonBackground: AppColors.rambutan100,
        secondaryButtonLabel: Languages.cancel,
        autoDismiss: false,
        primaryButtonAction: () async {
          if (Navigator.of(dialogContext).canPop()) {
            Navigator.of(dialogContext).pop();
          }
          // ref
          //     .read(employeeOnboardingViewModelProvider.notifier)
          //     .clearAllOnboardingData();

          await Future.delayed(const Duration(milliseconds: 100));

          if (!context.mounted) return;

          Global.showLoading(context);

          try {
            final authNotifier = ref.read(
              authenticationViewModelProvider.notifier,
            );

            await authNotifier.signOut();

            ref.invalidate(userDataProvider);
            // ref.invalidate(profileViewModelProvider);

            if (context.mounted) {
              Global.hideLoading();

              context.go(Routes.login);
            }
          } catch (error, stackTrace) {
            debugPrint('SIGN OUT ERROR: $error');
            debugPrintStack(stackTrace: stackTrace);

            if (context.mounted) {
              Global.hideLoading();
              // context.showErrorSnackBar(
              //   error is AuthException
              //       ? error.message
              //       : error.toString().replaceAll('Exception: ', ''),
              // );
            }
          }
        },
        secondaryButtonAction: () {
          if (Navigator.of(dialogContext).canPop()) {
            Navigator.of(dialogContext).pop();
          }
        },
      ),
    );
  }

  void _deleteAccount(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => CommonDialog(
        title: Languages.deleteAccountTitle,
        content: Languages.deleteAccountMessage,
        primaryButtonLabel: Languages.deleteAccount,
        primaryButtonBackground: AppColors.rambutan100,
        secondaryButtonLabel: Languages.cancel,
        autoDismiss: false,
        primaryButtonAction: () async {
          if (Navigator.of(dialogContext).canPop()) {
            Navigator.of(dialogContext).pop();
          }

          await Future.delayed(const Duration(milliseconds: 100));
          if (!context.mounted) return;
          Global.showLoading(context);

          try {
            final deleteNotifier = ref.read(deleteViewModelProvider.notifier);
            final response = await deleteNotifier.deleteAccount();

            if (!context.mounted) return;

            Global.hideLoading();

            context.go(Routes.login, extra: response.msg);
          } catch (error) {
            debugPrint(' DELETE ACCOUNT ERROR: $error');
            if (context.mounted) {
              Global.hideLoading();
              context.showErrorSnackBar(Languages.unexpectedErrorOccurred);
            }
          }
        },
        secondaryButtonAction: () {
          if (Navigator.of(dialogContext).canPop()) {
            Navigator.of(dialogContext).pop();
          }
        },
      ),
    );
  }
}
