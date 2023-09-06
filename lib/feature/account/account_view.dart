import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/base/base_state.dart';
import 'account_vm.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends BaseState<AccountView> {
  @override
  void initState() {
    final vm = Provider.of<AccountVM>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      vm.loadData();
    });
    subForGoBack(vm.onGetBack);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AccountVM>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: Container(
        color: Colors.grey[200],
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 200, vertical: 16),
          child: Card(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 100, vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  _buildAvatar(vm.getImage()),
                  const SizedBox(
                    height: 20,
                  ),
                  _nameInput(),
                  const SizedBox(
                    height: 20,
                  ),
                  _emailLabel(),
                  const SizedBox(
                    height: 20,
                  ),
                  _genderWidget(),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: !vm.isProgress,
        child: FloatingActionButton(
          onPressed: () {
            vm.onSave();
          },
          child: const Icon(Icons.save),
        ),
      ),
    );
  }

  Widget _buildAvatar(String? image) {
    if (image == null) {
      return ClipOval(
        child: Material(
          color: Colors.blue, // Button color
          child: InkWell(
            splashColor: Colors.red, // Splash color
            onTap: () {},
            child: const SizedBox(
              width: 96,
              height: 96,
              child: Icon(Icons.person),
            ),
          ),
        ),
      );
    }
    return CachedNetworkImage(
      imageUrl: image,
      fit: BoxFit.fitHeight,
      imageBuilder: (context, imageProvider) => Container(
        width: 96,
        height: 96,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
        ),
      ),
    );
  }

  Widget _nameInput() {
    final vm = Provider.of<AccountVM>(context);
    return TextField(
      onChanged: vm.onNameChanged,
      decoration: InputDecoration(
        hintText: vm.getName(),
      ),
    );
  }

  Widget _emailLabel() {
    final vm = Provider.of<AccountVM>(context);
    return Text(vm.getEmail());
  }

  Widget _genderWidget() {
    final vm = Provider.of<AccountVM>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(vm.getGenderString()),
        Row(
          children: [
            Icon(
              Icons.male,
              color: vm.getGender() ? Colors.blue : Colors.grey,
            ),
            Switch(
              onChanged: vm.onGenderChanged,
              value: vm.getGender(),
            ),
            Icon(
              Icons.female,
              color: vm.getGender() ? Colors.grey : Colors.blue,
            ),
          ],
        ),
      ],
    );
  }
}
