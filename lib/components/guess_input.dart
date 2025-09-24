import 'package:flutter/material.dart';
import '../models/pokemon.dart';

class GuessInput extends StatelessWidget {
  final TextEditingController controller;
  final List<Pokemon> options;
  final String hint;
  final void Function(String)? onFieldSubmitted;
  final void Function(Pokemon)? onSelected;

  const GuessInput({
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

    return Autocomplete<Pokemon>(
      optionsBuilder: (textEditingValue) {
        final input = textEditingValue.text.toLowerCase();
        if (input.isEmpty) return const Iterable<Pokemon>.empty();
        return options
            .where((opt) => opt.name.toLowerCase().contains(input))
            .take(20);
      },
      displayStringForOption: (pokemon) => pokemon.name,
      onSelected: (selection) {
        controller.text = selection.name;
        if (onSelected != null) onSelected!(selection);
      },
      fieldViewBuilder: (context, textEditingController, focusNode, _) {
        textEditingController.addListener(() {
          controller.value = textEditingController.value;
        });

        return TextField(
          controller: textEditingController,
          focusNode: focusNode,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: colors.onSurface,
              ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: colors.onSurface,
            ),
            filled: true,
            fillColor: colors.surface,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colors.tertiary, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colors.secondary, width: 2),
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 250),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                reverse: true,
                itemCount: optionsList.length,
                itemBuilder: (context, index) {
                  final opt = optionsList[index];
                  return ListTile(
                    leading: Image.network(
                      opt.imageUrl,
                      width: 36,
                      height: 36,
                      fit: BoxFit.contain,
                    ),
                    title: Text(
                      opt.name,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
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


