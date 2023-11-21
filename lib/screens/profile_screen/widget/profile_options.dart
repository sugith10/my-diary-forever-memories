import 'package:flutter/material.dart';

class ProfileOptions extends StatelessWidget {
   const ProfileOptions({required this.item,required this.icon, super.key});

 final String item;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return  Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: const Color(0xFFF1F5FF),
                          child: Icon(icon,
                              color: Colors.black),
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        Text(
                           item,
                          style: const TextStyle(fontSize: 17),
                        )
                      ],
                    );
  }
}