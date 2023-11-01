import 'package:crosstrack_italia/views/register/register_page_view.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../square_tile.dart';
import '../../end_phrase_row.dart';
import '../../helper_line_gestore.dart';
import '../../features/auth/providers/auth_state_provider.dart';

class LoginPageView extends StatefulHookConsumerWidget {
  const LoginPageView({super.key});

  @override
  ConsumerState<LoginPageView> createState() => _LoginPageViewState();
}

class _LoginPageViewState extends ConsumerState<LoginPageView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false, //to avoid overflow
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //row containing exit button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                //o continua con
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'O continua con',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 50),

                //row containing google and facebook buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google button
                    SquareTile(
                      imagePath: 'assets/svgs/g_logo.svg',
                      onTap:
                          ref.read(authStateProvider.notifier).loginWithGoogle,
                    ),

                    const SizedBox(width: 25),

                    // facebook button
                    SquareTile(
                      imagePath: 'assets/svgs/f_logo.svg',
                      onTap: ref
                          .read(authStateProvider.notifier)
                          .loginWithFacebook,
                    ),
                  ],
                ),

                const SizedBox(height: 50),

                //row containing se non hai un account puoi registrarti
                EndPhraseRow(
                  firstText: 'Non hai un account?',
                  secondText: 'Registrati',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegisterPageView()),
                    );
                  },
                ),

                const SizedBox(height: 20),

                const HelperLineGestore(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
