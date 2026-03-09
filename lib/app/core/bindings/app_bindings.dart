
import 'package:cga_app/app/core/rest_client/app_rest_client.dart';
import 'package:get/get.dart';

class AppBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(AppRestClient(), permanent: true);
  } 
}

//Get.put(AppRestClient()); -> Registra a instancia já quando o app inicia
//Get.put(AppRestClient(), permanent: true); -> Impede o get de remover da memoria

//Get.lazyPut(() => AppRestClient(),); -> Registra a instancia apenas quando ela for chamada uma unica vez

//Para dependências assíncronas.
// Get.putAsync<AppRestClient>(() async {
//   final client = AppRestClient();
//   await client.init();
//   return client;
// });
// Banco local (Hive, Isar)
// SharedPreferences
// Serviços que precisam de await
// Carregamento inicial de config

//Get.create(() => SomeController()); -> Cria uma nova instancia toda vez que for chamada

//Se o controller for retirado da memoria, ele sera recriado de novo
// Get.lazyPut(
//   () => LoginController(),
//   fenix: true,
// );