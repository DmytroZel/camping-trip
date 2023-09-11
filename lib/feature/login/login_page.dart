import 'package:camp_trip/common/extension/stream_subscription_extensions.dart';
import 'package:camp_trip/feature/login/login_vm.dart';
import 'package:camp_trip/feature/login/widget/choose_gender.dart';
import 'package:camp_trip/feature/login/widget/register_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

import '../../common/base/base_state.dart';
import '../../gen/assets.gen.dart';
import '../../gen/colors.gen.dart';
import '../../routers/screen_names.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BaseState<LoginPage> {
  late String animationURL;
  Artboard? _teddyArtboard;
  SMITrigger? successTrigger, failTrigger;
  SMIBool? isHandsUp, isChecking;
  SMINumber? numLook;

  StateMachineController? stateMachineController;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  FocusNode _focusPass = FocusNode();
  FocusNode _focusEmail = FocusNode();

  @override
  void initState() {
    _subForGoMain();
    _subForLoginRes();
    subForShowErrorMassage();
    _subForShowRegisterMassage();
    super.initState();

    _focusEmail.addListener(() {
      if (_focusEmail.hasFocus == false) {
        isChecking?.change(false);
        // isHandsUp?.change(false);
      }
    });
    _focusPass.addListener(() {
      if (_focusPass.hasFocus == false) {
        // isChecking?.change(false);
        isHandsUp?.change(false);
      }
    });

    animationURL = Assets.animations.login;
    rootBundle.load(animationURL).then(
      (data) {
        final file = RiveFile.import(data);
        final artboard = file.mainArtboard;
        stateMachineController =
            StateMachineController.fromArtboard(artboard, "Login Machine");
        if (stateMachineController != null) {
          artboard.addController(stateMachineController!);

          stateMachineController!.inputs.forEach((e) {
            debugPrint(e.runtimeType.toString());
            debugPrint("name${e.name}End");
          });

          stateMachineController!.inputs.forEach((element) {
            if (element.name == "trigSuccess") {
              successTrigger = element as SMITrigger;
            } else if (element.name == "trigFail") {
              failTrigger = element as SMITrigger;
            } else if (element.name == "isHandsUp") {
              isHandsUp = element as SMIBool;
            } else if (element.name == "isChecking") {
              isChecking = element as SMIBool;
            } else if (element.name == "numLook") {
              numLook = element as SMINumber;
            }
          });
        }
        setState(() => _teddyArtboard = artboard);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<LoginVm>(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.lightBlueAccent.withOpacity(0.5),
          ),
          Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SvgPicture.asset(
                Assets.icons.loginBg.path,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.2),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                  alignment: Alignment.center,
                  width: 400,
                  padding: const EdgeInsets.only(bottom: 15),
                  margin: const EdgeInsets.only(bottom: 15 * 4),
                  decoration: BoxDecoration(
                    color: ColorName.loginBG,
                    border: Border.all(color: Colors.lightBlueAccent),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Stack(
                      children: [
                        Visibility(
                          visible: vm.showRegisterPage,
                          child: GestureDetector(
                            onTap: () {
                              vm.onRegisterTap();
                            },
                            child: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            if (_teddyArtboard != null)
                              SizedBox(
                                width: 400,
                                height: 300,
                                child: Rive(
                                  artboard: _teddyArtboard!,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            TextField(
                              focusNode: _focusEmail,
                              onTap: lookOnTheTextField,
                              controller: _emailController,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor:
                                      Colors.lightBlue.withOpacity(0.8),
                                  disabledBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 0),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 0),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 0),
                                  ),
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 0),
                                  ),
                                  labelText: 'Email',
                                  labelStyle:
                                      const TextStyle(color: Colors.white),
                                  hintStyle:
                                      const TextStyle(color: Colors.white),
                                  helperStyle:
                                      const TextStyle(color: Colors.white),
                                  hintText: 'Enter your email address'),
                              onChanged: moveEyeBalls,
                            ),
                            Visibility(
                              visible: vm.showRegisterPage,
                              child: const SizedBox(
                                height: 20,
                              ),
                            ),
                            Visibility(
                                visible: vm.showRegisterPage,
                                child: RegisterTextField(
                                  title: 'User Name',
                                  hint: 'User name',
                                  onChanged: vm.onUserNameChanged,
                                )),
                            Visibility(
                              visible: vm.showRegisterPage,
                              child: const SizedBox(
                                height: 20,
                              ),
                            ),
                            Visibility(
                              visible: vm.showRegisterPage,
                              child: ChooseGender(
                                isMale: vm.sex,
                                onGenderChanged: (bool value) {
                                  vm.onGenderChanged(value);
                                  successTrigger?.fire();
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextField(
                              focusNode: _focusPass,
                              controller: _passwordController,
                              obscureText: vm.showPassword,
                              onTap: handsOnTheEyes,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor:
                                      Colors.lightBlue.withOpacity(0.8),
                                  disabledBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 0),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 0),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 0),
                                  ),
                                  border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        color: Colors.transparent, width: 0),
                                  ),
                                  hintStyle:
                                      const TextStyle(color: Colors.white),
                                  labelStyle:
                                      const TextStyle(color: Colors.white),
                                  labelText: 'Password',
                                  hintText: 'Enter your secure password',
                                  suffixIcon: GestureDetector(
                                      onTap: () {
                                        vm.onShowPasswordTap();
                                      },
                                      child: Icon(vm.showPassword
                                          ? Icons.visibility
                                          : Icons.visibility_off))),
                              onChanged: vm.onPasswordChanged,
                            ),
                            Visibility(
                              visible: vm.showRegisterPage,
                              child: const SizedBox(
                                height: 20,
                              ),
                            ),
                            Visibility(
                              visible: vm.showRegisterPage,
                              child: RegisterTextField(
                                title: 'Confirm Password',
                                hint: 'Confirm your password',
                                onChanged: vm.onConfirmPasswordChanged,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            vm.isProgress
                                ? const CircularProgressIndicator()
                                : Column(
                                    children: [
                                      Visibility(
                                        visible: !vm.showRegisterPage,
                                        child: MaterialButton(
                                          minWidth:
                                              MediaQuery.of(context).size.width,
                                          color: Colors.blue.withOpacity(0.8),
                                          onPressed: () {
                                            onLoginTap();
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 16.0),
                                            child: Text(
                                              "Login",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      MaterialButton(
                                        minWidth:
                                            MediaQuery.of(context).size.width,
                                        color: Colors.blue.withOpacity(0.8),
                                        onPressed: () {
                                          vm.showRegisterPage
                                              ? vm.onRegister()
                                              : onRegisterTap();
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 16.0),
                                          child: Text(
                                            "Register",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  onRegisterTap() {
    final vm = Provider.of<LoginVm>(context, listen: false);
    vm.onRegisterTap();
  }

  onLoginTap() {
    isChecking?.change(false);
    isHandsUp?.change(false);
    onLogin();
  }

  onLogin() async {
    final vm = Provider.of<LoginVm>(context, listen: false);
    await vm.onLoginTap();
  }

  onSuccess() {
    successTrigger?.fire();
  }

  onFail() {
    failTrigger?.fire();
  }

  _subForGoMain() {
    final vm = Provider.of<LoginVm>(context, listen: false);
    vm.goToMain.stream.listen((event) {
      _goMain();
    }).toBag(bag);
  }

  _subForLoginRes() {
    final vm = Provider.of<LoginVm>(context, listen: false);
    vm.loginRes.stream.listen((event) {
      if (event) {
        onSuccess();
      } else {
        onFail();
      }
    }).toBag(bag);
  }

  _goMain() {
    context.replace(ScreenNames.initial);
  }

  _subForShowRegisterMassage() {
    final vm = Provider.of<LoginVm>(context, listen: false);
    vm.showRegisterMassage.stream.listen((event) {
      _showRegisterMassage();
    }).toBag(bag);
  }

  _showRegisterMassage() {
    final vm = Provider.of<LoginVm>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Register'),
        content: const Text('Register success'),
        actions: [
          TextField(
            onChanged: vm.onUserNameChanged,
          ),
          MaterialButton(
            onPressed: () {
              onRegisterTap();
            },
            child: const Text("Register"),
          )
        ],
      ),
    );
  }

  subForShowErrorMassage() {
    final vm = Provider.of<LoginVm>(context, listen: false);
    vm.showError.stream.listen((event) {
      _showErrorMassage(event);
    }).toBag(bag);
  }

  _showErrorMassage(String error) {
    final snackBar = SnackBar(
      content: Text(error),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  hideModal() {
    Navigator.of(context).pop();
  }

  void handsOnTheEyes() {
    isHandsUp?.change(true);
  }

  void lookOnTheTextField() {
    isHandsUp?.change(false);
    isChecking?.change(true);
    numLook?.change(0);
  }

  void moveEyeBalls(val) {
    final vm = Provider.of<LoginVm>(context, listen: false);
    numLook?.change(val.length.toDouble());
    vm.onEmailChanged(val);
  }
}
