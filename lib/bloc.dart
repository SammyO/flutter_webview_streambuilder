import 'dart:convert' as convert;

import 'package:rxdart/rxdart.dart';

import 'htmlpage.dart';

class Bloc {
  Bloc() {
    _htmlPages.stream.listen((value) {
      if (value.isNotEmpty) {
        _startHtmlPageIteration(value);
      }
    });
  }

  final BehaviorSubject<List<HtmlPage>> _htmlPages = BehaviorSubject<List<HtmlPage>>();
  final BehaviorSubject<HtmlPage> _currentHtmlPage = BehaviorSubject<HtmlPage>();

  get htmlPagesStream => _htmlPages.stream;
  get currentHtmlPageStream => _currentHtmlPage.stream;

  int index;

  init() async {
    _htmlPages.sink.add(_composeHtmlPages());
  }

  _startHtmlPageIteration(List<HtmlPage> data) {
    index = 0;
    _currentHtmlPage.sink.add(data.first);
  }

  void nextPage() {
    index++;
    _currentHtmlPage.value = _htmlPages.value[index];
  }

  List<HtmlPage> _composeHtmlPages() {
    const json =
        '{ "pages":[ { "index": "1", "text": " <html> <head> <meta name=\'viewport\' content=\'width=device-width, initial-scale=1\'> <style> body { font-family: Arial, sans-serif } table, th, td { border: 1px solid black; border-collapse: collapse; } a, a:link, a:visited, a:focus, a:hover, a:active { outline: none; text-decoration: none; color: #597896; font-style: italic; } </style> </head> <body> <div> Page 1 </div> </body> </html> " }, { "index": "2", "text": " <html> <head> <meta name=\'viewport\' content=\'width=device-width, initial-scale=1\'> <style> body { font-family: Arial, sans-serif } table, th, td { border: 1px solid black; border-collapse: collapse; } a, a:link, a:visited, a:focus, a:hover, a:active { outline: none; text-decoration: none; color: #597896; font-style: italic; } </style> </head> <body> <div> Page 2 </div> </body> </html> " }, { "index": "3", "text": " <html> <head> <meta name=\'viewport\' content=\'width=device-width, initial-scale=1\'> <style> body { font-family: Arial, sans-serif } table, th, td { border: 1px solid black; border-collapse: collapse; } a, a:link, a:visited, a:focus, a:hover, a:active { outline: none; text-decoration: none; color: #597896; font-style: italic; } </style> </head> <body> <div> Page 3 </div> </body> </html> " }, { "index": "4", "text": " <html> <head> <meta name=\'viewport\' content=\'width=device-width, initial-scale=1\'> <style> body { font-family: Arial, sans-serif } table, th, td { border: 1px solid black; border-collapse: collapse; } a, a:link, a:visited, a:focus, a:hover, a:active { outline: none; text-decoration: none; color: #597896; font-style: italic; } </style> </head> <body> <div> Page 4 </div> </body> </html> " }, { "index": "5", "text": " <html> <head> <meta name=\'viewport\' content=\'width=device-width, initial-scale=1\'> <style> body { font-family: Arial, sans-serif } table, th, td { border: 1px solid black; border-collapse: collapse; } a, a:link, a:visited, a:focus, a:hover, a:active { outline: none; text-decoration: none; color: #597896; font-style: italic; } </style> </head> <body> <div> Page 5 </div> </body> </html> " } ]}';

    final jsonResponse = convert.jsonDecode(json);

    final result = (jsonResponse['pages'] as List)
        .map((question) => HtmlPageModel.fromJson(question));

    final list =
        result.map((question) => HtmlPage.fromHtmlPageModel(question)).toList();

    return list;
  }

  dispose() {
    _htmlPages.close();
    _currentHtmlPage.close();
  }
}