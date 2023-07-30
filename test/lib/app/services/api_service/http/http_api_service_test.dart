// import 'package:flutter_test/flutter_test.dart';
// import 'package:kazi/app/data/local_storage/local_storage.dart';
// import 'package:kazi/app/services/api_service/api_service.dart';
// import 'package:kazi/app/services/api_service/http/http_api_service.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// void main() {
//   TestWidgetsFlutterBinding.ensureInitialized();
//   const String url = 'https://dummyjson.com/';
//   late ApiService apiService;

//   setUp(() async {
//     SharedPreferences.setMockInitialValues(<String, Object>{});
//     final sharedPreferences = await SharedPreferences.getInstance();
//     final localStorage = SharedPreferencesLocalStorage(sharedPreferences);
//     apiService = HttpApiService(localStorage);
//   });

//   test('Should call get method', () async {
//     final response = await apiService.get('${url}posts');
//     expect(response.body, isNotEmpty);
//     expect(response.status, 400);
//     // expect(response.status.toString(), RegExp(r'^20[0-9]'));
//   });
// }
