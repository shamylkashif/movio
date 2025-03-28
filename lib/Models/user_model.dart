class MovieAppUser {
  String? uid;
  String name;
  String email;
  String password;
  String gender;
  String phoneNumber;
  String profileImage; // URL of profile image

  // Constructor
  MovieAppUser({
    this.uid,
    required this.name,
    required this.email,
    required this.password,
    required this.gender,
    required this.phoneNumber,
    this.profileImage = "", // Default empty string
  });

  // Convert User object to JSON (for Firestore)
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'password': password,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'profileImage': profileImage,
    };
  }

  // Convert JSON (from Firestore) to User object
  factory MovieAppUser.fromJson(Map<String, dynamic> json) {
    return MovieAppUser(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      gender: json['gender'],
      phoneNumber: json['phoneNumber'],
      profileImage: json['profileImage'] ?? "",
    );
  }
}
