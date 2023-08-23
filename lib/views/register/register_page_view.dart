import 'package:crosstrack_italia/helper_line_gestore.dart';
import 'package:flutter/material.dart';
import '../../round_text_field.dart';
import '../../round_gesture_detector.dart';
import '../../end_phrase_row.dart';

class RegisterPageView extends StatelessWidget {
  const RegisterPageView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false, //to avoid overflow
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              children: [
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
                const SizedBox(height: 10),

                const RoundTextField(
                  labelText: 'Nome',
                ),

                const SizedBox(height: 20),

                const RoundTextField(
                  labelText: 'Cognome',
                ),

                const SizedBox(height: 20),

                const RoundTextField(
                  labelText: 'E-mail',
                  prefixIcon: Icons.mail,
                ),

                const SizedBox(height: 20),

                const RoundTextField(
                  labelText: 'Password',
                  obscureText: true,
                  prefixIcon: Icons.lock,
                  suffixIcon: Icons.visibility_off,
                ),

                const SizedBox(height: 20),

                const RoundTextField(
                  labelText: 'Conferma Password',
                  obscureText: true,
                  prefixIcon: Icons.lock,
                  suffixIcon: Icons.visibility_off,
                ),
                const SizedBox(height: 20),

                RoundGestureDetector(
                  labelText: 'Registrati',
                  onTap: () {},
                ),

                const SizedBox(height: 10),

                EndPhraseRow(
                  firstText: 'Hai già un account?',
                  secondText: 'Accedi',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),

                const SizedBox(height: 10),

                const HelperLineGestore(),

                const SizedBox(height: 10),

                //Row containing accetta termini e condizioni in richtext
                Wrap(
                  children: [
                    RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: const <TextSpan>[
                          TextSpan(
                            text: 'Iscrivendoti accetti i nostri ',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                            ),
                          ),
                          TextSpan(
                            text: 'Termini e Condizioni ',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                          TextSpan(
                            text: 'e le ',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12,
                            ),
                          ),
                          TextSpan(
                            text: 'Privacy e Policy ',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
