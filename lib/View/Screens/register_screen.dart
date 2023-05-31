import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../Controllers/register_controller.dart';

register_Controller controller = Get.find();

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: controller.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text("Register",
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(fontSize: 35)),
            ),
            const SizedBox(
              height: 15,
            ),
            ImageProfile(),
            const SizedBox(
              height: 40,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildfirstname(context),
                const Spacer(),
                buildlastname(context),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            buildusername(context),
            const SizedBox(
              height: 15,
            ),
            buildemail(context),
            const SizedBox(
              height: 15,
            ),
            buildpassword(context),
            const SizedBox(
              height: 15,
            ),
            buildconfpassword(context),
            const SizedBox(
              height: 15,
            ),
            buildphonenumber(context),
            const SizedBox(
              height: 15,
            ),
            buildbirthdate(context),
            const SizedBox(
              height: 15,
            ),
            Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Gender:',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GetX<register_Controller>(
                      builder: (register_Controller controller) => InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: () => controller.switchGenderMale(),
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Theme.of(context).accentColor,
                            shape: BoxShape.circle,
                            border: controller.isMale.value
                                ? Border.all(
                                    color: Theme.of(context).primaryColor,
                                    width: 5)
                                : null,
                          ),
                          child: const Icon(
                            Icons.male,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GetX<register_Controller>(
                      builder: (register_Controller controller) => InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: () => controller.switchGenderFemale(),
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            shape: BoxShape.circle,
                            border: controller.isFemale.value
                                ? Border.all(
                                    color: Theme.of(context).primaryColor,
                                    width: 5)
                                : null,
                          ),
                          child: const Icon(
                            Icons.female,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            termAndCondaoitions(context),
            const SizedBox(
              height: 15,
            ),
            buildRegisterButton(context),
            const SizedBox(
              height: 15,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(
                      child: Divider(
                    color: Colors.black,
                    indent: 80,
                  )),
                  Text(
                    'OR',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const Expanded(
                      child: Divider(
                    color: Colors.black,
                    endIndent: 80,
                  )),
                ],
              ),
            ),
            SizedBox(height: 15,),
            buildRegisterWithGoogleButton(context),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildfirstname(context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "first name:",
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      const SizedBox(
        height: 10,
      ),
      Container(
        width: 150,
        alignment: Alignment.centerLeft,
        child: TextFormField(
          controller: controller.firstnameController,
          textAlign: TextAlign.start,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            hintText: 'First Name',
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColor, width: 1)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColor, width: 1)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColor, width: 1)),
            contentPadding: const EdgeInsets.all(10),
          ),
          validator: (val) {
            if (val!.isNum) {
              return 'Invalid Name';
            }
            if (val.isEmpty) {
              return 'Enter Your FirstName';
            }
          },
          onSaved: (val) {
            controller.firstname = val!;
          },
        ),
      ),
    ],
  );
}

Widget buildlastname(context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "last name:",
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      const SizedBox(
        height: 10,
      ),
      Container(
        width: 150,
        alignment: Alignment.centerLeft,
        child: TextFormField(
            controller: controller.lastnameController,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              hintText: 'Last Name',
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, width: 1)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, width: 1)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, width: 1)),
              contentPadding: const EdgeInsets.all(10),
            ),
            validator: (val) {
              if (val!.isNum) {
                return "Invalid Name";
              }
            },
            onSaved: (val) {
              controller.lastname = val!;
            }),
      )
    ],
  );
}

Widget buildusername(context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "user name:",
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      const SizedBox(
        height: 10,
      ),
      Container(
          alignment: Alignment.centerLeft,
          child: TextFormField(
            controller: controller.usernameController,
            decoration: InputDecoration(
              hintText: 'Username',
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, width: 1)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, width: 1)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, width: 1)),
              contentPadding: const EdgeInsets.all(10),
              suffixIcon: Icon(
                Icons.person,
                color: Theme.of(context).accentColor,
              ),
            ),
            validator: (val) {
              if (val!.isEmpty) {
                return 'This filed is required';
              }
            },
            onSaved: (val) {
              controller.username = val!;
            },
          ))
    ],
  );
}

Widget buildemail(context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "E-mail:",
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      const SizedBox(
        height: 10,
      ),
      Container(
        alignment: Alignment.centerLeft,
        child: TextFormField(
          controller: controller.emailController,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            hintText: 'E-mail',
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColor, width: 1)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColor, width: 1)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColor, width: 1)),
            contentPadding: const EdgeInsets.all(10),
            suffixIcon: Icon(
              Icons.email_outlined,
              color: Theme.of(context).accentColor,
            ),
          ),
          validator: (val) {
            if (!val!.isEmail) {
              return "Invalid Email";
            }
            if (val.isEmpty) {
              return 'Please Enter Your E-mail';
            }
          },
          onSaved: (val) {
            controller.email = val!;
          },
        ),
      )
    ],
  );
}

Widget buildpassword(context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "password:",
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      const SizedBox(
        height: 10,
      ),
      GetX(
        builder: (register_Controller controller) => Container(
          alignment: Alignment.centerLeft,
          child: TextFormField(
            obscureText: !controller.visibility.value,
            controller: controller.passwordController,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              hintText: 'Password',
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, width: 1)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, width: 1)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, width: 1)),
              contentPadding: const EdgeInsets.all(10),
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
            ),
            validator: (val) {
              if (val!.isEmpty) {
                return "This field is required";
              }
              if (val!.length! < 8) {
                return "PassWord can't be less than 8 Characters";
              }
            },
            onSaved: (val) {
              controller.password = val!;
            },
          ),
        ),
      )
    ],
  );
}

