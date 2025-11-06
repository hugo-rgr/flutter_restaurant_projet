class RegistrationDTO {
  final String? name;
  final String email;
  final String password;
  final String? phone;
  final ROLE role;

  RegistrationDTO({
    this.name,
    required this.email,
    required this.password,
    this.phone,
    required this.role,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'role': role.name,
    };
  }
}

enum ROLE { client, host, admin }
