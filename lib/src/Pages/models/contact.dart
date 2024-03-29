// To parse this JSON data, do
//
//     final contact = contactFromJson(jsonString);

import 'dart:convert';

List<Contact> contactFromJson(String str) => List<Contact>.from(json.decode(str).map((x) => Contact.fromJson(x)));

String contactToJson(List<Contact> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Contact {
    String activity;
    String name;
    String telephone;
    String extension;
    String email;
    String image;

    Contact({
        required this.activity,
        required this.name,
        required this.telephone,
        required this.extension,
        required this.email,
        required this.image,
    });

    factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        activity: json["activity"],
        name: json["name"],
        telephone: json["telephone"],
        extension: json["extension"],
        email: json["email"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "activity": activity,
        "name": name,
        "telephone": telephone,
        "extension": extension,
        "email": email,
        "image": image,
    };
}
