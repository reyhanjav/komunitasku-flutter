import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  const User(
      {this.roles,
      this.id,
      this.photoUrl,
      this.email,
      this.displayName,
      this.community,
      this.status,
      this.favorites,     
      this.xp,
      this.level,
      this.phoneNumber,
      this.gender,
      this.generation});

  final String roles;
  final String email;
  final String id;
  final String photoUrl;
  final String displayName;
  final String community;
  final String status;
  final String favorites;
  final String xp;
  final String level;

  final String phoneNumber; // masih belum tau fungsinya buat apa
  final String gender; 
  final String generation; //maksudnya angkatan ilkom

  

  factory User.fromDocument(DocumentSnapshot document) {
    return new User(
      roles: document['roles'],
      email: document['email'],
      photoUrl: document['photoUrl'],
      id: document.documentID,
      displayName: document['displayName'],
      xp: document['xp'],
      level: document['level'],
      status: document['status'],
      community: document['community'],
      favorites: document['favorites'],
      phoneNumber: document['phoneNumber'],
      gender: document['gender'],
      generation: document['generation'] 
    );
  }
}