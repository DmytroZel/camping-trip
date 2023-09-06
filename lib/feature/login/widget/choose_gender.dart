import 'package:flutter/material.dart';

class ChooseGender extends StatefulWidget {
  final bool isMale;
  final ValueChanged<bool> onGenderChanged;

  const ChooseGender(
      {Key? key, required this.onGenderChanged, required this.isMale})
      : super(key: key);

  @override
  State<ChooseGender> createState() => _ChooseGenderState();
}

class _ChooseGenderState extends State<ChooseGender> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Choose your gender',
          style: TextStyle(fontSize: 20, color: Colors.blue),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //Male
            item(widget.isMale, true),
            //Female
            item(!widget.isMale, false),
          ],
        ),
      ],
    );
  }

  Widget item(bool checked, bool isMale) {
    return Column(
      children: [
        Text(
          isMale ? "Male" : 'Female',
          style: TextStyle(color: Colors.blue),
        ),
        GestureDetector(
          onTap: () {
            widget.onGenderChanged(isMale);
          },
          child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: checked ? Colors.blue : Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              )),
        ),
      ],
    );
  }
}
