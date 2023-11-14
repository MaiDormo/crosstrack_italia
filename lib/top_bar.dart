import 'package:crosstrack_italia/features/map/presentation/widget/geolocation_button.dart';
import 'package:crosstrack_italia/features/user_info/providers/user_image_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'features/map/presentation/widget/location_text.dart';
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
                    fontSize: MediaQuery.of(context).size.width * 0.03,
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
            Container(
              width: MediaQuery.of(context).size.width * 0.2,
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginPageView()),
                  );
                },
                icon: Consumer(
                  builder: (context, ref, child) {
                    final UserImage = ref.watch(userImageProvider);
                    return UserImage.when(
                      data: (data) => data,
                      loading: () => const CircularProgressIndicator(),
                      error: (error, stack) => const Icon(Icons.error),
                    );
                  },
                ),
                iconSize: MediaQuery.of(context).size.width * 0.07,
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
