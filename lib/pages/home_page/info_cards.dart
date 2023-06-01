import 'package:car_pool_dashboard/constants/colors.dart';
import 'package:car_pool_dashboard/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class InfoCards extends StatelessWidget {
  final String title;
  final String value;
  final Color topColor;
  final bool isActive;
  final Function()? onTap;

  const InfoCards(
      {super.key,
      required this.title,
      required this.value,
      required this.topColor,
      this.isActive = false,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border:
                  Border.all(color: isActive ? active : lightGrey, width: .5)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: title,
                size: 24,
                weight: FontWeight.w300,
                color: isActive ? active : lightGrey,
              ),
              CustomText(
                text: title,
                size: 24,
                weight: FontWeight.w300,
                color: isActive ? active : lightGrey,
              )
            ],
          ),
        ),
      ),
    );
  }
}
