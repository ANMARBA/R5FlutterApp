import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  const EmailField({
    this.emailController,
    super.key,
  });

  final TextEditingController? emailController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailController,
      decoration: const InputDecoration(
        labelText: 'Correo electrónico',
        prefixIcon: Icon(Icons.person, color: Colors.blue),
      ),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Este campo es requerido';
        } else if (!RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
            .hasMatch(value)) {
          return 'Ingrese un correo electrónico válido';
        }
        return null;
      },
    );
  }
}
