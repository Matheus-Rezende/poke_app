import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_app/app/core/ui/app_theme.dart';
import 'package:poke_app/app/core/ui/widgets/app_bar/custom_app_bar_widget.dart';
import 'package:poke_app/app/core/ui/widgets/buttons/custom_button_widget.dart';
import 'package:poke_app/app/core/ui/widgets/text_fields/custom_textfield_widget.dart';

class AuthPage extends StatelessWidget {
  final bool isRegister;

  const AuthPage({super.key, required this.isRegister});

  @override
  Widget build(BuildContext context) {
    final appTheme = Modular.get<AppTheme>();
    final sizeOf = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: appTheme.colors.whiteColor,
      appBar: CustomAppBarWidget(
        appBarHeight: 50.0,
        widget: SafeArea(
          child: SizedBox(
            child: Row(
              children: [
                Flexible(
                  flex: 2,
                  child: IconButton(
                    onPressed: () => Modular.to.pop(),
                    icon: Icon(Icons.chevron_left_rounded),
                    alignment: Alignment.centerLeft,
                    iconSize: 32.0,
                  ),
                ),
                Flexible(
                  flex: 8,
                  child: Center(
                    child: Text(
                      isRegister ? 'Criar conta' : 'Entrar',
                      style: appTheme.typography.poppins18px().copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Center(
                      child: Column(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                SizedBox(height: 32.0),
                                Text(
                                  isRegister ? 'Vamos começar!' : 'Bem vindo de volta!',
                                  style: appTheme.typography.poppins26px().copyWith(
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Text(
                                  isRegister ? 'Qual é o seu e-mail?' : 'Preencha os dados',
                                  style: appTheme.typography.poppins26px().copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 32.0),
                                isRegister ? registerBody() : loginBody(),
                              ],
                            ),
                          ),
                          CustomButtonWidget(
                            title: 'Continuar',
                            titleStyle: appTheme.typography.poppins18px().copyWith(
                              fontWeight: FontWeight.w600,
                              color: appTheme.colors.whiteColor,
                            ),
                            height: 58.0,
                            borderRadius: 50.0,
                            width: sizeOf.width,
                            backgroundColor: appTheme.colors.backgroundBlueColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget registerBody() {
    final appTheme = Modular.get<AppTheme>();
    return Column(
      spacing: 16.0,
      children: [
        CustomTextfieldWidget(),
        Text(
          'Use um endereço de e-mail válido.',
          style: appTheme.typography.poppins12px().copyWith(color: appTheme.colors.grey4DColor),
        ),
      ],
    );
  }

  Widget loginBody() {
    final appTheme = Modular.get<AppTheme>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16.0,
      children: [
        Text('E-mail', style: appTheme.typography.poppins14px().copyWith(fontWeight: FontWeight.w600)),
        CustomTextfieldWidget(),
        Text('Senha', style: appTheme.typography.poppins14px().copyWith(fontWeight: FontWeight.w600)),
        CustomTextfieldWidget(),
        Center(
          child: CustomButtonWidget(
            title: 'Esqueceu sua senha?',
            titleStyle: appTheme.typography.poppins14px().copyWith(
              color: appTheme.colors.backgroundBlueColor,
              fontWeight: FontWeight.w500,
            ),
            width: 300.0,
            height: 52.0,
            backgroundColor: appTheme.colors.whiteColor,
          ),
        ),
      ],
    );
  }
}
