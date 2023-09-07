import 'package:cached_network_image/cached_network_image.dart';
import 'package:camp_trip/feature/account/widget/invite_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Card(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                      splashColor: Colors.red, // Splash color
                      onTap: () {
                        _onPickPhoto();
                      },
                      child: _buildAvatar(vm.getImage())),
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
                  Text(
                    'Invites',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InviteList(
                    invites: vm.invites,
                    onAccept: vm.onAccept,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (vm.isProgress) {
            return;
          }
          vm.onSave();
        },
        child: vm.isProgress ? const CircularProgressIndicator() : const Icon(Icons.save),
      ),
    );
  }

  Widget _buildAvatar(String? image) {
    if (image == null) {
      return const ClipOval(
        child: Material(
          color: Colors.blue, // Button color
          child: SizedBox(
            width: 120,
            height: 120,
            child: Icon(Icons.person),
          ),
        ),
      );
    }
    return ClipOval(
      child: Image.network(
        image,
        width: 120,
        height: 120,
        fit: BoxFit.cover,
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

  _onPickPhoto() async {
    final vm = Provider.of<AccountVM>(context, listen: false);
    final ImagePicker picker = ImagePicker();
    final XFile? response = await picker.pickImage(source: ImageSource.gallery);
    if (response != null) {
      vm.onImageChanged(response);
    }
  }
}
