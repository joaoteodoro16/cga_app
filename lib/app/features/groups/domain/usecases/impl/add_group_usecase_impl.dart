import 'package:cga_app/app/features/groups/domain/entities/group.dart';
import 'package:cga_app/app/features/groups/domain/repositories/group_repository.dart';
import 'package:cga_app/app/features/groups/domain/usecases/contracts/add_group_usecase.dart';

class AddGroupUsecaseImpl extends AddGroupUsecase {
  final GroupRepository _repository;

  AddGroupUsecaseImpl({required GroupRepository repository})
    : _repository = repository;

  @override
  Future<void> call({required Group group}) async {
    await _repository.add(group: group);
  }
}
