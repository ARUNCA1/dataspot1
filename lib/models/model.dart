class ApiModel {
  Response? response;

  ApiModel({this.response});

  ApiModel.fromJson(Map<String, dynamic> json) {
    response = json['Response'] != null
        ? new Response.fromJson(json['Response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.response != null) {
      data['Response'] = this.response!.toJson();
    }
    return data;
  }
}

class Response {
  List<Users>? users;

  Response({this.users});

  Response.fromJson(Map<String, dynamic> json) {
    if (json['Users'] != null) {
      users = <Users>[];
      json['Users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.users != null) {
      data['Users'] = this.users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  String? name;
  String? email;
  String? image;
  String? region;
  String? mobile;
  String? zone;
  bool? isOnline;

  Users(
      {this.name,
        this.email,
        this.image,
        this.region,
        this.mobile,
        this.zone,
        this.isOnline});

  Users.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    email = json['Email'];
    image = json['image'];
    region = json['region'];
    mobile = json['mobile'];
    zone = json['zone'];
    isOnline = json['isOnline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['Email'] = this.email;
    data['image'] = this.image;
    data['region'] = this.region;
    data['mobile'] = this.mobile;
    data['zone'] = this.zone;
    data['isOnline'] = this.isOnline;
    return data;
  }
}