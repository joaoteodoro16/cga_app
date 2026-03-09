enum EntityStatusEnum {
  active(description: "Ativo"),
  inactive(description: "Inativo");

  final String description;

  const EntityStatusEnum({required this.description});

  static EntityStatusEnum fromBoolean(bool value) {
    switch (value) {
      case true:
        return EntityStatusEnum.active;
      case false:
        return EntityStatusEnum.inactive;
    }
  }

  bool toBoolean() {
    switch (this) {
      case EntityStatusEnum.active:
        return true;
      case EntityStatusEnum.inactive:
        return false;
    }
  }
}
