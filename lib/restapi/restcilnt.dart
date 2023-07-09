import 'dart:convert';
import 'package:d7/style/style.dart';
import 'package:http/http.dart' as http;

Future<bool> productCreateRequest(formValues) async {
  // ignore: non_constant_identifier_names
  var url = Uri.parse("https://crud.teamrabbil.com/api/v1/CreateProduct");
  var postBody = jsonEncode(formValues);
  var postHeader = {"Content-Type": "application/json"};

  var response = await http.post(url, headers: postHeader, body: postBody);
  var resultCode = response.statusCode;
  var resultBody = json.decode(response.body);
  if (resultCode == 200 && resultBody['status'] == "success") {
    successToast("Request Success");
    return true;
  } else {
    errorToast('Failed');
    return false;
  }
}

Future<List> productGridviewListRequest() async {
  var url = Uri.parse("https://crud.teamrabbil.com/api/v1/ReadProduct");
  var postHeader = {"Content-Type": "application/json"};
  var response = await http.get(url, headers: postHeader);
  var resultCode = response.statusCode;
  var resultBody = json.decode(response.body);
  if (resultCode == 200 && resultBody['status'] == "success") {
    successToast("Request Success");
    return resultBody['data'];
  } else {
    errorToast('Failed');
    return [];
  }
}

Future<bool> deletePoductRequest(id) async {
  // ignore: prefer_interpolation_to_compose_strings
  var url = Uri.parse("https://crud.teamrabbil.com/api/v1/DeleteProduct/" + id);
  var postHeader = {"Content-Type": "application/json"};
  var response = await http.get(url, headers: postHeader);
  var resultCode = response.statusCode;
  var resultBody = json.decode(response.body);
  if (resultCode == 200 && resultBody['status'] == "success") {
    successToast("Request Success");
    return true;
  } else {
    errorToast('Failed');
    return false;
  }
}

Future<bool> productUpdateRequest(formValues, id) async {
  // ignore: prefer_interpolation_to_compose_strings
  var url = Uri.parse("https://crud.teamrabbil.com/api/v1/UpdateProduct/" + id);
  var postBody = jsonEncode(
    formValues,
  );
  var postHeader = {"Content-Type": "application/json"};

  var response = await http.post(url, headers: postHeader, body: postBody);
  var resultCode = response.statusCode;
  var resultBody = json.decode(response.body);
  if (resultCode == 200 && resultBody['status'] == "success") {
    successToast("Request Success");
    return true;
  } else {
    errorToast('Failed');
    return false;
  }
}
