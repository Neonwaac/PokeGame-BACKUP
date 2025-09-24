import 'package:flutter/material.dart';
import 'package:pokegame/themes/palette.dart';

class PokemonAutocompleteField extends StatelessWidget {
  final TextEditingController controller;
  final List<String> options;
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
        return TextField(
          controller: controller,
          focusNode: focusNode,
          style: const TextStyle(
            color: AppColors.black,
            fontFamily: 'PixelifySans',
            fontSize: 16,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: AppColors.neutralGray),
            filled: true,
            fillColor: AppColors.white,
            contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.neutralGray, width: 1.5),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.accentGreen, width: 2.5),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onSubmitted: onFieldSubmitted,
        );
      },
      optionsViewBuilder: (context, onSelectedOpt, optionsIterable) {
        final optionsList = optionsIterable.toList();
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            color: Colors.transparent,
            child: Container(
              margin: const EdgeInsets.only(top: 4),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryPurple.withOpacity(0.3),
                    offset: const Offset(2, 2),
                    blurRadius: 6,
                  )
                ],
              ),
              width: MediaQuery.of(context).size.width - 48,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: optionsList.length,
                itemBuilder: (context, index) {
                  final opt = optionsList[index];
                  return ListTile(
                    title: Text(
                      opt,
                      style: const TextStyle(
                        fontFamily: 'PixelifySans',
                        fontSize: 16,
                        color: AppColors.primaryPurple,
                      ),
                    ),
                    hoverColor: AppColors.accentGreen.withOpacity(0.2),
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

