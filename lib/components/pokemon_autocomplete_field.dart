// lib/components/pokemon_autocomplete_field.dart
import 'package:flutter/material.dart';
import 'package:pokegame/themes/palette.dart';

class PokemonAutocompleteField extends StatelessWidget {
  final TextEditingController controller;
  final List<String> options; // lista de nombres en minúscula
  final String hint;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onSelected;

  const PokemonAutocompleteField({
    super.key,
    required this.controller,
    required this.options,
    this.hint = '',
    this.onFieldSubmitted,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        final input = textEditingValue.text.toLowerCase();
        if (input.isEmpty) return const Iterable<String>.empty();
        return options.where((opt) => opt.startsWith(input)).take(20);
      },
      displayStringForOption: (option) => option,
      onSelected: (selection) {
        controller.text = selection;
        if (onSelected != null) onSelected!(selection);
      },
      fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmittedLocal) {
        // mantenemos el controller que pasaron desde afuera para sincronizar
        return TextField(
          controller: controller,
          focusNode: focusNode,
          style: const TextStyle(color: AppColors.black, fontFamily: 'PixelifySans'),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: AppColors.neutralGray),
            filled: true,
            fillColor: AppColors.white,
            contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.neutralGray), borderRadius: BorderRadius.circular(8)),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.accentGreen, width: 2), borderRadius: BorderRadius.circular(8)),
          ),
          onSubmitted: onFieldSubmitted,
        );
      },
      optionsViewBuilder: (context, onSelectedOpt, optionsIterable) {
        final optionsList = optionsIterable.toList();
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            color: AppColors.white,
            elevation: 4.0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 48,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: optionsList.length,
                itemBuilder: (context, index) {
                  final opt = optionsList[index];
                  return ListTile(
                    title: Text(opt, style: const TextStyle(fontFamily: 'PixelifySans')),
                    onTap: () => onSelectedOpt(opt),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
