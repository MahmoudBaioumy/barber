import 'package:flutter/material.dart';
import 'package:flutter_application_barber/core/utils/size_config.dart';

class widthspace extends StatelessWidget {
  const widthspace(this.value, {super.key});
  final double? value;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.defaultSize! * value!,
    );
  }
}

class heigthspace extends StatelessWidget {
  const heigthspace(this.value, {super.key});
  final double? value;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.defaultSize! * value!,
    );
  }
}
