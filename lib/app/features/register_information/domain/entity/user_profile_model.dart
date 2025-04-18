import 'package:firebase_auth/firebase_auth.dart';

/// Classe representando o perfil do usuário.
class UserProfileModel {
  String? uid;
  String? email;
  Profile? profile;

  UserProfileModel({
    this.uid,
    this.email,
    this.profile,
  });

  /// Construtor que cria uma instância a partir de um UserCredential do Firebase.
  factory UserProfileModel.fromUserCredential(UserCredential userCredential) {
    return UserProfileModel(
      uid: userCredential.user?.uid,
      email: userCredential.user?.email,
    );
  }

  /// Construtor que cria uma instância a partir de um JSON.
  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      uid: json['id'],
      email: json['email'],
      profile:
          json['profile'] != null ? Profile.fromJson(json['profile']) : null,
    );
  }

  /// Método que converte o UserProfileModel para JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': uid,
      'email': email,
      'profile': profile?.toJson(),
    };
  }
}

/// Classe representando a resposta do processo de registro.
class MessageResponse {
  String? message;

  MessageResponse({this.message});

  /// Construtor a partir de JSON.
  factory MessageResponse.fromJson(Map<String, dynamic> json) {
    return MessageResponse(message: json['message']);
  }

  /// Método que converte RegisterResponse para JSON.
  Map<String, dynamic> toJson() {
    return {
      'message': message,
    };
  }
}

/// Classe representando o perfil detalhado do usuário.
class Profile {
  String? uid;
  String? name;
  String? email;
  String? phone;
  String? password;
  String? imageUrl;
  String? yourAvailabilityId;

  Profile({
    this.uid,
    this.name,
    this.email,
    this.phone,
    this.password,
    this.imageUrl,
    this.yourAvailabilityId,
  });

  /// Construtor a partir de JSON.
  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      uid: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      password: json['password'],
      imageUrl: json['image_url'],
      yourAvailabilityId: json['your_availability_id'],
    );
  }

  /// Método que converte Profile para JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'image_url': imageUrl,
      'your_availability_id': yourAvailabilityId,
    };
  }
}
