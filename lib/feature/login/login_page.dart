import 'package:camp_trip/common/extension/stream_subscription_extensions.dart';
import 'package:camp_trip/feature/login/login_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../common/base/base_state.dart';
import '../../routers/screen_names.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BaseState<LoginPage> {
  @override
  void initState() {
    _subForGoMain();
    subForShowErrorMassage();
    _subForShowRegisterMassage();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<LoginVm>(context, listen: false);
    return Scaffold(
      //login page
      body: Container(
        color: Colors.lightGreen,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Camping trip",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Login",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Email",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              TextField(
                onChanged: vm.onEmailChanged,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Password",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              TextField(
                onChanged: vm.onPasswordChanged,
              ),
              const SizedBox(
                height: 20,
              ),
              vm.isProgress
                  ? const CircularProgressIndicator()
                  :
              ElevatedButton(
                onPressed: () {
                  vm.onLoginTap();
                },
                child: const Text("Login"),
              ),

            ],
          ),
        ),
      ),
    );
  }

  _subForGoMain() {
    final vm = Provider.of<LoginVm>(context, listen: false);
    vm.goToMain.stream.listen((event) {
      _goMain();
    }).toBag(bag);
  }

  _goMain() {
    context.replace(ScreenNames.initial);
  }

  _subForShowRegisterMassage(){
    final vm = Provider.of<LoginVm>(context, listen: false);
    vm.showRegisterMassage.stream.listen((event) {
      _showRegisterMassage();
    }).toBag(bag);
  }

  _showRegisterMassage(){
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
          MaterialButton(onPressed: (){
            onRegisterTap();
          },child: const Text("OK"),)
        ],
      ),
    );
  }

  subForShowErrorMassage(){
    final vm = Provider.of<LoginVm>(context, listen: false);
    vm.showError.stream.listen((event) {
      _showErrorMassage(event);
    }).toBag(bag);
  }

  _showErrorMassage(String error){
    final snackBar = SnackBar(
      content: Text(error),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  onRegisterTap() async {
    final vm = Provider.of<LoginVm>(context, listen: false);
    hideModal();
    await vm.onRegisterTap();
  }

  hideModal(){
    Navigator.of(context).pop();
  }
}
