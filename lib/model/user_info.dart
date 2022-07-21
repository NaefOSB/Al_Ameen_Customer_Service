class UserInfo {
  final String userId;
  final String userName;
  final String phoneNumber;
  final String role;
  final String token;
  final int customerService;
  final int accounting;
  final int maintenance;
  final int programming;
  final int branchId;

  UserInfo(
      {this.userId,
      this.userName,
      this.phoneNumber,
      this.role,
      this.token,
      this.customerService,
      this.accounting,
      this.maintenance,
      this.programming,
      this.branchId});

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'userName': userName,
        'phoneNumber': phoneNumber,
        'role': role,
        'token': token,
        'customerService': customerService,
        'accounting': accounting,
        'maintenance': maintenance,
        'programming': programming,
        'branchId':branchId
      };
}
