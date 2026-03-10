import 'package:cga_app/app/features/groups/module/group_module.dart';
import 'package:cga_app/app/features/groups/presentation/controllers/search_groups_controller.dart';
import 'package:get/get.dart';

class SearchGroupBindings extends Bindings {
  final String tag;

  SearchGroupBindings({required this.tag});

  @override
  void dependencies() {
    GroupModule.ensureInitialized();
    Get.lazyPut(
      () => SearchGroupsController(getGroupsUsecase: Get.find()),
      tag: tag,
    );
  }
}
