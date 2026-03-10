
import 'package:cga_app/app/features/groups/domain/entities/group.dart';
import 'package:cga_app/app/features/groups/domain/repositories/group_repository.dart';
import 'package:cga_app/app/features/groups/domain/usecases/contracts/update_group_usecase.dart';

class UpdateGroupUsecaseImpl extends UpdateGroupUsecase{

  final GroupRepository _repository;

  UpdateGroupUsecaseImpl({required GroupRepository repository}) : _repository = repository;

  @override
  Future<void> call({required Group group}) async{
    await _repository.update(group: group);
  }
  
}