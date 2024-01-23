import 'dart:convert';

class ConditionalService {
  String authConditionalMessage(res, message) {
    var data = json.decode(res.body);
    var dataMessage = data['message'];

    if (dataMessage == 'The id field is required.') {
      return message = 'UserID tidak boleh kosong';
    } else if (dataMessage == 'The id field is false.') {
      return message = 'UserID salah';
    } else if (dataMessage == null) {
      return message = '';
    } else {
      return message = 'terjadi kesalahan';
    }
  }
}
