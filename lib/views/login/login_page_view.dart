import 'package:crosstrack_italia/features/auth/notifiers/auth_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:crosstrack_italia/views/login/square_tile.dart';
import 'package:crosstrack_italia/views/login/helper_line_gestore.dart';

class LoginPageView extends StatefulHookConsumerWidget {
  const LoginPageView({super.key});

  @override
  ConsumerState<LoginPageView> createState() => _LoginPageViewState();
}

class _LoginPageViewState extends ConsumerState<LoginPageView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false, //to avoid overflow
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
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

                Text(
                  'Accedi, Per ottenere più funzionalità',
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),

                SvgPicture.asset(
                  'assets/svgs/moto_icon.svg',
                  height: 300.h,
                  width: 300.w,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.primary,
                    BlendMode.srcATop,
                  ),
                ),

                //row containing google and facebook buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google button
                    SquareTile(
                      imagePath: 'assets/svgs/g_logo.svg',
                      onTap: () async {
                        await ref
                            .watch(authStateNotifierProvider.notifier)
                            .loginWithGoogle();
                        Navigator.pop(context);
                      },
                    ),

                    25.horizontalSpace,

                    // facebook button
                    SquareTile(
                      imagePath: 'assets/svgs/f_logo.svg',
                      onTap: () async {
                        await ref
                            .watch(authStateNotifierProvider.notifier)
                            .loginWithFacebook();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),

                50.verticalSpace,

                const HelperLineGestore(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
