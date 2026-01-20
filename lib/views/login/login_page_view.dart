import '../../common/responsive.dart';
import '../../features/auth/backend/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'helper_line_gestore.dart';

class LoginPageView extends StatefulHookConsumerWidget {
  const LoginPageView({super.key});

  @override
  ConsumerState<LoginPageView> createState() => _LoginPageViewState();
}

class _LoginPageViewState extends ConsumerState<LoginPageView> {
  Future<void> performLogin(Future<void> Function() login) async {
    final colorScheme = Theme.of(context).colorScheme;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            height: 180.h,
            width: 120.w,
            padding: EdgeInsets.all(24.r),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                  strokeWidth: 3,
                ),
                SizedBox(height: 24.h),
                Text(
                  'Caricamento...',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    await login();

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: colorScheme.surface,
        body: ResponsiveContainer(
          maxWidth: 500,
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Close button
                  Align(
                    alignment: Alignment.topRight,
                    child: Material(
                      color: colorScheme.onSurface.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(12),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () => Navigator.pop(context),
                        child: Padding(
                          padding: EdgeInsets.all(8.r),
                          child: Icon(
                            Icons.close_rounded,
                            color: colorScheme.onSurface.withValues(alpha: 0.6),
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 20.h),

                  // Icon
                  Container(
                    padding: EdgeInsets.all(24.r),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      'assets/svgs/moto_icon.svg',
                      height: Responsive.value(context, mobile: 80.r, tablet: 100.r, desktop: 120.r),
                      width: Responsive.value(context, mobile: 80.r, tablet: 100.r, desktop: 120.r),
                      colorFilter: ColorFilter.mode(
                        colorScheme.primary,
                        BlendMode.srcATop,
                      ),
                    ),
                  ),

                  SizedBox(height: 32.h),

                  // Title
                  Text(
                    'Benvenuto!',
                    style: TextStyle(
                      fontSize: Responsive.value(context, mobile: 28.sp, tablet: 32.sp, desktop: 36.sp),
                      fontWeight: FontWeight.w700,
                      color: colorScheme.onSurface,
                      letterSpacing: -0.5,
                    ),
                  ),
                  
                  SizedBox(height: 8.h),
                  
                  Text(
                    'Accedi per sbloccare tutte le funzionalità',
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 40.h),

                  // Login buttons
                  _buildLoginButton(
                    context: context,
                    icon: 'assets/svgs/g_logo.svg',
                    label: 'Continua con Google',
                    onTap: () async {
                      await performLogin(
                        () => ref.watch(authRepositoryProvider).googleLogin(),
                      );
                      if (mounted) Navigator.pop(context);
                    },
                  ),

                  SizedBox(height: 12.h),

                  _buildLoginButton(
                    context: context,
                    icon: 'assets/svgs/f_logo.svg',
                    label: 'Continua con Facebook',
                    backgroundColor: const Color(0xFF1877F2),
                    textColor: Colors.white,
                    onTap: () async {
                      await performLogin(
                        () => ref.watch(authRepositoryProvider).facebookLogin(),
                      );
                      if (mounted) Navigator.pop(context);
                    },
                  ),

                  SizedBox(height: 40.h),

                  const HelperLineGestore(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton({
    required BuildContext context,
    required String icon,
    required String label,
    required VoidCallback onTap,
    Color? backgroundColor,
    Color? textColor,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final isWhiteBackground = backgroundColor == null;
    
    return Material(
      color: backgroundColor ?? colorScheme.surface,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: isWhiteBackground 
                ? Border.all(color: colorScheme.onSurface.withValues(alpha: 0.1))
                : null,
            boxShadow: isWhiteBackground 
                ? [
                    BoxShadow(
                      color: colorScheme.shadow.withValues(alpha: 0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                icon,
                height: 24.r,
                width: 24.r,
              ),
              SizedBox(width: 12.w),
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: textColor ?? colorScheme.onSurface,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
