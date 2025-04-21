import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tes_express_app_new/core/routes/route_constants.dart';
import 'package:tes_express_app_new/core/styles/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tes_express_app_new/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:tes_express_app_new/features/profile/presentation/components/profile_action_card.dart';
import 'package:tes_express_app_new/features/profile/presentation/components/contact_us_card.dart';

class NotRegisteredUserPage extends StatefulWidget {
  const NotRegisteredUserPage({super.key});

  @override
  State<NotRegisteredUserPage> createState() => _NotRegisteredUserPageState();
}

class _NotRegisteredUserPageState extends State<NotRegisteredUserPage> {
  void _onLoginTap() async {
    context.read<AuthBloc>().add(Logout());
    if (mounted) {
      context.go(RouteConstants.login);
    }
  }

  void _onRegisterTap() async {
    context.read<AuthBloc>().add(Logout());
    if (mounted) {
      context.go(RouteConstants.register);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Профиль',
                      style: AppTheme.displayLarge,
                    ),
                    SizedBox(height: 24.h),
                    ProfileActionCard(
                      onLoginTap: _onLoginTap,
                      onRegisterTap: _onRegisterTap,
                    ),
                    SizedBox(height: 16.h),
                    ContactUsCard(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
