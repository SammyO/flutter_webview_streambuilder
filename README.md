# webview_streambuilder_issue

Example app that demonstrates Flutte WebView and StreamBuilder not working together correctly, as specified in https://github.com/flutter/flutter/issues/49640#issuecomment-579684559.

Steps to reproduce:
1. Open app
2. Click "Next"
3. In logs, observe new HTML from stream being received
4. Observe WebView contents not changing ("Page 1" stays displayed", rather than "Page 2", "Page 3", etc.)
