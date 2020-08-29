import 'dart:typed_data';

import 'package:card_settings/widgets/action_fields/card_settings_button.dart';
import 'package:card_settings/widgets/card_settings_panel.dart';
import 'package:card_settings/widgets/card_settings_widget.dart';
import 'package:card_settings/widgets/information_fields/card_settings_header.dart';
import 'package:card_settings/widgets/numeric_fields/card_settings_switch.dart';
import 'package:card_settings/widgets/picker_fields/card_settings_file_picker.dart';
import 'package:card_settings/widgets/text_fields/card_settings_email.dart';
import 'package:card_settings/widgets/text_fields/card_settings_paragraph.dart';
import 'package:card_settings/widgets/text_fields/card_settings_text.dart';
import 'package:chatapp/business_logic/utils/local.dart';
import 'package:chatapp/business_logic/utils/universal_variables.dart';
import 'package:chatapp/business_logic/view_models/profile_screen_viewmodel.dart';
import 'package:chatapp/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';



class ProfileScreen extends StatefulWidget {

  ProfileScreen();

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<ProfileScreen> {

  ProfileScreenViewModel model  = serviceLocator<ProfileScreenViewModel>();

  @override
  void initState() {
    model.loadData();
    super.initState();
  }

  String name = "Name";
  String lastName = "Last Name";
  String email = "s.abdulakhatov@gmail.com";
  Uint8List photo;
  FocusNode _descriptionNode = FocusNode();

  bool _autoValidate = false;

  Future savePressed() async {
    final form = model.formKey.currentState;

    if (form.validate()) {
      form.save();
      // showResults(context, _ponyModel);
    } else {
      // showErrors(context);
      setState(() => _autoValidate = true);
    }
  }

  CardSettingsButton _buildCardSettingsButtonSave() {
    return CardSettingsButton(
      label: 'SAVE',
      backgroundColor: Colors.green,
      onPressed: savePressed,
    );
  }

  Widget getFormFields(){
    return Form(
      key: model.formKey,
      child: CardSettings(
        children: <CardSettingsSection>[
          CardSettingsSection(
            header: CardSettingsHeader(
              label: 'Bio',
            ),
            children: <CardSettingsWidget>[
              CardSettingsText(
                label: 'Name',
                initialValue: name,
                validator: (value) {
                  return (value == null || value.isEmpty) ? 'Name is required.' : '';
                },
                onSaved: (value) => name = value,
              ),
              CardSettingsText(
                label: 'Last Name',
                initialValue: lastName,
                validator: (value) {
                  return (value == null || value.isEmpty) ? 'Name is required.' : '';
                },
                onSaved: (value) => lastName = value,
              ),
              CardSettingsEmail(
                label: 'Email',
                initialValue: email,
                validator: (value) {
                  return (value == null || value.isEmpty) ? 'Email is required.' : '';
                },
                onSaved: (value) => lastName = value,
              ),
              CardSettingsFilePicker(
                key: model.photoKey,
                icon: Icon(Icons.photo),
                label: 'Photo',
                fileType: FileType.image,
                initialValue: photo,
                onSaved: (value) => photo = value,
                onChanged: (value) {
                  setState(() {
                    photo = value;
                  });
                },
              ),
              CardSettingsParagraph(
                key: model.descriptionKey,
                label: 'Description',
                initialValue: Local.user.description,
                numberOfLines: 5,
                focusNode: _descriptionNode,
                onSaved: (value) => Local.user.description = value,
                onChanged: (value) {
                  setState(() {
                    Local.user.description = value;
                  });
                  // widget.onValueChanged('Description', value);
                },
              ),
              CardSettingsSwitch(
                  key: model.hasKnowledgeKey,
                  label: 'Has Knowledge?',
                  initialValue: Local.user.hasKnowledge,
                  onSaved: (value) => Local.user.hasKnowledge = value,
                  onChanged: (value) {
                    setState(() {
                      Local.user.hasKnowledge = value;
                    });
                    // widget.onValueChanged('Has Spots?', value);
                  }
              )
            ],
          ),
          CardSettingsSection(
            header: CardSettingsHeader(
              label: 'Actions',
            ),
            children: <CardSettingsWidget>[
              _buildCardSettingsButtonSave(),
            ],
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileScreenViewModel>(
      create: (context) => model,
      child: Consumer<ProfileScreenViewModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_left),
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: Text('Edit Profile'),
          ),
          body: getFormFields()
          // body: Builder(
          //   builder: (context) =>  Container(
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       children: <Widget>[
          //         SizedBox(
          //           height: 20.0,
          //         ),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: <Widget>[
          //             Align(
          //               alignment: Alignment.center,
          //               child: CircleAvatar(
          //                 radius: 100,
          //                 backgroundColor: Color(UniversalVariables.primeColor),
          //                 child: ClipOval(
          //                   child: new SizedBox(
          //                     width: 180.0,
          //                     height: 180.0,
          //                     child: (model.imageUrl != null) ? Image.network(
          //                       model.imageUrl,
          //                       fit: BoxFit.fill,
          //                     ) : Icon(
          //                       Icons.account_circle,
          //                       color: Colors.blueGrey,
          //                       size: 180.0,
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //             Padding(
          //               padding: EdgeInsets.only(top: 60.0),
          //               child: IconButton(
          //                 icon: Icon(
          //                   Icons.camera,
          //                   size: 30.0,
          //                 ),
          //                 onPressed: () {
          //                   model.getImage();
          //                 },
          //               ),
          //             ),
          //           ],
          //         ),
          //         SizedBox(
          //           height: 20.0,
          //         ),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //           children: <Widget>[
          //             Align(
          //               alignment: Alignment.centerLeft,
          //               child: Container(
          //                 child: Column(
          //                   children: <Widget>[
          //                     Align(
          //                       alignment: Alignment.centerLeft,
          //                       child: Text('Username',
          //                           style: TextStyle(
          //                               color: Colors.blueGrey, fontSize: 18.0)),
          //                     ),
          //                     Align(
          //                       alignment: Alignment.centerLeft,
          //                       child: Text('Michelle James',
          //                           style: TextStyle(
          //                               color: Colors.black,
          //                               fontSize: 20.0,
          //                               fontWeight: FontWeight.bold)),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //             Align(
          //               alignment: Alignment.centerRight,
          //               child: Container(
          //                 child: Icon(
          //                   Icons.edit,
          //                   color: Color(0xff476cfb),
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //         SizedBox(
          //           height: 20.0,
          //         ),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //           children: <Widget>[
          //             Align(
          //               alignment: Alignment.centerLeft,
          //               child: Container(
          //                 child: Column(
          //                   children: <Widget>[
          //                     Align(
          //                       alignment: Alignment.centerLeft,
          //                       child: Text('Birthday',
          //                           style: TextStyle(
          //                               color: Colors.blueGrey, fontSize: 18.0)),
          //                     ),
          //                     Align(
          //                       alignment: Alignment.centerLeft,
          //                       child: Text('1st April, 2000',
          //                           style: TextStyle(
          //                               color: Colors.black,
          //                               fontSize: 20.0,
          //                               fontWeight: FontWeight.bold)),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //             Align(
          //               alignment: Alignment.centerRight,
          //               child: Container(
          //                 child: Icon(
          //                   Icons.edit,
          //                   color: Color(0xff476cfb),
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //         SizedBox(
          //           height: 20.0,
          //         ),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //           children: <Widget>[
          //             Align(
          //               alignment: Alignment.centerLeft,
          //               child: Container(
          //                 child: Column(
          //                   children: <Widget>[
          //                     Align(
          //                       alignment: Alignment.centerLeft,
          //                       child: Text('Location',
          //                           style: TextStyle(
          //                               color: Colors.blueGrey, fontSize: 18.0)),
          //                     ),
          //                     Align(
          //                       alignment: Alignment.centerLeft,
          //                       child: Text('Paris, France',
          //                           style: TextStyle(
          //                               color: Colors.black,
          //                               fontSize: 20.0,
          //                               fontWeight: FontWeight.bold)),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ),
          //             Align(
          //               alignment: Alignment.centerRight,
          //               child: Container(
          //                 child: Icon(
          //                   Icons.edit,
          //                   color: Color(0xff476cfb),
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //         Container(
          //           margin: EdgeInsets.all(20.0),
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.start,
          //             children: <Widget>[
          //               Text('Email',
          //                   style:
          //                   TextStyle(color: Colors.blueGrey, fontSize: 18.0)),
          //               SizedBox(width: 20.0),
          //               Text('michelle123@gmail.com',
          //                   style: TextStyle(
          //                       color: Colors.black,
          //                       fontSize: 20.0,
          //                       fontWeight: FontWeight.bold)),
          //             ],
          //           ),
          //         ),
          //         SizedBox(
          //           height: 20.0,
          //         ),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //           children: <Widget>[
          //             RaisedButton(
          //               color: Color(UniversalVariables.primeColor),
          //               onPressed: () {
          //                 model.uploadPic().then((value){
          //                   Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
          //                 });
          //               },
          //
          //               elevation: 4.0,
          //               splashColor: Colors.blueGrey,
          //               child: Text(
          //                 'Save',
          //                 style: TextStyle(color: Colors.white, fontSize: 16.0),
          //               ),
          //             ),
          //
          //           ],
          //         )
          //       ],
          //     ),
          //   ),
          // ),
        ),
      ),
    );
  }

}

