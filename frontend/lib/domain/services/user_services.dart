import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:teentalktalk/data/env/env.dart';
import 'package:teentalktalk/ui/helpers/debouncer.dart';
import 'package:teentalktalk/data/storage/secure_storage.dart';
import 'package:teentalktalk/domain/models/response/default_response.dart';
// import 'package:teentalktalk/domain/models/response/response_followers.dart';
// import 'package:teentalktalk/domain/models/response/response_followings.dart';
import 'package:teentalktalk/domain/models/response/response_user.dart';

class UserServices {
  final debouncer = DeBouncer(duration: const Duration(milliseconds: 800));
  // final StreamController<List<UserFind>> _streamController =
  //     StreamController<List<UserFind>>.broadcast();
  // Stream<List<UserFind>> get searchProducts => _streamController.stream;

  // void dispose() {
  //   _streamController.close();
  // }

  Future<DefaultResponse> createdUser(
    String userid,
    String userName,
    String userEmail,
    String userpw,
    String userpw2,
    String userRole,
    String userType,
    String inviteCode,
    String youthageCode,
    String parentsageCode,
    String emdClassCode,
    String sexClassCode,
  ) async {
    final resp = await http
        .post(Uri.parse('${Environment.urlApi}/login/signup'), headers: {
      'Accept': 'application/json'
    }, body: {
      'userid': userid,
      'user_name': userName,
      'user_email': userEmail,
      'userpw': userpw,
      'userpw2': userpw2,
      'user_role': userRole,
      'user_type': userType,
      'invite_code': inviteCode,
      'youthAge_code': youthageCode,
      'parentsAge_code': parentsageCode,
      'emd_class_code': emdClassCode,
      'sex_class_code': sexClassCode
    });
    // print('${Environment.urlApi}/signup');
    // print(resp.body);

    return DefaultResponse.fromJson(jsonDecode(resp.body));
  }

  Future<DefaultResponse> createdKakaoUser(
    String userid, // 회원번호
    String userName,
    String userEmail,
    String userRole, //기본 - 선택 X
    String userType, //기본 - 선택 X
    String inviteCode,
    String youthageCode, //기본 - 선택 X
    String parentsageCode, //기본 - 선택 X
    String emdClassCode, //기본 - 선택 X
    String sexClassCode, //기본 - 선택 X
  ) async {
    final resp = await http
        .post(Uri.parse('${Environment.urlApi}/login/kakao-signup'), headers: {
      'Accept': 'application/json'
    }, body: {
      'userid': userid,
      'user_name': userName,
      'user_email': userEmail,
      // 'userpw': userpw,
      // 'userpw2': userpw2,
      'user_role': userRole,
      'user_type': userType,
      'invite_code': inviteCode,
      'youthAge_code': youthageCode,
      'parentsAge_code': parentsageCode,
      'emd_class_code': emdClassCode,
      'sex_class_code': sexClassCode
    });
    // print('${Environment.urlApi}/signup');
    // print(resp.body);

    return DefaultResponse.fromJson(jsonDecode(resp.body));
  }

  Future<ResponseUser> getUserById() async {
    final token = await secureStorage.readToken();
    // print(token);
    // print('ResponseUser - getUserById');
    final resp = await http.get(
        Uri.parse('${Environment.urlApi}/user/get-user-by-id'),
        headers: {'Accept': 'application/json', 'xxx-token': token!});

    return ResponseUser.fromJson(jsonDecode(resp.body));
  }

  Future<DefaultResponse> verifyEmail(String email, String code) async {
    print(email);
    print(code);
    final resp = await http.get(
        Uri.parse('${Environment.urlApi}/verify-email/$code/$email'),
        headers: {'Accept': 'application/json'});

    return DefaultResponse.fromJson(jsonDecode(resp.body));
  }

  // Future<DefaultResponse> updatePictureCover( String cover ) async {
  //
  //   final token = await secureStorage.readToken();
  //
  //   var request = http.MultipartRequest('PUT', Uri.parse('${Environment.urlApi}/user/update-cover'))
  //     ..headers['Accept'] = 'application/json'
  //     ..headers['xxx-token'] = token!
  //     ..files.add( await http.MultipartFile.fromPath('cover', cover));
  //
  //   final resp = await request.send();
  //   var data = await http.Response.fromStream( resp );
  //
  //   return DefaultResponse.fromJson( jsonDecode( data.body ));
  // }

  // Future<DefaultResponse> updatePictureProfile( String profile ) async {
  //
  //   final token = await secureStorage.readToken();
  //
  //   var request = http.MultipartRequest('PUT', Uri.parse('${Environment.urlApi}/user/update-image-profile'))
  //     ..headers['Accept'] = 'application/json'
  //     ..headers['xxx-token'] = token!
  //     ..files.add( await http.MultipartFile.fromPath('profile', profile));
  //
  //   final resp = await request.send();
  //   var data = await http.Response.fromStream( resp );
  //
  //   return DefaultResponse.fromJson( jsonDecode( data.body ));
  //
  // }

  // Future<DefaultResponse> updateProfile(String user, String description, String fullname, String phone) async {
  //
  //   final token = await secureStorage.readToken();
  //
  //   final resp = await http.put(Uri.parse('${Environment.urlApi}/user/update-data-profile'),
  //       headers: { 'Accept': 'application/json', 'xxx-token': token! },
  //       body: {
  //         'user': user,
  //         'description': description,
  //         'fullname': fullname,
  //         'phone': phone
  //       }
  //   );
  //
  //   return DefaultResponse.fromJson( jsonDecode( resp.body ) );
  // }

