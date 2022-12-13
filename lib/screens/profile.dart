import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'auth/auth_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  final double coverHeigiht = 280;
  final double profileHeight = 144;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            buildTop(),
            Content(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return AuthScreen();
              }));
            },
            child: Icon(Icons.logout_rounded),
            backgroundColor: Color.fromARGB(255, 60, 60, 60)));
  }

  Widget buildTop() {
    final top = coverHeigiht - profileHeight / 2;
    final bottom = profileHeight / 2;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: bottom),
          child: CoverImage(),
        ),
        Positioned(
          top: top,
          child: ProfileImage(),
        ),
      ],
    );
  }

  Widget CoverImage() => Container(
        color: Colors.grey,
        child: Image.network(
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRY8fPai3sL4X5Z_T8Fbq2Ypc3eH1IQ-AEX7A&usqp=CAU',
          width: double.infinity,
          height: coverHeigiht,
          fit: BoxFit.cover,
        ),
      );

  Widget ProfileImage() => CircleAvatar(
        radius: profileHeight / 2,
        backgroundColor: Colors.grey.shade800,
        backgroundImage: AssetImage('image/aku.jpg'),
      );

  Widget Content() => Column(
        children: [
          const SizedBox(height: 8),
          Text(
            'Muhamad Aziz',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.normal),
          ),
          const SizedBox(height: 8),
          Text(
            'MOBILE PROGRAMMING PRACTICUM -D',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
          ),
          const SizedBox(height: 8),
          Text(
            '200605110135',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SosialIcon(FontAwesomeIcons.facebook),
              const SizedBox(width: 12),
              SosialIcon(FontAwesomeIcons.instagram),
              const SizedBox(width: 12),
              SosialIcon(FontAwesomeIcons.twitter),
              const SizedBox(width: 12),
              SosialIcon(FontAwesomeIcons.linkedin),
            ],
          ),
          const SizedBox(height: 16),
          Divider(),
          const SizedBox(height: 16),
          NumbersWidget(),
          const SizedBox(height: 32),
          Divider(),
          About(),
        ],
      );
  Widget SosialIcon(IconData icon) => CircleAvatar(
        radius: 25,
        child: Material(
          shape: CircleBorder(),
          clipBehavior: Clip.hardEdge,
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            child: Center(
              child: Icon(icon, size: 32),
            ),
          ),
        ),
      );
  Widget NumbersWidget() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildButton(text: 'Projects', value: 10),
          buildButton(text: 'Friends', value: 11),
          buildButton(text: 'Followers', value: 15),
        ],
      );
  Widget buildButton({
    required String text,
    required int value,
  }) =>
      MaterialButton(
        padding: EdgeInsets.symmetric(vertical: 4),
        onPressed: () {},
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              '$value',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 2),
            Text(
              text,
              style: TextStyle(fontSize: 16),
            )
          ],
        ),
      );

  Widget About() => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'A student studying at the State Islamic University of Maulana Malik Ibrahim Malang majoring in informatics engineering.',
              style: TextStyle(fontSize: 16, height: 1.4),
            )
          ],
        ),
      );
}
