import 'dart:io';

class Contact {
  late int id;
  late String  name, lastName, phone;
  File? image;

  Contact(
      {required this.name,
      required this.phone,
      required this.lastName,
      this.image});
  Contact.fromMap(Map<String, dynamic> item)
      : id = item["_id"],
        name = item["name"],
        lastName = item['lastname'],
        phone = item['phone'],
        image = item['image']=='null'? null : File(item['image']);

  Map<String, Object> toMap() {
    return {
      'name': name,
      'lastname': lastName,
      'phone': phone,
      'image': image==null?'null': image!.path,
    };
  }
}
