import 'package:Doctors_App/features/appointment/ui/appointment_form_view.dart';
import 'package:Doctors_App/features/appointment/ui/appointment_list_view.dart';
import 'package:Doctors_App/features/authentication/ui/sign_up_screen.dart';
import 'package:Doctors_App/features/blog_central/ui/add_blog_screen.dart';
import 'package:Doctors_App/features/blog_central/ui/blog_details_screen.dart';
import 'package:Doctors_App/features/blog_central/ui/blog_screen.dart';
import 'package:Doctors_App/features/community/ui/community_screen.dart';
import 'package:Doctors_App/features/events/ui/event_register_screen.dart';
import 'package:Doctors_App/features/events/ui/events_screen.dart';
import 'package:Doctors_App/features/forgot_password/ui/forget_password_screen.dart';
import 'package:Doctors_App/features/forgot_password/ui/otp_screen.dart';
import 'package:Doctors_App/features/helpdesk/ui/support_hub_screen.dart';
import 'package:Doctors_App/features/legal/ui/add_legal_consultant_form.dart';
import 'package:Doctors_App/features/legal/ui/add_legal_notice_form.dart';
import 'package:Doctors_App/features/legal/ui/legal_consultant_view.dart';
import 'package:Doctors_App/features/legal/ui/legal_notice_view.dart';
import 'package:Doctors_App/features/news_advisiories/ui/news_advisory_details_screen.dart';
import 'package:Doctors_App/features/news_advisiories/ui/news_advisory_screen.dart';
import 'package:Doctors_App/features/product/model/product_tier.dart';
import 'package:Doctors_App/features/product/ui/widgets/my_plans_widgets.dart';
import 'package:Doctors_App/features/product/ui/widgets/plan_list_widgets.dart';
import 'package:Doctors_App/features/product/ui/product_view.dart';
import 'package:Doctors_App/features/faq/ui/faq_screen.dart';
import 'package:Doctors_App/features/profile/model/doctor_profile_data.dart';
import 'package:Doctors_App/features/profile/ui/contact_us.dart';
import 'package:Doctors_App/features/profile/ui/edit_profile_screen.dart';
import 'package:Doctors_App/features/profile/ui/profile_view_screen.dart';
import 'package:Doctors_App/features/profile/ui/terms_conditions_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/widgets/app_drawer.dart';
import '../features/admindocs/ui/admin_docs_screen.dart';
import '../features/authentication/ui/sign_in_screen.dart';
import '../features/forgot_password/ui/create_new_password.dart';
import '../features/helpdesk/ui/add_support_247_screen.dart';
import '../features/helpdesk/ui/my_queries_screen.dart';
import '../features/helpdesk/ui/widgets/query_details_screen.dart';
import '../features/home/ui/home_screen.dart';
import '../features/main/ui/main_screen.dart';
import '../features/notification/ui/notification_screen.dart';
import '../features/onboarding/ui/splash_screen.dart';
import '../features/product/model/product_model.dart';
import '../features/product/ui/my_plans_view.dart';
import '../features/product/ui/product_hub_view.dart';
import '../features/product/ui/purchase_wizard_screen.dart';
import '../features/profile/ui/about_us_screen.dart';
import '../features/profile/ui/languages_screen.dart';
import '../features/profile/ui/privacy_policy_screen.dart';
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
      path: Routes.register,
      pageBuilder: (context, state) => state.slidePage(const SignUpScreen()),
    ),
    GoRoute(
      path: Routes.main,
      pageBuilder: (context, state) => state.slidePage(const MainScreen()),
    ),

    GoRoute(
      path: Routes.planListScreen,
      pageBuilder: (context, state) => state.slidePage(const PlanListWidgets()),
    ),
    GoRoute(
      path: Routes.productList,
      pageBuilder: (context, state) => state.slidePage(const ProductView()),
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
        final args = state.extra as (Product, TierPlan, String, double, double);
        return PurchaseWizardScreen(
          product: args.$1,
          tier: args.$2,
          duration: args.$3,
          sumAssured: args.$4,
          premium: args.$5,
        );
      },
    ),
    GoRoute(
      path: Routes.myPlansScreen,
      pageBuilder: (context, state) => state.slidePage(const MyPlansWidgets()),
    ),

    GoRoute(
      path: Routes.languages,
      pageBuilder: (context, state) => state.slidePage(const LanguagesScreen()),
    ),

    GoRoute(
      path: Routes.homeScreen,
      pageBuilder: (context, state) => state.slidePage(HomeScreen()),
    ),
    GoRoute(
      path: Routes.aboutUs,
      pageBuilder: (context, state) {
        final comingFromHome = state.extra as bool? ?? false;

        return state.slidePage(AboutUsScreen(showBack: comingFromHome));
      },
    ),
    GoRoute(
      path: Routes.privacyPolicy,
      pageBuilder: (context, state) => state.slidePage(PrivacyPolicyScreen()),
    ),
    GoRoute(
      path: Routes.termsAndCondition,
      pageBuilder: (context, state) => state.slidePage(TermsConditionsScreen()),
    ),
    GoRoute(
      path: Routes.contactUs,
      pageBuilder: (context, state) => state.slidePage(ContactUsPage()),
    ),
    GoRoute(
      path: Routes.notification,
      pageBuilder: (context, state) => state.slidePage(NotificationScreen()),
    ),

    // GoRoute(
    //   path: Routes.overview,
    //   pageBuilder: (context, state) => state.slidePage(OverviewScreen()),
    // ),
    GoRoute(
      path: Routes.adminDocs,
      pageBuilder: (context, state) => state.slidePage(AdminDocsScreen()),
    ),
    // GoRoute(
    //   path: Routes.helpSupport,
    //   pageBuilder: (context, state) => state.slidePage(HelpScreen()),
    // ),
    GoRoute(
      path: Routes.addSupport,
      pageBuilder: (context, state) => state.slidePage(AddSupport247Screen()),
    ),
    GoRoute(
      path: Routes.supportHub,
      pageBuilder: (context, state) => state.slidePage(SupportHubScreen()),
    ),

    GoRoute(
      path: Routes.myQueries,
      pageBuilder: (context, state) => state.slidePage(MyQueriesScreen()),
    ),
    GoRoute(
      path: Routes.faqScreen,
      pageBuilder: (context, state) => state.slidePage(FaqScreen()),
    ),
    GoRoute(
      path: Routes.queryDetails,
      pageBuilder: (context, state) {
        final queryId = state.extra as String;
        return state.slidePage(QueryDetailsScreen(queryId: queryId));
      },
    ),
    // GoRoute(
    //   path: Routes.liveChat,
    //   pageBuilder: (context, state) => state.slidePage(ChatView()),
    // ),
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
      path: Routes.newsAdvisoryDetails,
      pageBuilder: (context, state) =>
          state.slidePage(const NewsAdvisoryDetailsScreen()),
    ),
    GoRoute(
      path: Routes.blogCentral,
      pageBuilder: (context, state) => state.slidePage(const BlogScreen()),
    ),
    GoRoute(
      path: Routes.blogCentralDetails,
      pageBuilder: (context, state) =>
          state.slidePage(const BlogDetailsScreen()),
    ),
    GoRoute(
      path: Routes.eventsScreen,
      pageBuilder: (context, state) => state.slidePage(const EventsScreen()),
    ),    GoRoute(
      path: Routes.eventRegister,
      pageBuilder: (context, state) => state.slidePage(const EventRegisterScreen(event: {},)),
    ),
    GoRoute(
      path: Routes.communityScreen,
      pageBuilder: (context, state) => state.slidePage(const CommunityScreen()),
    ),
    GoRoute(
      path: Routes.addBlog,
      pageBuilder: (context, state) => state.slidePage(const AddBlogScreen()),
    ),
    GoRoute(
      path: Routes.editProfile,
      pageBuilder: (context, state) =>
          state.slidePage(const EditProfileScreen()),
    ),
    GoRoute(
      path: Routes.profileView,
      pageBuilder: (context, state) => state.slidePage(
        const ProfileViewScreen(
          data: DoctorProfileData(
            prefix: 'Dr',
            firstName: 'Arun',
            lastName: 'Mishra',
            degree: 'MBBS',
            email: 'arun@gmail.com',
            mobile: '9326481596',
          ),
        ),
      ),
    ),
    GoRoute(
      path: Routes.addAppointment,
      pageBuilder: (context, state) =>
          state.slidePage(const AppointmentFormView()),
    ),
    GoRoute(
      path: Routes.viewAppointment,
      pageBuilder: (context, state) =>
          state.slidePage(const AppointmentListView()),
    ),

    GoRoute(
      path: Routes.legalConsultant,
      pageBuilder: (context, state) =>
          state.slidePage(const LegalConsultantView()),
    ),
    GoRoute(
      path: Routes.legalNotice,
      pageBuilder: (context, state) => state.slidePage(const LegalNoticeView()),
    ),
    GoRoute(
      path: Routes.addLegalConsultant,
      pageBuilder: (context, state) =>
          state.slidePage(const AddLegalConsultantForm()),
    ),
    GoRoute(
      path: Routes.addLegalNotice,
      pageBuilder: (context, state) =>
          state.slidePage(const AddLegalNoticeForm()),
    ),
  ],
);
