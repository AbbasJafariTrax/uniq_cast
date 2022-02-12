class ChannelModel {
  late int id;
  late String name;
  late String url;
  late String lang;
  late String template;

  ChannelModel(
    this.id,
    this.name,
    this.url,
    this.lang,
    this.template,
  );

  ChannelModel.fromJson(
      int id, String name, String url, String lang, String template) {
    this.id = id;
    this.name = name;
    this.url = url;
    this.lang = lang;
    this.template = template;
  }

  Map<String, dynamic> toJson() {
    int id = 0;
    String name = "";
    String url = "";
    String lang = "";
    String template = "";

    id = this.id;
    name = this.name;
    url = this.url;
    lang = this.lang;
    template = this.template;

    return {
      "id": id,
      "name": name,
      "url": url,
      "lang": lang,
      "template": template
    };
  }
}
