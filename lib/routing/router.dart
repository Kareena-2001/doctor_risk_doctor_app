import 'package:Doctors_App/features/appointment/ui/appointment_list_view.dart';
import 'package:Doctors_App/features/authentication/ui/sign_up_screen.dart';
import 'package:Doctors_App/features/blog_central/ui/add_blog_screen.dart';
import 'package:Doctors_App/features/blog_central/ui/blog_details_screen.dart';
import 'package:Doctors_App/features/blog_central/ui/blog_screen.dart';
import 'package:Doctors_App/features/blog_central/ui/my_blogs_tab.dart';
import 'package:Doctors_App/features/change_password/ui/change_password_screen.dart';
import 'package:Doctors_App/features/community/ui/community_screen.dart';
import 'package:Doctors_App/features/community/ui/widgets/referral_list_screen.dart';
import 'package:Doctors_App/features/document_vault/ui/document_vault_screen.dart';
import 'package:Doctors_App/features/emergency/ui/emergency_assistance_screen.dart';
import 'package:Doctors_App/features/events/model/event_list_response.dart';
import 'package:Doctors_App/features/events/ui/event_collaborate_form.dart';
import 'package:Doctors_App/features/events/ui/event_register_screen.dart';
import 'package:Doctors_App/features/events/ui/events_screen.dart';
import 'package:Doctors_App/features/events/ui/widget/event_payment_screen.dart';
import 'package:Doctors_App/features/medical_law_faq/ui/medico_legal_faq_screen.dart';
import 'package:Doctors_App/features/forgot_password/ui/forget_password_screen.dart';
import 'package:Doctors_App/features/forgot_password/ui/otp_screen.dart';
import 'package:Doctors_App/features/news_advisiories/ui/news_advisory_screen.dart';
import 'package:Doctors_App/features/onboarding/ui/onboarding_view.dart';
import 'package:Doctors_App/features/product/model/product_tier.dart';
import 'package:Doctors_App/features/product/ui/product_view.dart';
import 'package:Doctors_App/features/faq/ui/faq_screen.dart';
import 'package:Doctors_App/features/renewal_centre/ui/renewal_centre_screen.dart';
import 'package:Doctors_App/features/rewards/ui/rewards_screen.dart';
import 'package:Doctors_App/features/scan/ui/scan_screen.dart';
import 'package:Doctors_App/features/support_hub/ui/add_legal_ticket_screen.dart';
import 'package:Doctors_App/features/support_hub/ui/add_service_ticket_screen.dart';
import 'package:Doctors_App/features/support_hub/ui/legal_support_screen.dart';
import 'package:Doctors_App/features/support_hub/ui/service_support_screen.dart';
import 'package:Doctors_App/features/support_hub/ui/support_hub_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/widgets/app_drawer.dart';
import '../features/authentication/ui/sign_in_screen.dart';
import '../features/blog_central/model/my_submission_list_model.dart';
import '../features/forgot_password/ui/create_new_password.dart';
import '../features/home/ui/home_screen.dart';
import '../features/main/ui/main_screen.dart';
import '../features/notification/ui/notification_screen.dart';
import '../features/onboarding/ui/splash_screen.dart';
import '../features/product/model/product_model.dart';
import '../features/product/ui/my_plans_view.dart';
import '../features/product/ui/plan_category_view.dart';
import '../features/product/ui/plan_finder_view.dart';
import '../features/product/ui/product_hub_view.dart';
import '../features/product/ui/purchase_wizard_screen.dart';
import '../features/product/ui/source_details_view.dart';
import 'routes.dart';

enum SlideDirection { right, left, up, down }

extension GoRouterStateExtension on GoRouterState {
  SlideRouteTransition slidePage(
    Widget child, {
    SlideDirection direction = SlideDirection.left,
  }) {
    return SlideRouteTransition(
      key: pageKey,
      child: child,
      direction: direction,
    );
  }
}

class SlideRouteTransition extends CustomTransitionPage<void> {
  SlideRouteTransition({
    required super.key,
    required super.child,
    SlideDirection direction = SlideDirection.left,
  }) : super(
         transitionsBuilder: (context, animation, secondaryAnimation, child) {
           final curve = CurvedAnimation(
             parent: animation,
             curve: Curves.easeInOut,
           );

           Offset begin;
           switch (direction) {
             case SlideDirection.right:
               begin = const Offset(-1.0, 0.0);
               break;
             case SlideDirection.left:
               begin = const Offset(1.0, 0.0);
               break;
             case SlideDirection.up:
               begin = const Offset(0.0, 1.0);
               break;
             case SlideDirection.down:
               begin = const Offset(0.0, -1.0);
               break;
           }
           final tween = Tween(begin: begin, end: Offset.zero);
           final offsetAnimation = tween.animate(curve);

           return SlideTransition(position: offsetAnimation, child: child);
         },
       );
}

