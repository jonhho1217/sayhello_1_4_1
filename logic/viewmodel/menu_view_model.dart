import 'package:flutter/material.dart';
import 'package:sayhello/model/menu.dart';
import 'package:sayhello/utils/uidata.dart';

class MenuViewModel {
  List<Menu> menuItems;

  MenuViewModel({this.menuItems});

  getMenuItems() {
    return menuItems = <Menu>[
      Menu(
          title: "Profile",
          menuColor: Color(0xff050505),
          icon: Icons.person,
          image: UIData.profileImage,
          items: ["View Profile", "Profile Option 2"]),
      Menu(
          title: "Ideas",
          menuColor: Color(0xff7f5741),
          icon: Icons.view_list,
          image: UIData.ideasImage,
          items: ["My Ideas", "Shared Ideas"]),
      Menu(
          title: "Messages",
          menuColor: Color(0xffe19b6b),
          icon: Icons.message,
          image: UIData.messagesImage,
          items: ["Messages", "Email"]),
      Menu(
          title: "Settings",
          menuColor: Color(0xff2a8ccf),
          icon: Icons.settings,
          image: UIData.settingsImage,
          items: ["Settings 1", "Settings 2"]),
      Menu(
          title: "Help",
          menuColor: Color(0xff261d33),
          icon: Icons.help_outline,
          image: UIData.helpImage,
          items: ["Documentation 1", "Documentation 2"]),
      Menu(
          title: "Website",
          menuColor: Color(0xffddcec2),
          icon: Icons.web,
          image: UIData.webImage,
          items: ["Web Functions 1", "Web Functions 2"]),
    ];
  }
}