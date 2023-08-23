import 'package:crosstrack_italia/geolocation_button.dart';
import 'package:flutter/material.dart';
import 'location_text.dart';
import 'views/login/login_page_view.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(1.0),
      //add round edges for the bottom corners
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  'Posizione Attuale:',
                  style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Row(
                  children: [
                    GeolocationButton(),
                    LocationText(),
                  ],
                )
              ],
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LoginPageView()),
                );
              },
              icon: const Icon(Icons.person),
              color: Theme.of(context).colorScheme.tertiary,
              iconSize: 20,
            ),
          ],
        ),
      ),
    );
  }
}
