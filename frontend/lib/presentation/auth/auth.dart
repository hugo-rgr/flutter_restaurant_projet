import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/presentation/auth/state/auth_notifier.dart';
import 'package:flutter_restaurant_app/presentation/auth/state/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/base_page.dart';
import '../common/widgets/ore_button.dart';
import '../common/widgets/ore_textfield.dart';

class Auth extends BasePage<AuthNotifier, AuthState> {
  Auth({super.key}) : super(provider: authNotifierProvider);

  static const route = '/auth';

  @override
  Widget buildContent(BuildContext context, WidgetRef ref, AuthState state) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: MediaQuery.sizeOf(context).height * 2,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/resto_bg.jpeg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withValues(alpha: 0.7),
                BlendMode.color,
              ),
            ),
          ),
        ),
        Center(
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height * 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'RESTAU CHEZ O’REILLY',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                    Icon(Icons.restaurant, size: 100, color: Colors.orange),

                    if (state.error != null)
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            state.error!,
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    SizedBox(height: state.error != null ? 15 : 50),
                    OreTextField(
                      hintText: 'Email',
                      controller: state.emailController,
                      onChanged: (String) {},
                    ),
                    OreTextField(
                      hintText: 'Password',
                      controller: state.passwordController,
                      onChanged: (String) {},
                    ),
                    if (!state.isLogin)
                      OreTextField(
                        hintText: 'Nom (Optionnel)',
                        controller: state.nameController,
                        onChanged: (String) {},
                      ),
                    if (!state.isLogin)
                      OreTextField(
                        hintText: 'Phone (Optionnel)',
                        controller: state.phoneController,
                        onChanged: (String) {},
                        textInputType: TextInputType.number,
                      ),
                    const SizedBox(height: 15),
                    OreButton(
                      onTap:
                          () =>
                              state.isLogin
                                  ? ref.read(notifier).login()
                                  : ref.read(notifier).register(),
                      text:
                          state.isLoading
                              ? null
                              : state.isLogin
                              ? 'Se connecter'
                              : "S'inscire",
                      widget:
                          state.isLoading
                              ? CupertinoActivityIndicator(color: Colors.white)
                              : null,
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        ref.read(notifier).switchAuth();
                      },
                      child: Text(
                        state.isLogin
                            ? 'Vous etes nouveau ? inscrivez-vous'
                            : 'Vous avez déjà un compte ? connectez-vous',
                        textAlign: TextAlign.center,

                        style: TextStyle(
                          color: Colors.orange,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.orange,
                        ),
                      ),
                    ),
                    if (!state.isLogin)
                      Text(
                        'En vous inscrivant, vous acceptez nos termes et conditions d’utilisations',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    SizedBox(height: MediaQuery.sizeOf(context).height / 10),
                  ],
                ),
              ),
            ),
          ),
        ),

        Positioned(
          top: 50,
          right: 20,
          child: GestureDetector(
            onTap: () {
              ref.read(notifier).openEntryPoint();
            },

            child: Container(
              decoration: BoxDecoration(color: Colors.orange),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Retourner au menu',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  AppBar? buildAppBar(BuildContext context, WidgetRef ref, AuthState? state) {
    return null;
  }

  @override
  bool withoutAppBar() {
    return true;
  }
}
