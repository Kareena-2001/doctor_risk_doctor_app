import 'package:flutter/material.dart';
import '../../../core/constants/dimensions.dart';
import '../../../core/constants/values/app_text_style.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../extensions/build_context_extension.dart';
import '../../../theme/app_colors.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Contact Us'),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 30.0,
          bottom: 14,
          left: 14,
          right: 14,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                "assets/images/contact_us.png",
                width: 290,
                height: 173,
              ),
            ),
            height(26),
            Text(
              "How can we help you?",
              style: customTextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: context.secondaryTextColor,
              ),
              textAlign: TextAlign.center,
            ),
            height(15),
            const Divider(),
            height(26),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      // color: AppColors.grey,
                      color: context.dividerColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(Icons.call_outlined, color: AppColors.grey),
                    ),
                  ),
                  width(40),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Call Us",
                        style: customTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.accent,
                        ),
                      ),
                      height(5),
                      Text(
                        "+91 8485849930",
                        style: customTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: context.secondaryTextColor,
                        ),
                      ),
                      height(3),
                      Text(
                        "+91 8485849940",
                        style: customTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: context.secondaryTextColor,
                        ),
                      ),
                      height(3),
                      Text(
                        "(Mon to Fri 9am to 6 pm)",
                        style: customTextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff376838),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            height(15),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: context.dividerColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.mail_outline,
                        color: AppColors.greenAccent,
                      ),
                    ),
                  ),
                  width(40),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Email Us",
                        style: customTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.accent,
                        ),
                      ),
                      height(5),
                      Text(
                        "info@farmtofamily.net.in",
                        style: customTextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: context.secondaryTextColor,
                        ),
                      ),
                      height(3),
                      Text(
                        "Send us your query anytime!",
                        style: customTextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff376838),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            height(15),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: context.dividerColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.location_on_outlined,
                        color: AppColors.greenAccent,
                      ),
                    ),
                  ),
                  width(40),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Office Address",
                          style: customTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.accent,
                          ),
                        ),
                        height(5),
                        Text(
                          "Shop No 7, Mohan Areca D-Wing, \nShirgaon, Badlapur (East) - 421 503 ",
                          style: customTextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: context.secondaryTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
