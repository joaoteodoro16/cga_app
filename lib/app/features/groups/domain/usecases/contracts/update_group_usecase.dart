import 'package:cga_app/app/features/groups/domain/entities/group.dart';

abstract class UpdateGroupUsecase {
Future<void> call({required Group group});
}