  Future<DefaultResponse> changePassword(
      String currentPass, String newPass) async {
    final token = await secureStorage.readToken();

    final resp = await http.put(
        Uri.parse('${Environment.urlApi}/user/change-password'),
        headers: {'Accept': 'application/json', 'xxx-token': token!},
        body: {'currentPassword': currentPass, 'newPassword': newPass});

    return DefaultResponse.fromJson(jsonDecode(resp.body));
  }

  Future<DefaultResponse> changeEmail(
      String currentPass, String newPass) async {
    final token = await secureStorage.readToken();

    final resp = await http.put(
        Uri.parse('${Environment.urlApi}/user/change-email'),
        headers: {'Accept': 'application/json', 'xxx-token': token!},
        body: {'currentEmail': currentPass, 'newEmail': newPass});

    return DefaultResponse.fromJson(jsonDecode(resp.body));
  }

  Future<DefaultResponse> changeExtraInfo(
      String emd, String youthAge, String parentsAge, String sex) async {
    final token = await secureStorage.readToken();

    final resp = await http.put(
        Uri.parse('${Environment.urlApi}/user/change-extra-info'),
        headers: {
          'Accept': 'application/json',
          'xxx-token': token!
        },
        body: {
          'emd_class_code': emd,
          'youthAge_code': youthAge,
          'parentsAge_code': parentsAge,
          'sex_class_code': sex
        });

    return DefaultResponse.fromJson(jsonDecode(resp.body));
  }

  // Future<DefaultResponse> changeAccountPrivacy() async {
  //
  //   final token = await secureStorage.readToken();
  //
  //   final resp = await http.put(Uri.parse('${Environment.urlApi}/user/change-account-privacy'),
  //       headers: { 'Accept': 'application/json', 'xxx-token': token! }
  //   );
  //
  //   return DefaultResponse.fromJson( jsonDecode( resp.body ) );
  // }

  // void searchUsers(String username) async {
  //   debouncer.value = '';

  //   debouncer.onValue = (value) async {
  //     final token = await secureStorage.readToken();

  //     final resp = await http.get(
  //         Uri.parse('${Environment.urlApi}/user/get-search-user/' + username),
  //         headers: {'Accept': 'application/json', 'xxx-token': token!});

  //     final listUsers = ResponseSearch.fromJson(jsonDecode(resp.body)).userFind;

  //     _streamController.add(listUsers);
  //   };

  //   final timer = Timer(
  //       const Duration(milliseconds: 200), () => debouncer.value = username);
  //   Future.delayed(const Duration(milliseconds: 400))
  //       .then((_) => timer.cancel());
  // }

  // Future<ResponseUserSearch> getAnotherUserById(String idUser) async {
  //
  //   final token = await secureStorage.readToken();
  //
  //   final resp = await http.get(Uri.parse('${Environment.urlApi}/user/get-another-user-by-id/'+ idUser),
  //       headers: { 'Accept': 'application/json', 'xxx-token': token! }
  //   );
  //
  //   return ResponseUserSearch.fromJson(jsonDecode(resp.body));
  // }

  // Future<DefaultResponse> addNewFollowing(String uidFriend) async {
  //
  //   final token = await secureStorage.readToken();
  //
  //   final resp = await http.post(Uri.parse('${Environment.urlApi}/user/add-new-friend'),
  //       headers: { 'Accept': 'application/json', 'xxx-token': token! },
  //       body: { 'uidFriend': uidFriend }
  //   );
  //
  //   return DefaultResponse.fromJson(jsonDecode(resp.body));
  // }
  //
  //
  // Future<DefaultResponse> acceptFollowerRequest(String uidFriend, String uidNotification) async {
  //
  //   final token = await secureStorage.readToken();
  //
  //   final resp = await http.post(Uri.parse('${Environment.urlApi}/user/accept-follower-request'),
  //       headers: { 'Accept': 'application/json', 'xxx-token': token! },
  //       body: {
  //         'uidFriend': uidFriend,
  //         'uidNotification' : uidNotification
  //       }
  //   );
  //
  //   return DefaultResponse.fromJson(jsonDecode(resp.body));
  // }
  //
  //
  // Future<DefaultResponse> deleteFollowing(String uidUser) async {
  //
  //   final token = await secureStorage.readToken();
  //
  //   final resp = await http.delete(Uri.parse('${Environment.urlApi}/user/delete-following/' + uidUser),
  //     headers: { 'Accept': 'application/json', 'xxx-token': token! },
  //   );
  //
  //   return DefaultResponse.fromJson(jsonDecode(resp.body));
  // }

  // Future<List<Following>> getAllFollowing() async {
  //
  //   final token = await secureStorage.readToken();
  //
  //   final resp = await http.get(Uri.parse('${Environment.urlApi}/user/get-all-following'),
  //     headers: { 'Accept': 'application/json', 'xxx-token': token! },
  //   );
  //
  //   return ResponseFollowings.fromJson( jsonDecode(resp.body) ).followings;
  // }
  //
  //
  // Future<List<Follower>> getAllFollowers() async {
  //
  //   final token = await secureStorage.readToken();
  //
  //   final resp = await http.get(Uri.parse('${Environment.urlApi}/user/get-all-followers'),
  //     headers: { 'Accept': 'application/json', 'xxx-token': token! },
  //   );
  //
  //   return ResponseFollowers.fromJson( jsonDecode(resp.body) ).followers;
  // }
  //
  //
  // Future<DefaultResponse> deleteFollowers(String uidUser) async {
  //
  //   final token = await secureStorage.readToken();
  //
  //   final resp = await http.delete(Uri.parse('${Environment.urlApi}/user/delete-followers/' + uidUser),
  //     headers: { 'Accept': 'application/json', 'xxx-token': token! },
  //   );

//     return DefaultResponse.fromJson(jsonDecode(resp.body));
//   }
//
//
//
//
}

final userService = UserServices();
