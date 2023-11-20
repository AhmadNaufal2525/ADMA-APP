import 'package:flutter/material.dart';

class FormAsetButtonWidget extends StatelessWidget {
  final String icon;
  final Color backgroundColor;
  final String label;
  final VoidCallback onTap;
  const FormAsetButtonWidget({super.key, required this.icon, required this.backgroundColor, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
  onTap: () {
    onTap();
  },
  child: Container(
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      color: backgroundColor,
      boxShadow: const [
        BoxShadow(
          color: Colors.grey,
          offset: Offset(0, 2),
          blurRadius: 4,
        ),
      ],
    ),
    height: 100,
    width: 160,
    child: Stack(
      children: [
        Positioned(
          top: 10,
          left: 12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              color: Colors.white,
            ),
            child: Image.asset(
              icon,
              width: 30,
              height: 30,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9),
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.start,
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