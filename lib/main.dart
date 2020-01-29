import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'bloc.dart';
import 'htmlpage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Bloc _bloc = new Bloc();
  WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    _bloc.init();

    return StreamBuilder(
        stream: _bloc.currentHtmlPageStream,
        builder: (BuildContext context,
            AsyncSnapshot<HtmlPage> casePageSnapshot) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Color(0xFF6e00d4),
                leading: IconButton(icon: Icon(Icons.arrow_back),
                  onPressed: () => _closePage(context),
                ),
              ),
              body: _buildBody(casePageSnapshot)
          );
        }
    );
  }

  Widget _buildBody(AsyncSnapshot<HtmlPage> casePageSnapshot) {
    if (casePageSnapshot.hasData) {
      return new Center(
          child: Container(
            padding: const EdgeInsets.only(top: 22),
            child: _composeText(casePageSnapshot.data.text),
            color: Colors.white,
          )
      );
    } else {
      return new Center(
          child: Container(
            padding: const EdgeInsets.only(top: 22),
            child: _composeLoading(),
          )
      );
    }
  }

  Widget _composeLoading() {
    return Container(
        padding: const EdgeInsets.all(8),
        child: Text(
          "Loading...",
          textAlign: TextAlign.center,
        )
    );
  }

  Widget _composeText(String html) {
    return Column(
      children: <Widget>[
        Container(
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    child: Text("Next"),
                    onTap: () {
                      _bloc.nextPage();
                    }
                ),
              ),
            ],
          ),
        ),
        Expanded(child: _getWebView(html)),
      ],
    );
  }

  Widget _getWebView(String rawHtml) {
    print(rawHtml);

    return new WebView(
        initialUrl: '',
        onWebViewCreated: (WebViewController webViewController) {
          _controller = webViewController;
          _setRawHtml(rawHtml);
        },
        navigationDelegate: (NavigationRequest request) {
          return NavigationDecision.prevent;
        }
    );
  }

  _setRawHtml(String rawHtml) async {
    _controller.loadUrl(Uri.dataFromString(
        rawHtml,
        mimeType: 'text/html',
        encoding: Encoding.getByName('utf-8')
    ).toString());
  }

  _closePage(BuildContext context) {
    Navigator.pop(context, false);
  }
}
