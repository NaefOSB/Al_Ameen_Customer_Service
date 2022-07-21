import 'dart:convert';
import 'dart:io';
import 'package:al_ameen_customer_service/core/services/navigation_service.dart';
import 'package:al_ameen_customer_service/core/services/shared_preferences_service.dart';
import 'package:al_ameen_customer_service/core/view_model/vm_chat.dart';
import 'package:al_ameen_customer_service/core/view_model/vm_create_account.dart';
import 'package:al_ameen_customer_service/core/view_model/vm_sign_in.dart';
import 'package:al_ameen_customer_service/model/notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Api {
  static final  path = 'http://192.168.1.100:9000';
  getAllBranches() async {
    String url = '$path/api/branch/GetAllBranches';
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    http.Response response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    return 'error';
  }

  createUser(VM_CreateAccount user, String userRole) async {
    final jsonString = json.encode(user.toJson());
    String url =
        '$path/api/user/CreateUser?roleName=$userRole';
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    http.Response response =
        await http.post(url, headers: headers, body: jsonString);
    var result = json.decode(response.body);
    // we have 3 states
    // 1- the creation in success =======> stateCode  =200 & message != 'هذا الحساب موجود بالفعل'
    // 2- the account is already exist ==> stateCode  =200 & message == 'هذا الحساب موجود بالفعل'
    // 3- something went wrong ==========> stateCode !=200
    if (response.statusCode == 200 && result['message'] == null) {
      return json.decode(response.body);
    } else if (response.statusCode == 200 && result['message'] != null) {
      return 'Exist';
    } else {
      return 'Error';
    }
  }

  signIn(VM_SignIn userInfo) async {
    try {
      final jsonString = json.encode(userInfo.toJson());
      String url = '$path/api/user/SignIn';
      final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
      http.Response response =
          await http.post(url, headers: headers, body: jsonString);

      if (response.body.isNotEmpty) {
        // to prevent errors
        var result = json.decode(response.body);
        if (response.statusCode == 200 && result['message'] == null) {
          return json.decode(response.body);
        } else if (response.statusCode == 200 &&
            result['message'].toString() != null) {
          return 'WrongEmailOrPassword';
        } else {
          return 'Error';
        }
      }
    } catch (e) {
      return 'Error';
    }
  }

  static signOut({BuildContext context}) {
    SharedPreferencesService().clearUserInfo();
    NavigationService.navigateProcess(context: context, role: 'signIn');
  }

  static fetchChats(String userId, int roomId) async {
    String url =
        '$path/api/room/getRoomChats?userId=$userId&roomId=$roomId';
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    http.Response response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      // return json.decode(response.body);
      return response.body;
    }
  }

  // to get stream from api above
  static Stream chatStream(String userId, int roomId) async* {
    while (true) {
      await Future.delayed(Duration(milliseconds: 500));
      var chat = await fetchChats(userId, roomId);
      yield chat;
    }
  }

  static sendChat(VM_Chat vm_chat) async {
    final jsonString = json.encode(vm_chat.toJson());
    String url = '$path/api/chat/CreateChat';
    final headers = {HttpHeaders.contentTypeHeader: "application/json"};
    http.Response response =
        await http.post(url, headers: headers, body: jsonString);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    return false;
  }

  static getRoomsFiltered(String roleName, int branch) async {
    String url =
        '$path/api/room/TestRooms?roleName=$roleName&branch=$branch';
    final headers = {HttpHeaders.contentTypeHeader: "application/json"};
    http.Response response = await http.get(url, headers: headers);

    return json.decode(response.body);
  }

  // to get stream from getRoomsFiltered api
  static Stream getRoomsFilteredStream(String roleName, int branch) async* {
    while (true) {
      await Future.delayed(Duration(milliseconds: 1000));
      var chat = await getRoomsFiltered(roleName, branch);
      yield chat;
    }
  }

  static sendNotificationToSpecificBranch(
      {int branchId,
      Notifications notification,
      String state,
      String adminId}) async {
    final jsonString = json.encode(notification.toJson());
    final String url =
        '$path/api/notification/SendNotificationToSpecificBranch?branchId=$branchId&state=$state&adminId=$adminId';
    final headers = {HttpHeaders.contentTypeHeader: "application/json"};
    http.Response response =
        await http.post(url, headers: headers, body: jsonString);
    if (response.statusCode == 200) {
      if (json.decode(response.body) == true) {
        return true;
      }
      return false;
    }
    return false;
  }

  static sendNotificationToAllBranches(
      {Notifications notification, String adminId}) async {
    final jsonString = json.encode(notification.toJson());
    final String url =
        '$path/api/notification/SendNotificationToAllBranches?adminId=$adminId';
    final headers = {HttpHeaders.contentTypeHeader: "application/json"};
    http.Response response =
        await http.post(url, headers: headers, body: jsonString);

    if (response.statusCode == 200) {
      if (json.decode(response.body) == true) {
        return true;
      }
      return false;
    }
    return false;
  }

  static getUserNotification({String userId}) async {
    final String url =
        '$path/api/notification/GetUserNotification?userId=$userId';
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    http.Response response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
  }

  static setReadNotification(int userNotificationId) async {
    final String url =
        '$path/api/notification/SetReadNotification?userNotificationId=$userNotificationId';
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    http.Response response = await http.post(url, headers: headers);
  }

//  for individual chats
  static getUsersByBranch({String userId, int branchId}) async {
    final String url =
        '$path/api/user/GetUserByBranch?userId=$userId&branchId=$branchId';
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    http.Response response = await http.get(url, headers: headers);
    return json.decode(response.body);
  }

// ------------------ for individual chat --------------------

  static getOrCreateIndividualRoom({String userId, String recievedId}) async {
    final String url =
        '$path/api/chat/GetOrCreateIndividualRoom?userId=$userId&recievedId=$recievedId';
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    http.Response response = await http.post(url, headers: headers);
    return json.decode(response.body);
  }

  static sendIndividualMessage(
      {String Message, String senderId, int roomId}) async {
    final String url =
        '$path/api/chat/SendIndividualMessage?Message=$Message&senderId=$senderId&roomId=$roomId';
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    http.Response response = await http.post(url, headers: headers);
    return json.decode(response.body);
  }

  static getIndividualMessaged({int roomId}) async {
    final String url =
        '$path/api/chat/GetIndividualMessaged?roomId=$roomId';
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    http.Response response = await http.get(url, headers: headers);
    return json.decode(response.body);
  }

  static Stream getIndividualMessagedStream({int roomId}) async* {
    while (true) {
      await Future.delayed(Duration(milliseconds: 500));
      var chat = await getIndividualMessaged(roomId: roomId);
      yield chat;
    }
  }

  static getAllIndividualRoom(String userId) async {
    try {
      final String url =
          '$path/api/chat/GetAllIndividualRoom?userId=$userId';
      final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
      http.Response response = await http.get(url, headers: headers);

      return json.decode(response.body);
    } catch (e) {
      return null;
    }
  }

  static setAllNotification(String userId) async {
    final String url =
        '$path/api/notification/SetAllNotificationRead?userId=$userId';
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    await http.post(url, headers: headers);
  }
}
