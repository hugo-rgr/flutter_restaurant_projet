import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restaurant_app/presentation/auth/state/auth_notifier.dart';
import 'package:flutter_restaurant_app/presentation/auth/state/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../common/base_page.dart';
import '../common/widgets/ore_button.dart';

class Auth extends BasePage<AuthNotifier, AuthState> {
  Auth({super.key}) : super(provider: authNotifierProvider);

  static const route = '/auth';

  @override
  Widget buildContent(BuildContext context, WidgetRef ref, AuthState state) {
    final formKey = GlobalKey<FormState>();

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
                Colors.black.withValues(alpha: 0.9),
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
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "RESTAU CHEZ O'REILLY",
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

                    // Email Field
                    TextFormField(
                      controller: state.emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Email',
                        errorStyle: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        hintStyle: TextStyle(color: Colors.black),
                        filled: true,
                        fillColor: Colors.white.withValues(alpha: 0.7),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: Icon(Icons.email, color: Colors.white70),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer votre email';
                        }
                        if (!RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        ).hasMatch(value)) {
                          return 'Email invalide';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),

                    // Password Field
                    TextFormField(
                      controller: state.passwordController,
                      obscureText: true,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        hintText: '************',
                        hintStyle: TextStyle(color: Colors.black),
                        filled: true,
                        errorStyle: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        fillColor: Colors.white.withValues(alpha: 0.7),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),

                        prefixIcon: Icon(Icons.lock, color: Colors.white70),
                      ),

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer votre mot de passe';
                        }
                        if (value.length < 6) {
                          return 'Le mot de passe doit contenir au moins 6 caractères';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),

                    // Name Field (only for registration)
                    if (!state.isLogin)
                      TextFormField(
                        controller: state.nameController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Nom (Optionnel)',
                          hintStyle: TextStyle(color: Colors.black),
                          filled: true,
                          fillColor: Colors.white.withValues(alpha: 0.7),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: Icon(Icons.person, color: Colors.white70),
                        ),
                      ),
                    if (!state.isLogin) const SizedBox(height: 15),

                    // Phone Field (only for registration)
                    if (!state.isLogin)
                      TextFormField(
                        controller: state.phoneController,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Téléphone (Optionnel)',
                          hintStyle: TextStyle(color: Colors.black),
                          filled: true,
                          fillColor: Colors.white.withValues(alpha: 0.7),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: Icon(Icons.phone, color: Colors.white70),
                        ),
                        validator: (value) {
                          if (value != null && value.isNotEmpty) {
                            if (!RegExp(r'^[0-9+\s\-\(\)]+$').hasMatch(value)) {
                              return 'Numéro de téléphone invalide';
                            }
                          }
                          return null;
                        },
                      ),
                    const SizedBox(height: 15),

                    // Submit Button
                    OreButton(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          state.isLogin
                              ? ref.read(notifier).login()
                              : ref.read(notifier).register();
                        }
                      },
                      text:
                          state.isLoading
                              ? null
                              : state.isLogin
                              ? 'Se connecter'
                              : "S'inscrire",
                      widget:
                          state.isLoading
                              ? CupertinoActivityIndicator(color: Colors.white)
                              : null,
                    ),
                    const SizedBox(height: 15),

                    // Switch Auth Mode
                    GestureDetector(
                      onTap: () {
                        ref.read(notifier).switchAuth();
                      },
                      child: Text(
                        state.isLogin
                            ? 'Vous êtes nouveau ? Inscrivez-vous'
                            : 'Vous avez déjà un compte ? Connectez-vous',
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

                    // Terms and Conditions
                    if (!state.isLogin)
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(
                          'En vous inscrivant, vous acceptez nos termes et conditions d\'utilisation',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    if (state.isLogin)
                      SizedBox(height: MediaQuery.sizeOf(context).height / 6),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Back to Menu Button
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
                  "Retourner dans le menu",
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
