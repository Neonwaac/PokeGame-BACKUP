import 'package:flutter/material.dart';

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
    final colors = Theme.of(context).colorScheme;

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
      fieldViewBuilder: (context, textEditingController, focusNode, _) {
        return TextField(
          controller: controller,
          focusNode: focusNode,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: colors.onSurface,
                fontFamily: 'PixelifySans',
              ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: colors.onSurface,
              fontFamily: 'PixelifySans',
            ),
            filled: true,
            fillColor: colors.surface,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colors.outline, width: 1.5),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colors.secondary, width: 2.5),
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
            color: colors.surface,
            elevation: 6,
            borderRadius: BorderRadius.circular(12),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 250),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: optionsList.length,
                itemBuilder: (context, index) {
                  final opt = optionsList[index];
                  return ListTile(
                    title: Text(
                      opt,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontFamily: 'PixelifySans',
                            color: colors.primary,
                          ),
                    ),
                    hoverColor: colors.secondary,
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


