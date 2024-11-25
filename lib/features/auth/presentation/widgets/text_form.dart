import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final String label;
 
  final Widget? suff;
  final Widget? pre;
  final int? maxLength;
  final bool scure;
  final String? Function(String?)? valid;
  final Key? keys;
  final Color colors;
  final TextEditingController? controller;

  const CustomTextForm({
    super.key,
    required this.label,
    this.suff,
    this.pre,
    this.maxLength,
    required this.scure,
    this.valid,
    this.keys,
    this.controller,
    required this.colors,
   
  });

  @override
  Widget build(BuildContext context) {
    return Form(
        key: keys,
        child: TextFormField(
          controller: controller,
          validator: valid,
          maxLength: maxLength,
          obscureText: scure,
          decoration: InputDecoration(
              label: Text(label),
              
              suffixIcon: suff,
              prefix: pre,
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.green),
                borderRadius: BorderRadius.circular(50),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colors),
                borderRadius: BorderRadius.circular(50),
              )),
        ));
  }
}
