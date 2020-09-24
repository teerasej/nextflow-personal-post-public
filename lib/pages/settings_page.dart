import 'package:flutter/material.dart';
import 'package:nextflow_personal_post/provider/post_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: Container(
          padding: EdgeInsets.all(8),
          child: RaisedButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('แน่ใจหรือ?'),
                      content: Text('นี่จะเป็นการลบข้อมูลทั้งหมดในไทม์ไลน์'),
                      actions: [
                        FlatButton(
                          onPressed: () {
                            Provider.of<PostProvider>(context, listen: false)
                                .clearAllPost();
                            Navigator.pop(context);
                          },
                          child: Text('ยืนยัน'),
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('ยกเลิก'),
                        ),
                      ],
                    );
                  });
            },
            child: Text('ลบข้อมูลทั้งหมด'),
          ),
        ));
  }
}
