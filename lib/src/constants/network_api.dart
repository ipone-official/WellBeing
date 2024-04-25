// https://cmcrud.herokuapp.com/products

class NetworkAPI {
  static const String baseURL =
      'https://webapps.ip-one.com/WebAPIRunner/Runner/v1';

  // static const String baseURL =
  //     'https://192.168.253.86/Runner/v1';
      
  static const String login = '/postLogin';
  static const String rankRunner = '/getRankRunner';
  static const String meRunner = '/getMeRunner';
  static const String getUser = '/getUserById';
  static const String InsertRunner = '/postRecordOnWeb';
  static const String contact = '/getContact';
  static const String history = '/getHistory';
  static const String uploadImageRunner =
      'https://webapps.ip-one.com:3000/upload/uploadImgRunner';
  static const String token = 'token';
  static const String username = 'username';
}
