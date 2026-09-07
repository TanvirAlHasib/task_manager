class RegistrationModel {
  String? status;
  Data? data;

  RegistrationModel({this.status, this.data});

  RegistrationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? email;
  String? firstName;
  String? lastName;
  String? mobile;
  String? password;
  String? createdDate;
  String? sId;

  Data(
      {this.email,
        this.firstName,
        this.lastName,
        this.mobile,
        this.password,
        this.createdDate,
        this.sId});

  Data.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    mobile = json['mobile'];
    password = json['password'];
    createdDate = json['createdDate'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['mobile'] = this.mobile;
    data['password'] = this.password;
    data['createdDate'] = this.createdDate;
    data['_id'] = this.sId;
    return data;
  }
}