final GoRouter router = GoRouter(
  initialLocation: Routes.splash,
  routes: [
    GoRoute(
      path: Routes.splash,
      pageBuilder: (context, state) => state.slidePage(const SplashScreen()),
    ),
    GoRoute(
      path: Routes.login,
      pageBuilder: (context, state) => state.slidePage(const SignInScreen()),
    ),
    GoRoute(
      path: Routes.appDrawer,
      pageBuilder: (context, state) => state.slidePage(const AppDrawer()),
    ),
    GoRoute(
      path: Routes.onboarding,
      pageBuilder: (context, state) => state.slidePage(const OnboardingView()),
    ),
    GoRoute(
      path: Routes.register,
      pageBuilder: (context, state) => state.slidePage(const SignUpScreen()),
    ),
    GoRoute(
      path: Routes.main,
      pageBuilder: (context, state) => state.slidePage(const MainScreen()),
    ),
    GoRoute(
      path: Routes.productSource,
      builder: (context, state) => const SourceDetailsView(),
    ),
    GoRoute(
      path: Routes.planCategory,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>? ?? {};
        return PlanCategoryView(
          orgName: extra['orgName'],
          staffCode: extra['staffCode'],
        );
      },
    ),
    GoRoute(
      path: Routes.planFinder,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>? ?? {};
        return PlanFinderView(
          orgName: extra['orgName'],
          staffCode: extra['staffCode'],
          category: extra['category'] as ProductType,
        );
      },
    ),
    GoRoute(
      path: Routes.documentVault,
      pageBuilder: (context, state) => state.slidePage(DocumentVaultScreen()),
    ),
    GoRoute(
      path: Routes.emergency,
      pageBuilder: (context, state) =>
          state.slidePage(EmergencyAssistanceScreen()),
    ),
    GoRoute(
      path: Routes.rewards,
      pageBuilder: (context, state) => state.slidePage(RewardsScreen()),
    ),
    GoRoute(
      path: Routes.productList,
      pageBuilder: (context, state) => state.slidePage(ProductView()),
    ),
    GoRoute(
      path: Routes.productHub,
      builder: (context, state) => const ProductHubView(),
    ),
    GoRoute(
      path: Routes.productList,
      builder: (context, state) => const ProductView(),
    ),
    GoRoute(
      path: Routes.myPlans,
      builder: (context, state) => const MyPlansView(),
    ),
    GoRoute(
      path: Routes.purchaseWizard,
      builder: (context, state) {
        final extra = state.extra;
        if (extra is! (Product, TierPlan, String, double, double)) {
          debugPrint(
            'purchaseWizard route reached without valid extra args '
            '(got: ${extra.runtimeType}). Check the caller is passing '
            'extra: (product, tier, duration, sumAssured, premium).',
          );
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted && context.canPop()) {
              context.pop();
            } else if (context.mounted) {
              context.go(Routes.productList);
            }
          });
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return PurchaseWizardScreen(
          product: extra.$1,
          tier: extra.$2,
          duration: extra.$3,
          sumAssured: extra.$4,
          premium: extra.$5,
        );
      },
    ),
    GoRoute(
      path: Routes.homeScreen,
      pageBuilder: (context, state) => state.slidePage(HomeScreen()),
    ),
    GoRoute(
      path: Routes.addCollaboration,
      pageBuilder: (context, state) =>
          state.slidePage(EventCollaborateScreen()),
    ),

    GoRoute(
      path: Routes.supportHub,
      pageBuilder: (context, state) => state.slidePage(SupportHubScreen()),
    ),
    GoRoute(
      path: Routes.legalSupport,
      pageBuilder: (context, state) => state.slidePage(LegalSupportScreen()),
    ),
    GoRoute(
      path: Routes.serviceSupport,
      pageBuilder: (context, state) => state.slidePage(ServiceSupportScreen()),
    ),
    GoRoute(
      path: Routes.addLegalSupport,
      pageBuilder: (context, state) => state.slidePage(AddLegalTicketScreen()),
    ),
    GoRoute(
      path: Routes.addServiceSupport,
      pageBuilder: (context, state) =>
          state.slidePage(AddServiceTicketScreen()),
    ),

    GoRoute(
      path: Routes.faqScreen,
      pageBuilder: (context, state) => state.slidePage(FaqScreen()),
    ),
    GoRoute(
      path: Routes.medicoLawFaq,
      pageBuilder: (context, state) => state.slidePage(MedicoLegalFaqScreen()),
    ),
    GoRoute(
      path: Routes.renewCentre,
      pageBuilder: (context, state) => state.slidePage(RenewalCentreScreen()),
    ),

    GoRoute(
      path: Routes.notification,
      pageBuilder: (context, state) => state.slidePage(NotificationScreen()),
    ),

    GoRoute(
      path: Routes.forgotPassword,
      pageBuilder: (context, state) =>
          state.slidePage(const ForgetPasswordScreen()),
    ),
    GoRoute(
      path: Routes.otpVerification,
      pageBuilder: (context, state) {
        final email = state.extra as String;

        return state.slidePage(OtpScreen(email: email));
      },
    ),
    GoRoute(
      path: Routes.createNewPassword,
      pageBuilder: (context, state) {
        final id = state.extra as String? ?? '';
        return state.slidePage(CreateNewPassword(id: id));
      },
    ),

    GoRoute(
      path: Routes.newsAdvisory,
      pageBuilder: (context, state) =>
          state.slidePage(const NewsAdvisoryScreen()),
    ),
    GoRoute(
      path: Routes.blogCentral,
      pageBuilder: (context, state) => state.slidePage(const BlogScreen()),
    ),
    GoRoute(
      path: Routes.blogCentralDetails,
      pageBuilder: (context, state) {
        final blogId = state.extra as String;

        return state.slidePage(BlogDetailsScreen(blogId: blogId));
      },
    ),
    GoRoute(
      path: Routes.eventsScreen,
      pageBuilder: (context, state) => state.slidePage(const EventsScreen()),
    ),
    GoRoute(
      path: Routes.referList,
      pageBuilder: (context, state) =>
          state.slidePage(const ReferralListScreen()),
    ),
    GoRoute(
      path: Routes.eventRegister,
      pageBuilder: (context, state) => state.slidePage(
        EventRegisterScreen(event: state.extra as EventModel),
      ),
    ),
    GoRoute(
      path: Routes.communityScreen,
      pageBuilder: (context, state) => state.slidePage(const CommunityScreen()),
    ),
    GoRoute(
      path: Routes.mySubmission,
      pageBuilder: (context, state) => state.slidePage(MyBlogsTab()),
    ),
    GoRoute(
      path: Routes.addBlog,
      builder: (context, state) {
        final blogToEdit = state.extra as SubmissionModel?;
        return AddBlogScreen(
          key: ValueKey(blogToEdit?.id ?? 'new'),
          blogToEdit: blogToEdit,
        );
      },
    ),
    GoRoute(
      path: Routes.purchaseWizard,
      builder: (context, state) {
        final extra = state.extra;
        if (extra is! (Product, TierPlan, String, double, double)) {
          debugPrint(
            'purchaseWizard route reached without valid extra args '
            '(got: ${extra.runtimeType}). Check the caller is passing '
            'extra: (product, tier, duration, sumAssured, premium).',
          );
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted && context.canPop()) {
              context.pop();
            } else if (context.mounted) {
              context.go(Routes.productList);
            }
          });
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return PurchaseWizardScreen(
          product: extra.$1,
          tier: extra.$2,
          // Matches TierPlan
          duration: extra.$3,
          sumAssured: extra.$4,
          premium: extra.$5,
        );
      },
    ),
    GoRoute(
      path: Routes.viewAppointment,
      pageBuilder: (context, state) =>
          state.slidePage(const AppointmentListView()),
    ),

    GoRoute(
      path: Routes.scanScreen,
      pageBuilder: (context, state) => state.slidePage(const ScanScreen()),
    ),
    GoRoute(
      path: Routes.changePassword,
      pageBuilder: (context, state) =>
          state.slidePage(const ChangePasswordScreen()),
    ),
    GoRoute(
      path: Routes.payment,
      pageBuilder: (context, state) {
        return state.slidePage(PaymentScreen(eventRegistrationId: ''));
      },
    ),
  ],
);
