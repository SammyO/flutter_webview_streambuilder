class HtmlPageModel {
  HtmlPageModel({this.text, this.index});

  factory HtmlPageModel.fromJson(Map<String, dynamic> json) {
    return HtmlPageModel(
        text: json['text'],
        index: int.parse(json['index'])
    );
  }

  String text;
  int index;
}

class HtmlPage {
  HtmlPage({this.text, this.index});
  factory HtmlPage.fromHtmlPageModel(HtmlPageModel model) {
    return HtmlPage(
        text: model.text,
        index: model.index
    );
  }

  String text;
  int index;
}