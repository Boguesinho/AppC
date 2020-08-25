import 'dart:convert';

RespuestaSalas respuestaSalasFromJson(String str) =>
    RespuestaSalas.fromJson(json.decode(str));

String respuestaSalasToJson(RespuestaSalas data) => json.encode(data.toJson());

class RespuestaSalas {
  RespuestaSalas({
    this.page,
    this.perPage,
    this.total,
    this.totalPages,
    this.data,
    this.ad,
  });

  int page;
  int perPage;
  int total;
  int totalPages;
  List<Usuario> data;
  Ad ad;

  factory RespuestaSalas.fromJson(Map<String, dynamic> json) => RespuestaSalas(
        page: json["page"],
        perPage: json["per_page"],
        total: json["total"],
        totalPages: json["total_pages"],
        data: List<Usuario>.from(json["data"].map((x) => Usuario.fromJson(x))),
        ad: Ad.fromJson(json["ad"]),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "per_page": perPage,
        "total": total,
        "total_pages": totalPages,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "ad": ad.toJson(),
      };
}

class Ad {
  Ad({
    this.company,
    this.url,
    this.text,
  });

  String company;
  String url;
  String text;

  factory Ad.fromJson(Map<String, dynamic> json) => Ad(
        company: json["company"],
        url: json["url"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "company": company,
        "url": url,
        "text": text,
      };
}

class Usuario {
  Usuario({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
  });

  int id;
  String email;
  String firstName;
  String lastName;
  String avatar;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json["id"],
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "avatar": avatar,
      };
}
