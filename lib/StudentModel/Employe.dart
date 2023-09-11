class Employe {
  String? eid;
  String? ename;
  String? salary;
  String? department;
  String? gender;
  String? addedDatetime;

  Employe(
      {this.eid,
        this.ename,
        this.salary,
        this.department,
        this.gender,
        this.addedDatetime});

  Employe.fromJson(Map<String, dynamic> json) {
    eid = json['eid'];
    ename = json['ename'];
    salary = json['salary'];
    department = json['department'];
    gender = json['gender'];
    addedDatetime = json['added_datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eid'] = this.eid;
    data['ename'] = this.ename;
    data['salary'] = this.salary;
    data['department'] = this.department;
    data['gender'] = this.gender;
    data['added_datetime'] = this.addedDatetime;
    return data;
  }
}