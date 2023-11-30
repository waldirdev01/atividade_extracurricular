import 'package:flutter/material.dart';

class CompanyCard extends StatelessWidget {
  final String companyName;
  final void Function()? onTap;
  const CompanyCard(
      {super.key, required this.companyName, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: const BoxDecoration(
            border: Border.fromBorderSide(
                BorderSide(color: Colors.black, width: 2)),
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          child: InkWell(
            onTap: onTap,
            child: Image.asset(
              'assets/images/bus.jpg',
              height: 200,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        Text(
          companyName,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
