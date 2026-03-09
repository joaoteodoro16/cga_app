enum EntityStatusFilterEnum {
  all(description: "Todos"),
  active(description: "Ativo"),
  inactive(description: "Inativo");

  final String description;

  const EntityStatusFilterEnum({required this.description});

  bool? toBoolean() {
    switch (this) {
      case EntityStatusFilterEnum.all:
        return null;
      case EntityStatusFilterEnum.active:
        return true;
      case EntityStatusFilterEnum.inactive:
        return false;
    }
  }
}
