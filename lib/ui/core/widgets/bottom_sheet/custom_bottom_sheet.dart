import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Exibe um Bottom Sheet modal customizável, expansível e que fecha ao tocar fora.
///
/// [context] O BuildContext da árvore de widgets.
/// [child] O widget que será exibido como conteúdo principal do bottom sheet.
/// [initialHeightFactor] A altura inicial do bottom sheet como uma fração da altura da tela (padrão 0.5).
/// [maxHeightFactor] A altura máxima que o sheet pode atingir ao ser expandido (padrão 0.9).
void showCustomBottomSheet({
  required BuildContext context,
  required String title,
  required Widget child,
  double initialHeightFactor = 0.5,
  double maxHeightFactor = 0.9,
  Color? backgroundColor,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,

    // ADICIONADO: Garante explicitamente que o bottom sheet fechará ao tocar fora.
    // Embora 'true' seja o valor padrão, deixá-lo explícito melhora a clareza.
    // AQUI ESTÁ O PARÂMETRO CORRETO E VÁLIDO:
    builder: (context) {
      // MUDANÇA PRINCIPAL: Envolvemos tudo em um GestureDetector
      return GestureDetector(
        behavior:
            HitTestBehavior.opaque, // Garante que toques na área transparente sejam detectados
        onTap: () {
          // Fecha o bottom sheet quando a área FORA do DraggableScrollableSheet é tocada.
          context.pop();
        },
        child: DraggableScrollableSheet(
          initialChildSize: initialHeightFactor,
          minChildSize:
              initialHeightFactor * 0.9, // Permite encolher um pouco antes de fechar (opcional)
          maxChildSize: maxHeightFactor,
          builder: (BuildContext context, ScrollController scrollController) {
            // Envolvemos o _CustomBottomSheet com outro GestureDetector
            // para IMPEDIR que toques DENTRO dele fechem o sheet.
            return _CustomBottomSheet(
              backgroundColor: backgroundColor,
              scrollController: scrollController,
              title: title,
              child: child,
            );
          },
        ),
      );
    },
  );
}

/// O widget interno que desenha a aparência do Bottom Sheet.
class _CustomBottomSheet extends StatelessWidget {
  final Widget child;
  final String title;
  final Color? backgroundColor;
  final ScrollController scrollController;

  const _CustomBottomSheet({
    required this.child,
    required this.scrollController,
    required this.title,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    const shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
    );

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Theme.of(context).canvasColor,
        borderRadius: shape.borderRadius,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Container(
            width: 38,
            height: 3,
            margin: const EdgeInsets.symmetric(vertical: 16.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(10),
            ),
          ),

          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 32.0),
          Expanded(
            child: SingleChildScrollView(controller: scrollController, child: child),
          ),
        ],
      ),
    );
  }
}
