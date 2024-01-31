import 'package:flutter/material.dart';

Widget kDropDown({
  String? dropdownvalue,
  bool? isExpanded,
  String? label,
  bool? isRequired,
  required List<DropdownMenuItem<String>>? items,
  required void Function(String?)? onChanged,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10)),
    child: DropdownButton(
      isExpanded: isExpanded ?? false,
      borderRadius: BorderRadius.circular(8),
      value: dropdownvalue,
      underline: const SizedBox(),
      icon: const Icon(Icons.arrow_drop_down),
      items: items,
      iconSize: 30,
      onChanged: onChanged,
    ),
  );
}
