import 'package:toastification/toastification.dart';

class Messager {
  Messager._();

  static MessagerType success({
    String title = "Sucesso",
    required String message,
  }) => MessagerType.success(title: title, message: message);

  static MessagerType error({String title = "Erro", required String message}) =>
      MessagerType.error(title: title, message: message);

  static MessagerType warning({
    String title = "Atenção",
    required String message,
  }) => MessagerType.warning(title: title, message: message);

  static MessagerType info({
    String title = "Informação",
    required String message,
  }) => MessagerType.info(title: title, message: message);
}

class MessagerType {
  final String title;
  final String message;
  final ToastificationType type;

  MessagerType.success({required this.title, required this.message})
    : type = ToastificationType.success;

  MessagerType.error({required this.title, required this.message})
    : type = ToastificationType.error;

  MessagerType.warning({required this.title, required this.message})
    : type = ToastificationType.warning;

  MessagerType.info({required this.title, required this.message})
    : type = ToastificationType.info;
}
