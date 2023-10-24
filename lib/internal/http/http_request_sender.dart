import 'dart:convert';
import 'dart:io';

class HttpRequestSender {

  	final String _path;
  	final String _host;
  	final Map<String, dynamic> _queryParams;
  	final bool _useSSL;

  	final Map<String, String> _headers;
  	final Map<String, String> _cookies;


	HttpRequestSender({
		bool useSSL = true,
		String host = "portal.unn.ru",
		required String path,

		Map<String, dynamic> queryParams = const {},

		Map<String, String> headers = const {},
		Map<String, String> cookies = const {}
	}) : _cookies = cookies, _headers = headers, _useSSL = useSSL, _queryParams = queryParams, _host = host, _path = path;

	Future<HttpClientResponse> postForm(Map<String, dynamic> body) async {

		final httpClient = HttpClient();

		//client request
		final request = await httpClient.postUrl(_createURI());

		request.headers.add("Content-Type", "application/x-www-form-urlencoded");

		_headers.forEach((key, value) {
			request.headers.add(key, value);
		});

		_cookies.forEach((key, value) {
			request.cookies.add(Cookie(key, value));
		});

		//add body
		request.add(
			utf8.encode(
				Uri(queryParameters: body).query //it means [k1=v1&k2=v2&...&kn=vn] encoded to unicode
			)
		);

		//fetch response
		return await request.close();
	}

	Uri _createURI() {
		return Uri.parse("${_useSSL ? "https" : "http"}://$_host/$_path")
			.replace(queryParameters: _queryParams);
	}

}