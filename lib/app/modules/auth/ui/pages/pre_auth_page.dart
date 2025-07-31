import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_app/app/core/routes/app_routes.dart';
import 'package:poke_app/app/core/ui/app_theme.dart';
import 'package:poke_app/app/core/ui/widgets/app_bar/custom_app_bar_widget.dart';
import 'package:poke_app/app/core/ui/widgets/buttons/custom_button_widget.dart';

class PreAuthPage extends StatelessWidget {
  final bool isRegister;

  const PreAuthPage({super.key, required this.isRegister});

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
                    child: Column(
                      spacing: 24.0,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          isRegister
                              ? 'assets/images/png/coaches/coach_6.png'
                              : 'assets/images/png/coaches/coach_7.png',
                          filterQuality: FilterQuality.none,
                        ),
                        Text(
                          isRegister
                              ? 'Falta pouco para explorar esse mundo!'
                              : 'Que bom te ver aqui novamente!',
                          style: appTheme.typography.poppins26px().copyWith(fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'Como deseja se conectar?',
                          style: appTheme.typography.poppins14px().copyWith(
                            color: appTheme.colors.grey66Color,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Column(
                          spacing: 16.0,
                          children: [
                            CustomButtonWidget(
                              title: 'Continuar com o Facebook',
                              titleStyle: appTheme.typography.poppins16px().copyWith(
                                fontWeight: FontWeight.w600,
                                color: appTheme.colors.grey4DColor,
                              ),
                              height: 58,
                              width: sizeOf.width,
                              iconPosition: IconPosition.prefix,
                              borderRadius: 50.0,
                              iconPath: 'assets/icons/svg/facebook_icon.svg',
                              backgroundColor: appTheme.colors.whiteColor,
                              borderColor: appTheme.colors.greyBorderColor,
                            ),
                            CustomButtonWidget(
                              title: 'Continuar com o Google',
                              titleStyle: appTheme.typography.poppins16px().copyWith(
                                fontWeight: FontWeight.w600,
                                color: appTheme.colors.grey4DColor,
                              ),
                              height: 58,
                              width: sizeOf.width,
                              iconPosition: IconPosition.prefix,
                              borderRadius: 50.0,
                              iconPath: 'assets/icons/svg/google_icon.svg',
                              backgroundColor: appTheme.colors.whiteColor,
                              borderColor: appTheme.colors.greyBorderColor,
                            ),
                            CustomButtonWidget(
                              height: 58.0,
                              title: 'Continuar com um e-mail',
                              titleStyle: appTheme.typography.poppins18px().copyWith(
                                color: appTheme.colors.whiteColor,
                                fontWeight: FontWeight.w600,
                              ),
                              width: sizeOf.width,
                              borderRadius: 50.0,
                              backgroundColor: appTheme.colors.backgroundBlueColor,
                              onPressed: () => Modular.to.pushNamed(
                                AppRoutes.auth(),
                                arguments: isRegister ? true : false,
                              ),
                            ),
                            SizedBox(height: 16.0),
                          ],
                        ),
                      ],
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
}
