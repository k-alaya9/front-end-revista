import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:revista/Controllers/logincontroller.dart';
import 'package:revista/View/Screens/forgetpasswordscreen.dart';

import '../../Services/apis/login_api.dart';

class bottomSheet extends StatelessWidget {
  bottomSheet({Key? key}) : super(key: key);
  LoginController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom / 10),
      child: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20, right: 255),
                child: Text(
                  'Login',
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith( fontSize: 35),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                margin: const EdgeInsets.only(right: 270),
                child: Text(
                  'Username',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1,
                ),
              ),
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: GetBuilder(
                    builder: (LoginController controller) => TextFormField(
                      controller: controller.usernameController,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      cursorColor: Theme.of(context).accentColor,
                      decoration: InputDecoration(
                        suffixIcon: controller.usernameController.text.isNotEmpty
                            ? IconButton(
                                onPressed: () => controller.clearUsername(),
                                icon: Icon(
                                  Icons.close,
                                  color: Theme.of(context).accentColor,
                                ))
                            : null,
                        hintText: 'Enter Your Username...',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.grey.shade500),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor, width: 1),
                            borderRadius: BorderRadius.circular(30)),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        focusColor: Theme.of(context).primaryColor,
                        contentPadding: const EdgeInsets.all(10),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor, width: 1),
                            borderRadius: BorderRadius.circular(30)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor, width: 1),
                            borderRadius: BorderRadius.circular(30)),
                      ),
                      validator: (val){
                        if(val!.isEmpty){
                          return "Please Enter Your Username";
                        }
                        else if(val.length<4){
                          return"Username should be at least 4 characters";
                        }
                        return null;
                      },
                      onSaved: (val){
                        controller.username=val!;
                      },
                    ),
                  )),
              Container(
                margin: const EdgeInsets.only(right: 270),
                child: Text(
                  'Password',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1,
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(25,5,25,0),
                child: GetBuilder(
                    builder: (LoginController controller) => TextFormField(
                          controller: controller.passwordController,
                          obscureText: !controller.visibility.value,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1,
                          keyboardType: TextInputType.visiblePassword,
                          autocorrect: false,
                          cursorColor: Theme.of(context).accentColor,
                          decoration: InputDecoration(
                            hintText: 'Enter Your Password...',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.grey.shade500),
                            suffixIcon: IconButton(
                              onPressed: () => controller.switchVisibility(),
                              icon: controller.visibility.value
                                  ? Icon(
                                      Icons.visibility_outlined,
                                      color: Theme.of(context).primaryColor,
                                    )
                                  : Icon(Icons.visibility_off_outlined,
                                      color: Theme.of(context).accentColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 1),
                                borderRadius: BorderRadius.circular(30)),
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            focusColor: Theme.of(context).primaryColor,
                            contentPadding: const EdgeInsets.all(10),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 1),
                                borderRadius: BorderRadius.circular(30)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 1),
                                borderRadius: BorderRadius.circular(30)),
                          ),
                      validator: (val){
                            if(val!.length<8){
                              return "Password is too short";
                            }
                            return null;
                      },
                      onSaved: (val){
                        controller.password=val!;
                      },
                        ),),
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 200,
                ),
                child: TextButton(
                  onPressed: () {
                    Get.toNamed('/forgetpass');
                  },
                  style: ButtonStyle(
                      animationDuration: Duration(seconds: 1),
                      elevation: MaterialStateProperty.all(0),
                      splashFactory: NoSplash.splashFactory),
                  child: Text('Forgotten Password ?',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Theme.of(context).accentColor,
                          fontSize: 13,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              //login button
              GetX<LoginController>(
                builder: (LoginController controller) => Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(25, 0, 25, 8),
                  child: controller
                      .onLoading.value
                      ? Center(
                        child: CupertinoActivityIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                      )
                      : ElevatedButton(
                    onPressed: () {
                      controller.submitFunc();
                    },
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor: MaterialStateProperty.all(
                           Theme.of(context).primaryColor),
                        shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)))),
                    child: Text('Login',
                        style: Theme.of(context).textTheme.bodyText1),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
