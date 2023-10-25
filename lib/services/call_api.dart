// ไฟล์นี้เป็นไฟล์ที่ใช้ในการเรียกใช้ api ต่างๆ

// ignore_for_file: unused_local_variable, unused_import

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:my_diaryfood_app/models/diaryfood.dart';

class callApi{
  // เมธอดเรียกใช้ API : getall
  static Future<List<Diaryfood>> callAPIGetAllDiaryfood() async {
    final response = await http.get(
      Uri.parse('http://172.17.36.32/diaryfoodapi/getall'),
      headers: {'Content-Type':'application/json'},
    );

    if(response.statusCode == 200){
      // เอาข้อมูลที่ส่งกลับมาเป็น JSON แปลงเป็นข้อมูลที่จะนำมาใช้ในแอปฯ เก็บตัวแปร
      final responseData = jsonDecode(response.body);

      // แปลงข้อมูลที่เก็บในตัวแปรให้อยู่ในรูปของ List เพื่อนำไปใช้งาน
      final diaryfoodDataList = await responseData.map<Diaryfood>((json){
        return Diaryfood.fromJson(json);
      }).toList();

      // ส่งค่าข้อมูลที่เก็บในตัวแปร List กลับไป ณ จุดที่เรียกใช้เมธอดนี้ เพื่อนำข้อมูลไปใช้งาน
        return diaryfoodDataList;
      } else {
        throw Exception('Failed to fetch data');
      }
    }

  // เมธอดเรียกใช้ API : insert
  static Future<String> callAPIInsertDiaryfood(Diaryfood diaryfood) async {
    // เรียกใช้ API
    final response = await http.post(
      Uri.parse('http://172.17.36.32/diaryfoodapi/insert'),
      body: jsonEncode(diaryfood.toJson()),
      headers: {'Content-Type':'application/json'},
    );

    if (response.statusCode == 200){
      // เอาข้อมูลที่ส่งกลับมาเป็น JSON แปลงเป็นข้อมูลที่จะนำมาใช้ในแอปฯ เก็บตัวแปร
      final responseData = jsonDecode(response.body);

      // ส่งค่าข้อมูลที่ส่งกลับมาไปที่จุดเรียกเมธอด
      return responseData['message'];
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  // เมธอดเรียกใช้ API : update
  static Future<Diaryfood> callAPIUpdateDiaryfood(Diaryfood diaryfood) async {
    
    // เรียกใช้ API
    final response = await http.post(
      Uri.parse('http://172.17.36.32/diaryfoodapi/update'),
      body: jsonEncode(diaryfood.toJson()),
      headers: {'Content-Type':'application/json'},
    );

    if (response.statusCode == 200){
      // เอาข้อมูลที่ส่งกลับมาเป็น JSON แปลงเป็นข้อมูลที่จะนำมาใช้ในแอปฯ เก็บตัวแปร
      final responseData = jsonDecode(response.body);

      // ส่งค่าข้อมูลที่ส่งกลับมาไปที่จุดเรียกเมธอด
      return responseData['message'];
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  // เมธอดเรียกใช้ API : delete
  static Future<Diaryfood> callAPIDeleteDiaryfood(Diaryfood diaryfood) async {
    
    // เรียกใช้ API
    final response = await http.post(
      Uri.parse('http://172.17.36.32/diaryfoodapi/delete'),
      body: jsonEncode(diaryfood.toJson()),
      headers: {'Content-Type':'application/json'},
    );

    if (response.statusCode == 200){
      // เอาข้อมูลที่ส่งกลับมาเป็น JSON แปลงเป็นข้อมูลที่จะนำมาใช้ในแอปฯ เก็บตัวแปร
      final responseData = jsonDecode(response.body);

      // ส่งค่าข้อมูลที่ส่งกลับมาไปที่จุดเรียกเมธอด
      return responseData['message'];
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}