import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            "Votre Profile",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Text("zakia ouajih",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 0,
                clipBehavior: Clip.antiAlias,
                margin: const EdgeInsets.all(0),
                color: const Color.fromRGBO(63, 207, 173, 1),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: ListView(
                  children: const [
                    MenuItem(
                      icon: Icons.person_3_outlined,
                      title: "information personnels",
                      href: "/infoPersonnels",
                    ),
                    MenuItem(
                      icon: Icons.payment_outlined,
                      title: "vos carte bancaire",
                      href: "",
                    ),
                    MenuItem(
                      icon: Icons.notifications_outlined,
                      title: "les notifications",
                      href: "",
                    ),
                    MenuItem(
                      icon: Icons.history_rounded,
                      title: "historique d'activite",
                      href: "",
                    ),
                    MenuItem(
                      icon: Icons.logout_outlined,
                      title: "Déconnecter",
                      href: "/beforeLogin",
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String href;
  const MenuItem(
      {super.key, required this.icon, required this.title, required this.href});

  @override
  Widget build(BuildContext context) {
    return MenuItemButton(
      style: const ButtonStyle(
          padding: MaterialStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 25, vertical: 15))),
      onPressed: () => Navigator.pushNamed(context, href),
      leadingIcon: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
        ),
        child: Icon(
          icon,
          color: const Color.fromRGBO(5, 12, 79, 1),
        ),
      ),
      trailingIcon: const Icon(
        Icons.arrow_forward_ios_outlined,
        size: 15,
        color: Color.fromRGBO(5, 12, 79, 1),
      ),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black),
      ),
    );
  }
}
