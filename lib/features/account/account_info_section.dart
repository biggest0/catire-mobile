import 'package:flutter/material.dart';

import '../shared/section_header.dart';

/// Section widget that displays editable account information fields.
class AccountInfoSection extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController bioController;
  final VoidCallback onSave;

  const AccountInfoSection({
    super.key,
    required this.nameController,
    required this.bioController,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: "ACCOUNT INFO"),
        const SizedBox(height: 12),
        _AccountTextField(
          controller: nameController,
          labelText: "Name",
          onSave: onSave,
        ),
        const SizedBox(height: 12),
        _AccountTextField(
          controller: bioController,
          labelText: "Bio",
          onSave: onSave,
        ),
      ],
    );
  }
}

/// Reusable text field widget.
class _AccountTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final VoidCallback onSave;

  const _AccountTextField({
    required this.controller,
    required this.labelText,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: const UnderlineInputBorder(),
        suffixIcon: IconButton(
          icon: const Icon(Icons.check),
          onPressed: onSave,
        ),
      ),
    );
  }
}
