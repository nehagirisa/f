
class DataModel {
  DataModel({
    this.text,
    this.summary,
    this.title,
    this.authername,
    this.ImageUrl
    // this.updateTime,
  });

  late final String? text;
  late final String? summary;
  late final String? title;
  late final String? authername;
   late final String? ImageUrl;
  // late final Timestamp? updateTime;

  DataModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    title = json['title'];
    summary = json['summary'];
    authername = json['authername'];
    ImageUrl = json['ImageUrl'];
    // updateTime = json['updateTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'title': title,
      'summary': summary,
      'authername': authername,
      'ImageUrl': ImageUrl,
      //  'updateTime': updateTime,

    };
  }
}
