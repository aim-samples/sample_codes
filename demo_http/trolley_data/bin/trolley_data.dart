import 'package:http/http.dart' as http;

void main(List<String> arguments) {
  TrolleyData.fetch(arguments[0].toString()).then(print);
}

class TrolleyData {
  static var url = 'http://192.168.0.17/auto_trolley/orders.php?';
  static Future<dynamic> fetch(String id) async {
    var response = await http.get(with_id(id));
    return response.body;
  }

  static String with_id(String id) => '${url}trolley_id=$id';
}
