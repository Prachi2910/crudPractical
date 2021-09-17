class Support {
  String? text;
  String? url;

  Support({this.text, this.url});

  factory Support.fromJson(Map<String, dynamic> json) {
    return Support(
      text: json['text'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['url'] = this.url;
    return data;
  }
}
