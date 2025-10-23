import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:poke_app/ui/core/themes/colors.dart';

class CustomTextfield extends StatelessWidget {
  final Function(String)? onChanged;
  final FocusNode? focus;
  const CustomTextfield({super.key, this.onChanged, this.focus});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      focusNode: focus,
      //style: theme.typography.poppins14px().copyWith(color: theme.colors.grey99Color),
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SvgPicture.asset('assets/icons/svg/search_textfield/search_icon.svg'),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(width: 1.0, color: AppColors.grey3),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(width: 2.0, color: AppColors.grey3),
        ),
        hint: Text('Procurar Pókemon...'),
      ),
    );
  }
}
