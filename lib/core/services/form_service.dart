bool isNameEmpty(String name) {
  return name.trim().isEmpty;
}

bool isNameTooShort(String name, {int minLength = 2}) {
  return name.trim().length < minLength;
}