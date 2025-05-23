// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foodtek/constant/colors.dart';
import 'package:foodtek/view/widgets/auth/foodtek_button.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/responseve.dart';
import '../../../widgets/auth/custom_text_felid_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final ImagePicker picker = ImagePicker();
  XFile? image;

  TextEditingController txtName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtMobile = TextEditingController();
  TextEditingController txtAddress = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtConfirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          AppLocalizations.of(context)!.profile,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge?.color,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  image = await picker.pickImage(source: ImageSource.gallery);
                  setState(() {});
                },
                child: CircleAvatar(
                  radius: 60,
                  child:
                      image != null
                          ? ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.file(
                              File(image!.path),
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          )
                          : Image.asset(
                            "assets/images/profile/img_7.png",
                            width: 120,
                            height: 120,
                            fit: BoxFit.fill,
                          ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Ahmad Daboor",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Theme.of(context).textTheme.bodyLarge?.color),
              ),
              SizedBox(height: 10),
              Text(
                "ahmad1709@gmail.com",
                style: TextStyle(fontSize: 14, color: Theme.of(context).textTheme.bodySmall?.color),
              ),
              SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.black.withOpacity(0.1),
                  //     blurRadius: 6,
                  //     spreadRadius: 2,
                  //   ),
                  // ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 20,
                        ),
                        child: CustomTextFelidWidget(
                          label: AppLocalizations.of(context)!.user_name,
                          hintText: AppLocalizations.of(context)!.enter_name,
                          controller: txtName,
                          type: TextInputType.name,
                          obscure: false,
                          onChange: (value) {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 20,
                        ),
                        child: CustomTextFelidWidget(
                          label: AppLocalizations.of(context)!.email,
                          obscure: false,
                          type: TextInputType.emailAddress,
                          hintText:
                              AppLocalizations.of(context)!.enter_your_email,
                          controller: txtEmail,
                          onChange: (value) {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 20,
                        ),
                        child: CustomTextFelidWidget(
                          obscure: false,
                          label: AppLocalizations.of(context)!.phone_number,
                          type: TextInputType.phone,

                          hintText: AppLocalizations.of(context)!.enter_mobile,
                          controller: txtMobile,
                          onChange: (value) {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 20,
                        ),
                        child: CustomTextFelidWidget(
                          type: TextInputType.text,
                          label: AppLocalizations.of(context)!.password,
                          obscure: true,

                          hintText: "* * * * * *",

                          controller: txtPassword,
                          onChange: (value) {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 20,
                        ),
                        child: CustomTextFelidWidget(
                          type: TextInputType.text,
                          label: AppLocalizations.of(context)!.address,
                          obscure: false,
                          hintText: AppLocalizations.of(context)!.enter_address,
                          controller: txtAddress,
                          onChange: (value) {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FoodtekButton(
                  onPressed: () {},
                  text: AppLocalizations.of(context)!.update,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
