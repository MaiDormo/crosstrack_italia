import 'package:crosstrack_italia/features/auth/providers/auth_providers.dart';
import 'package:crosstrack_italia/features/map/presentation/widget/geolocation_button.dart';
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LocationColumn(),
              AuthIconButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class LocationColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}

class AuthIconButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _isLogged = ref.watch(isLoggedInProvider);
    final userImage = ref.watch(userImageProvider);

    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      child: IconButton(
        onPressed: () {
          if (!_isLogged) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPageView()),
            );
          }
        },
        icon: userImage,
        iconSize: MediaQuery.of(context).size.width * 0.07,
        color: Theme.of(context).colorScheme.tertiary,
      ),
    );
  }
}
