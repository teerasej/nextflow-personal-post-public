import 'package:flutter/material.dart';
import 'package:nextflow_personal_post/provider/post_provider.dart';
import 'package:provider/provider.dart';

class NewPostPage extends StatelessWidget {
  NewPostPage({Key key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final postMessageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('สร้างโพสใหม่')),
      body: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  controller: postMessageController,
                  autofocus: true,
                  maxLines: 3,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'คุณกำลังทำอะไรอยู่',
                  ),
                  validator: (String text) {
                    if (text.isNotEmpty)
                      return null;
                    else
                      return "ยังไม่ได้กรอกข้อความ";
                  },
                )),
            Expanded(
              child: SizedBox(),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: SizedBox(
                  width: double.maxFinite,
                  child: RaisedButton(
                      child: Text('โพส'),
                      onPressed: () {
                        // ถ้า validate แล้วผ่าน จะคืนค่าเป็น true
                        if (formKey.currentState.validate()) {
                          var message = postMessageController.text;
                          print(message);

                          Provider.of<PostProvider>(context, listen: false)
                              .addNewPost(message);
                          Navigator.pop(context);
                        }
                      })),
            )
          ],
        ),
      ),
    );
  }
}
