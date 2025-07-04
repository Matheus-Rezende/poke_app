import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:poke_app/app/core/ui/app_theme.dart';

class SearchTextfieldWidget extends StatelessWidget {
  final Function(String)? onChanged;
  final AppTheme theme;
  final FocusNode? focus;
  const SearchTextfieldWidget({super.key, this.onChanged, required this.theme, this.focus});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      focusNode: focus,
      style: theme.typography.poppins14px().copyWith(color: theme.colors.grey99Color),
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SvgPicture.asset('assets/icons/svg/search_textfield/search_icon.svg'),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(width: 1.0, color: theme.colors.greyCCColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(width: 2.0, color: theme.colors.greyCCColor),
        ),
        hint: Text(
          'Procurar Pókemon...',
          style: theme.typography.poppins14px().copyWith(color: theme.colors.grey99Color),
        ),
      ),
    );
  }
}
