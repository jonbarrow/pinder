import 'package:http/http.dart' as http; // HTTP package
import 'dart:convert'; // Data conversion lib
import 'package:pinder/config.dart' as config; 

Future<dynamic> getAnimals(query) async {
  var url = Uri.https('api.petfinder.com', 'v2/animals', query);
  return await apiRequest(url);
}

Future<dynamic> getAnimal(int id) async {
  var url = Uri.https('api.petfinder.com', 'v2/animals/$id', {'location': '32224'});
  return await apiRequest(url);
}

Future<dynamic> apiRequest(Uri endpoint) async {
  Map<String, dynamic> tokenData = await getAccessToken();

  String tokenType = tokenData['token_type'];
  String token = tokenData['access_token'];
  
  Map<String, String> headers = {
    'Authorization': '$tokenType $token'
  };

  var response = await http.get(endpoint, headers: headers);
  if (response.statusCode != 200) {
    return null;
  }

  return json.decode(response.body);
}

Future<dynamic> getAccessToken() async {
  final Map<String, dynamic> body = {
    'grant_type': 'client_credentials',
    'client_id': config.PETFINDER_CLIENT_ID,
    'client_secret': config.PETFINDER_CLIENT_SECRET
  };

  var url = Uri.https('api.petfinder.com', '/v2/oauth2/token');

  var response = await http.post(url, body: body);
  if (response.statusCode != 200) {
    return null;
  }

  return json.decode(response.body);
}

/*
void main() async {
  Map<String, dynamic> data = await getAnimals({'location': '32224', 'sort': 'distance', 'type': 'Cat'});
  print(data['pagination']['current_page']+1);
  var animal = await getAnimal(data['animals'][0]['id']);
  print(animal['animal']['distance']);
  data['animals'].forEach((dynamic animal) {
    print(animal['distance']);
  });
}
*/