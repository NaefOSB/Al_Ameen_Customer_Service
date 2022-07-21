
class VM_CreateAccount {
  final String Name;
  final String PhoneNumber;
  final int BranchID;
  final String Address;
  final String Password;

  VM_CreateAccount(
      {this.Name,
      this.PhoneNumber,
      this.BranchID,
      this.Address,
      this.Password});

  Map<String, dynamic> toJson() =>
      {
        'Name': Name,
        'PhoneNumber': PhoneNumber,
        'BranchID': BranchID,
        'Address': Address,
        'Password': Password
      };
}
