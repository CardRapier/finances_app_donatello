import 'package:flutter/material.dart';

class GenericButton extends StatelessWidget {
  Function()? onPressed;
  String text;
  bool loading;
  bool active;
  GenericButton(
      {super.key,
      required this.text,
      required this.loading,
      required this.onPressed,
      required this.active});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: active ? onPressed : null,
      style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          loading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : const SizedBox(),
          const SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
