String? validator(String? value) {
  if (value == null || value.isEmpty) {
    return 'please fill the missing informations';
  }
  return null;
}
