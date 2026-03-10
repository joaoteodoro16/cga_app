
import 'package:cga_app/app/features/groups/bindings/groups_bindings.dart';

class GroupModule {
  static void ensureInitialized() {
    GroupsBindings().dependencies();
  }
}