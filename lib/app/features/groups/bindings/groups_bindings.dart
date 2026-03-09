import 'package:cga_app/app/features/groups/data/datasources/remote/group_remote_datasource.dart';
import 'package:cga_app/app/features/groups/data/datasources/remote/group_remote_datasource_impl.dart';
import 'package:cga_app/app/features/groups/data/repositories/group_repository_impl.dart';
import 'package:cga_app/app/features/groups/domain/repositories/group_repository.dart';
import 'package:cga_app/app/features/groups/domain/usecases/contracts/get_groups_usecase.dart';
import 'package:cga_app/app/features/groups/domain/usecases/impl/get_groups_usecase_impl.dart';
import 'package:cga_app/app/features/groups/presentation/controllers/groups_controller.dart';
import 'package:get/get.dart';

class GroupsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GroupRemoteDatasource>(
      () => GroupRemoteDatasourceImpl(dio: Get.find()),
      fenix: true,
    );
    Get.lazyPut<GroupRepository>(
      () => GroupRepositoryImpl(remote: Get.find()),
      fenix: true,
    );
    Get.lazyPut<GetGroupsUsecase>(
      () => GetGroupsUsecaseImpl(groupRepository: Get.find()),
      fenix: true,
    );
    Get.lazyPut(() => GroupsController(getGroupsUsecase: Get.find()));
  }
}
