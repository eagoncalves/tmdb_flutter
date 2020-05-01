import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

import 'interceptors/LoggingInterceptor.dart';

final String baseUrl = 'https://api.themoviedb.org/3';
final String apiKey = '798920b941701a984a18d3ac6d9a9b0c';
final String urlBaseImg = 'https://image.tmdb.org/t/p';
final String endpointPlaying = 'now_playing';
final String endpointPopular = 'popular';
final String endpointTopRated = 'top_rated';
final String endpointUpcoming = 'upcoming';
final String endpointSearch = 'search';

final Client client = HttpClientWithInterceptor.build(
  interceptors: [LoggingInterceptor()],
  requestTimeout: Duration(seconds: 5),
);
