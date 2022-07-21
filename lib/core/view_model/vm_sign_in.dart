class VM_SignIn {
  final String phoneNumber;
  final String password;

  VM_SignIn({this.phoneNumber, this.password});

  Map<String, dynamic> toJson() =>
      {'phoneNumber': phoneNumber, 'password': password};
}
