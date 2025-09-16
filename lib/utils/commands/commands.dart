import 'package:flutter/material.dart';
import 'package:poke_app/utils/result/result.dart';

// Command0 não possui parametros de entrada
typedef CommandAction0<Output> = Future<Result<Output>> Function();

// Command1 possui parametros de entrada
typedef CommandAction1<Output, Input> = Future<Result<Output>> Function(Input);

abstract class Command<Output> extends ChangeNotifier {
  //Verifica se o Command está em execução
  bool _running = false;

  // Representação do nosso estado => Ok ou Error ou Null
  Result<Output>? _result;

  // Getters - Possuem o objetivo de evitar o acesso as variáveis privadas,
  // Criando assim acessos publicos e não acessando diretamente.
  bool get running => _running;
  Result<Output>? get result => _result;
  bool get completed => _result is Ok; // Verifica se o estado foi gerado com sucesso
  bool get error => _result is Error; // Verifica se o estado é de erro

  Future<void> _execute(CommandAction0<Output> action) async {
    if (_running) return; // Evita com que a action seja reexecutada várias vezes.

    _running = true; // Agora a action está em execução
    _result = null; // Result voltou para null

    notifyListeners();

    try {
      _result = await action();
    } finally {
      _running = false;
      notifyListeners();
    }
  }
}

class Command0<Output> extends Command<Output> {
  final CommandAction0<Output> action;

  Command0(this.action);

  Future<void> execute() async {
    await _execute(action);
  }
}

class Command1<Output, Input> extends Command<Output> {
  final CommandAction1<Output, Input> action;

  Command1(this.action);

  Future<void> execute(Input params) async {
    await _execute(() => action(params));
  }
}