Widget buildconfpassword(context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "confirm password:",
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      const SizedBox(
        height: 10,
      ),
      Container(
        alignment: Alignment.centerLeft,
        child: GetX(
          builder: (register_Controller controller) => TextFormField(
            obscureText: !controller.visibilityConfirm.value,
            controller: controller.confpasswordController,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
              hintText: 'ConfirmPassword',
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, width: 1)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, width: 1)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, width: 1)),
              contentPadding: const EdgeInsets.all(10),
              suffixIcon: IconButton(
                onPressed: () => controller.switchVisibilityConfirm(),
                icon: controller.visibilityConfirm.value
                    ? Icon(
                        Icons.visibility_outlined,
                        color: Theme.of(context).primaryColor,
                      )
                    : Icon(Icons.visibility_off_outlined,
                        color: Theme.of(context).accentColor),
              ),
            ),
            validator: (val) {
              if (val!.isEmpty) {
                return "This field is required";
              }
              if (val != controller.passwordController.text) {
                return "PassWord does not match";
              }
            },
            onSaved: (val) {
              controller.confpassword = val!;
            },
          ),
        ),
      )
    ],
  );
}

Widget buildphonenumber(context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "phone number:",
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      const SizedBox(
        height: 10,
      ),
      Container(
        alignment: Alignment.centerLeft,
        child: TextFormField(
          controller: controller.phonenumController,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            hintText: 'Phone Number',
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColor, width: 1)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColor, width: 1)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColor, width: 1)),
            contentPadding: const EdgeInsets.all(10),
            suffixIcon: Icon(
              Icons.phone_in_talk_outlined,
              color: Theme.of(context).accentColor,
            ),
          ),
          validator: (val) {
            if (!val!.isNum && val.isNotEmpty) {
              return "Invalid phoneNumber";
            }
          },
          onSaved: (val) {
            controller.phonenumber = val!;
          },
        ),
      )
    ],
  );
}

Widget buildbirthdate(context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "birthday date:",
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      const SizedBox(
        height: 10,
      ),
      InkWell(
        onTap: () => controller.selectDate(),
        child: GetX(
          builder: (register_Controller controller) => Container(
            alignment: Alignment.centerLeft,
            child: TextFormField(
              enabled: false,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: DateFormat('dd-MM-yyyy')
                    .format(controller.SelectedDate.value)
                    .toString(),
                filled: true,
                fillColor: Colors.grey.shade100,
                disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1)),
                contentPadding: const EdgeInsets.all(10),
                suffixIcon: Icon(
                  Icons.date_range_outlined,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
          ),
        ),
      )
    ],
  );
}

Widget ImageProfile() {
  return Column(
    children: [
      const SizedBox(
        height: 25,
      ),
      Stack(
        children: <Widget>[
          GetX(
            builder: (register_Controller controller) => CircleAvatar(
              backgroundColor: Colors.white,
              radius: 85.0,
              backgroundImage: controller.fileImage!.value != null
                  ? FileImage(controller.fileImage!.value)
                  : null,
            ),
          ),
          Positioned(
              bottom: 20.0,
              right: 20.0,
              child: InkWell(
                onTap: () {
                  Get.bottomSheet(
                      backgroundColor: const Color(0xffF2E7FE), bottomsheet());
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffF2E7FE),
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: Color(0xff4c5166),
                    size: 30.0,
                  ),
                ),
              ))
        ],
      ),
    ],
  );
}

Widget bottomsheet() {
  return Container(
    height: 100.0,
    width: double.infinity,
    margin: const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 20,
    ),
    child: Column(
      children: <Widget>[
        const Text(
          'Choose Profile Photo',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              child: Column(
                children: [Icon(Icons.camera_alt), Text('Take Picutre')],
              ),
              onPressed: controller.takePhoto,
            ),
            MaterialButton(
              child: Column(
                children: [Icon(Icons.photo), Text('Pick Picture')],
              ),
              onPressed: controller.gitPhoto,
            ),
            MaterialButton(
              child: Column(
                children: [Icon(Icons.delete), Text('Delete Picutre')],
              ),
              onPressed: controller.deletePhoto,
            )
          ],
        ),
      ],
    ),
  );
}

Widget buildRegisterButton(context) {
  return GetX(
      builder: (register_Controller controller) => Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: controller.isLoading.value?Center(child: CupertinoActivityIndicator(color: Theme.of(context).primaryColor),):MaterialButton(
              onPressed: controller.submitRegister,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              color: Theme.of(context).accentColor,
              padding: const EdgeInsets.all(15),
              child: const Text("Register",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ),
          ));
}

Widget buildRegisterWithGoogleButton(context) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 25),
    child: MaterialButton(
      elevation: 5,
      onPressed: () {},
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      color: Colors.white,
      padding: const EdgeInsets.all(15),
      child:
          Row(children: [
        Image.asset('asset/image/Google.png', scale: 3),
        SizedBox(width: 50,),
        const Text("Register with Google",
            style: TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.bold)),
      ]),
    ),
  );
}

Widget termAndCondaoitions(context) {
  return GetX(
    builder: (register_Controller controller) {
      return Container(
        alignment: Alignment.center,
        child: Row(
          children: [
            Checkbox(
                activeColor: Theme.of(context).primaryColor,
                value: controller.isChecked.value,
                onChanged: (val) => controller.Check(val)),
            TextButton(
              child: Text("Terms and Condition",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                      decoration: TextDecoration.underline)),
              onPressed: () {},
            ),
          ],
        ),
      );
    },
  );
}
