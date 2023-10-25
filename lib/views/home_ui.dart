// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_diaryfood_app/models/diaryfood.dart';
import 'package:my_diaryfood_app/services/call_api.dart';
import 'package:my_diaryfood_app/views/add_diaryfood_ui.dart';

class HomeUI extends StatefulWidget {
  const HomeUI({super.key});

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  // สร้างตัวแปรเก็บข้อมูลที่ได้จากการเรียกใช้ API
  Future<List<Diaryfood>>? diaryfoodDataList;

  // สร้างเมธอดที่เรียกใช้เมธอดที่เรียกใช้ API
  getAllDiaryfood() {
    setState(() {
      diaryfoodDataList = callApi.callAPIGetAllDiaryfood();
    });
  }

  // อะไรก็ตามที่อยู่ในเมธอด initState จะทำงาน
  @override
  void initState() {
    getAllDiaryfood();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'My Diary Food',
          style: GoogleFonts.kanit(),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            //เปิดไปหน้า AddDiaryfoodUI แบบย้อนกลับได้
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddDiaryfoodUI(),
              ),
            );
          },
          child: Icon(
            Icons.add,
          ),
          backgroundColor: Colors.green),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Center(
        child: Column(
          children: [
            //แสดงรูปที่เตรียมไว้
            Image.asset(
              'assets/images/banner.jpg',
              fit: BoxFit.cover,
            ),
            //แสดงข้อมูลรายการกินที่ get มาจาก data ที่ Sever ในรูป ListView
            Expanded(
              child: FutureBuilder(
                future: callApi.callAPIGetAllDiaryfood(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    // เอาข้อมูลใส่ ListView โดยการตรวจสอบ message
                    if (snapshot.data[0].message == '0') {
                      return Center(
                        child: Text(
                          'ยังไม่มีข้อมูล',
                          style: GoogleFonts.kanit(),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        // นับจำนวนข้อมูลที่จะแสดงใน ListView
                        itemCount: snapshot.data.length,
                        // Layout ของ ListView ที่เราจะสร้าง
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              snapshot.data[index].foodShopname,
                            ),
                          );
                        },
                      );
                    }
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text(
                          'มีข้อผิดพลาด',
                          style: GoogleFonts.kanit(),
                        ),
                      );
                  }

                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.green,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
