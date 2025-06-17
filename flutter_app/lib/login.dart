import 'package:bsdoc_flutter/hover_text.dart';
import 'package:bsdoc_flutter/providers/AuthProvider.dart';
import 'package:bsdoc_flutter/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:bsdoc_flutter/components/bottomnavbar.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _registerEmailController;
  late TextEditingController _registerPasswordController;
  late TextEditingController _registerConfirmPasswordController;
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _registerEmailFocus = FocusNode();
  final _registerPasswordFocus = FocusNode();
  final _registerConfirmPasswordFocus = FocusNode();
  bool _isPasswordVisible = false;
  bool _isRegisterPasswordVisible = false;
  bool _isRegisterConfirmPasswordVisible = false;
  bool _showLogin = true;

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  final AuthService _authService = AuthService();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _registerEmailController = TextEditingController();
    _registerPasswordController = TextEditingController();
    _registerConfirmPasswordController = TextEditingController();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _fadeController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _registerEmailController.dispose();
    _registerPasswordController.dispose();
    _registerConfirmPasswordController.dispose();

    _fadeController.dispose();
    super.dispose();
  }

  void _toggleView() {
    // Fade out, then change view, then fade in
    _fadeController.reverse().then((_) {
      setState(() {
        _showLogin = !_showLogin;
      });
      _fadeController.forward();
    });
  }

  void _handleLogin() async {
    if (_isLoading) return;
    FocusScope.of(context).unfocus();
    setState(() => _isLoading = true);

    try {
      // final accessToken = await _authService.login(
      //   email: _emailController.text.trim(),
      //   password: _passwordController.text.trim(),
      // );

      // if (mounted) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     const SnackBar(
      //       content: Text("Login Successful!"),
      //       backgroundColor: Colors.green,
      //     ),
      //   );
      // }

      await Provider.of<AuthProvider>(
        context,
        listen: false,
      ).login(_emailController.text.trim(), _passwordController.text.trim());

      debugPrint('Login successful, AuthProvider state updated');

      if (mounted) {
        debugPrint('Widget still mounted, showing success message');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Login Successful!"),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );

        // Don't manually navigate - let the Consumer in MyApp handle it
        debugPrint('Login handler completed successfully');
        Navigator.pushNamed(context, '/home');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: $e"),
            backgroundColor: Colors.red,
          ),
        );
        debugPrint(
          'Login Failed: ${e.toString().replaceFirst("Exception: ", "")}',
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _handleSignup() async {
    if (_isLoading) return;

    List<String> errors = [];

    if (_registerEmailController.text.trim().isEmpty) {
      errors.add('Email cannot be empty');
    }
    if (_registerPasswordController.text.trim().isEmpty) {
      errors.add('Password cannot be empty!');
    }
    if (_registerConfirmPasswordController.text.trim().isEmpty) {
      errors.add('Please confirm your password!');
    }
    if (_registerPasswordController.text.trim() !=
        _registerConfirmPasswordController.text.trim()) {
      errors.add('Passwords do not match!');
    }

    if (errors.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errors.first), backgroundColor: Colors.red),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final message = await _authService.signup(
        email: _registerEmailController.text.trim(),
        password: _registerPasswordController.text.trim(),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 5),
          ),
        );
      }
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      await authProvider.signup(
        _registerEmailController.text.trim(),
        _registerPasswordController.text.trim(),
      );
      _toggleView();

      setState(() => _isLoading = true);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceFirst("Exception: ", "")),
            backgroundColor: Colors.red,
          ),
        );
        debugPrint(e.toString().replaceFirst("Exception: ", ""));
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Widget _buildLoginForm(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _emailController,
          focusNode: _emailFocus,
          textInputAction: TextInputAction.next,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            // hintText: 'Email',
            // hintStyle: TextStyle(
            //   color: Colors.black.withAlpha((255 * 0.5).round()),
            // ),
            labelText: 'Email',
            labelStyle: TextStyle(),
            filled: true,
            fillColor: Colors.grey.withAlpha((255 * 0.1).round()),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                color: Colors.tealAccent,
                width: 1.5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Colors.white.withAlpha((255 * 0.3).round()),
                width: 1,
              ),
            ),
            prefixIcon: Icon(Icons.person, color: Colors.black),
          ),
          onChanged: (text) {},
          onSubmitted: (text) {
            FocusScope.of(context).requestFocus(_passwordFocus);
          },
        ),
        SizedBox(height: 15),

        //password field
        TextField(
          controller: _passwordController,
          obscureText: !_isPasswordVisible,
          focusNode: _passwordFocus,
          textInputAction: TextInputAction.done,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            // hintText: 'Password',
            // hintStyle: TextStyle(
            //   color: Colors.black.withAlpha((255 * 0.5).round()),
            // ),
            labelText: 'Password',
            labelStyle: TextStyle(),
            filled: true,
            fillColor: Colors.grey.withAlpha((255 * 0.1).round()),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                color: Colors.tealAccent,
                width: 1.5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Colors.white.withAlpha((255 * 0.3).round()),
                width: 1,
              ),
            ),
            prefixIcon: Icon(Icons.lock, color: Colors.black),
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
          ),
          onChanged: (text) {},
          onSubmitted: (text) {
            if (!_isLoading) _handleLogin();
          },
        ),
        SizedBox(height: 25),
        FractionallySizedBox(
          widthFactor: 1,
          child: ElevatedButton(
            onPressed: _isLoading ? null : _handleLogin,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 59, 209, 194),
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(20),
              ),
            ),
            child: _isLoading && _showLogin
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    ),
                  )
                : const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
        SizedBox(height: 20),

        //create account text link
        HoverText(
          text: 'Create an account',
          onTap: () {
            _toggleView();
          },
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
          suffixIcon: Icon(Icons.arrow_right_alt, color: Colors.black),
          iconSpacing: 4,
        ),
      ],
    );
  }

  Widget _buildRegisterForm(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _registerEmailController,
          focusNode: _registerEmailFocus,
          textInputAction: TextInputAction.next,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            // hintText: 'Email',
            // hintStyle: TextStyle(
            //   color: Colors.black.withAlpha((255 * 0.5).round()),
            // ),
            labelText: 'Email',
            labelStyle: TextStyle(),
            filled: true,
            fillColor: Colors.grey.withAlpha((255 * 0.1).round()),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                color: Colors.tealAccent,
                width: 1.5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Colors.white.withAlpha((255 * 0.3).round()),
                width: 1,
              ),
            ),
            prefixIcon: Icon(Icons.person, color: Colors.black),
          ),
          onChanged: (text) {},
          onSubmitted: (text) {
            FocusScope.of(context).requestFocus(_registerPasswordFocus);
          },
        ),
        SizedBox(height: 15),

        //password field
        TextField(
          controller: _registerPasswordController,
          obscureText: !_isRegisterPasswordVisible,
          focusNode: _registerPasswordFocus,
          textInputAction: TextInputAction.next,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            // hintText: 'Password',
            // hintStyle: TextStyle(
            //   color: Colors.black.withAlpha((255 * 0.5).round()),
            // ),
            labelText: 'Password',
            labelStyle: TextStyle(),
            filled: true,
            fillColor: Colors.grey.withAlpha((255 * 0.1).round()),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                color: Colors.tealAccent,
                width: 1.5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Colors.white.withAlpha((255 * 0.3).round()),
                width: 1,
              ),
            ),
            prefixIcon: Icon(Icons.lock, color: Colors.black),
            suffixIcon: IconButton(
              icon: Icon(
                _isRegisterPasswordVisible
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  _isRegisterPasswordVisible = !_isRegisterPasswordVisible;
                });
              },
            ),
          ),
          onChanged: (text) {},
          onSubmitted: (text) {
            FocusScope.of(context).requestFocus(_registerConfirmPasswordFocus);
          },
        ),
        SizedBox(height: 25),

        //confirm password field
        TextField(
          controller: _registerConfirmPasswordController,
          obscureText: !_isRegisterConfirmPasswordVisible,
          focusNode: _registerConfirmPasswordFocus,
          textInputAction: TextInputAction.done,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            // hintText: 'Confirm Password',
            // hintStyle: TextStyle(
            //   color: Colors.black.withAlpha((255 * 0.5).round()),
            // ),
            labelText: 'Confirm Password',
            labelStyle: TextStyle(),
            filled: true,
            fillColor: Colors.grey.withAlpha((255 * 0.1).round()),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                color: Colors.tealAccent,
                width: 1.5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Colors.white.withAlpha((255 * 0.3).round()),
                width: 1,
              ),
            ),
            prefixIcon: Icon(Icons.lock, color: Colors.black),
            suffixIcon: IconButton(
              icon: Icon(
                _isRegisterConfirmPasswordVisible
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: Colors.black,
              ),
              onPressed: () {
                setState(() {
                  _isRegisterConfirmPasswordVisible =
                      !_isRegisterConfirmPasswordVisible;
                });
              },
            ),
          ),
          onChanged: (text) {},
          onSubmitted: (text) {
            if (!_isLoading) _handleSignup();
          },
        ),
        SizedBox(height: 25),

        FractionallySizedBox(
          widthFactor: 1,
          child: ElevatedButton(
            onPressed: _isLoading ? null : _handleSignup,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 59, 209, 194),
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(20),
              ),
            ),
            child: _isLoading && !_showLogin
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    ),
                  )
                : const Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
        SizedBox(height: 20),

        //create account text link
        HoverText(
          text: 'Already have an account? Login',
          onTap: () {
            _toggleView();
          },
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
          suffixIcon: Icon(Icons.arrow_right_alt, color: Colors.black),
          iconSpacing: 4,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); //for text field unfocus
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text('BSDOC'),
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          // leading: IconButton(
          //   onPressed: () {
          //     // if (!_showLogin) {
          //     //   _toggleView();
          //     // } else {
          //     //   Navigator.pop(context);
          //     // }
          //     Navigator.pushNamed(context, '/home');
          //   },
          //   icon: const Icon(Icons.arrow_back),
          // ),
        ),
        body: Stack(
          children: [
            Container(
              constraints: const BoxConstraints.expand(),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height:
                              kToolbarHeight +
                              MediaQuery.of(context).padding.top +
                              20,
                        ),
                        FadeTransition(
                          opacity: _fadeAnimation,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _showLogin
                                    ? 'Welcome Back!'
                                    : 'Welcome to BSDOC!',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Divider(thickness: 1, color: Colors.grey[300]),
                        const SizedBox(height: 30),

                        // --- Use AnimatedSwitcher for form transitions ---
                        AnimatedSwitcher(
                          duration: const Duration(
                            milliseconds: 350,
                          ), // Adjust duration as you like
                          reverseDuration: const Duration(
                            milliseconds: 350,
                          ), // Duration for the exiting child
                          switchInCurve: Curves
                              .easeInOutSine, // Curve for the new child entering
                          switchOutCurve: Curves
                              .easeInOutSine, // Curve for the old child exiting

                          transitionBuilder: (Widget child, Animation<double> animation) {
                            // Determine if the child being built is the Login form based on its key
                            final bool isLoginWidget =
                                child.key == const ValueKey('loginForm');

                            // Determine if this child is the one that should be visible based on the current state
                            final bool isTargetViewThisWidget =
                                (isLoginWidget && _showLogin) ||
                                (!isLoginWidget && !_showLogin);

                            Offset beginOffset;

                            if (isTargetViewThisWidget) {
                              // This child is ENTERING
                              // If the target is Login view, it enters from the LEFT.
                              // If the target is Register view, it enters from the RIGHT.
                              beginOffset = _showLogin
                                  ? const Offset(-1.0, 0.0)
                                  : const Offset(1.0, 0.0);
                            } else {
                              // This child is EXITING
                              // If the Login view is exiting (because Register is the target), it exits to the LEFT.
                              // If the Register view is exiting (because Login is the target), it exits to the RIGHT.
                              beginOffset = _showLogin
                                  ? const Offset(1.0, 0.0)
                                  : const Offset(-1.0, 0.0);
                            }

                            // For entering child, animate from beginOffset to Offset.zero
                            // For exiting child, animate from Offset.zero to beginOffset (which represents the exit direction)
                            // AnimatedSwitcher handles applying the animation correctly (0->1 for enter, 1->0 effectively for exit)
                            final slideAnimation =
                                Tween<Offset>(
                                  begin: isTargetViewThisWidget
                                      ? beginOffset
                                      : Offset.zero,
                                  end: isTargetViewThisWidget
                                      ? Offset.zero
                                      : beginOffset,
                                ).animate(
                                  animation,
                                ); // `animation` is driven by AnimatedSwitcher for both enter and exit

                            return SlideTransition(
                              position: slideAnimation,
                              child: FadeTransition(
                                // Add a fade for a smoother effect
                                opacity:
                                    animation, // Fades in the entering, fades out the exiting
                                child: child,
                              ),
                            );
                          },
                          layoutBuilder:
                              (
                                Widget? currentChild,
                                List<Widget> previousChildren,
                              ) {
                                return Stack(
                                  alignment: Alignment
                                      .topCenter, // Or Alignment.center
                                  children: <Widget>[
                                    ...previousChildren, // Previous children are animated out
                                    if (currentChild != null)
                                      currentChild, // Current child is animated in
                                  ],
                                );
                              },
                          // The child whose key changes triggers the animation
                          child: _showLogin
                              ? Container(
                                  key: const ValueKey('loginForm'),
                                  child: _buildLoginForm(context),
                                )
                              : Container(
                                  key: const ValueKey('registerForm'),
                                  child: _buildRegisterForm(context),
                                ),
                        ),

                        SizedBox(
                          height: MediaQuery.of(context).padding.bottom + 30,
                        ),

                        // Changed from SlideTransition to FadeTransition
                        FadeTransition(
                          opacity: _fadeAnimation,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 50),
                              child: HoverText(
                                text: 'Register as Doctor',
                                textStyle: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                                onTap: () {
                                  Navigator.pushNamedAndRemoveUntil(context, '/doctors/registration', (Route<dynamic> route)=> false);
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 12,
              right: 12,
              bottom: 15 + MediaQuery.of(context).padding.bottom,
              child: const GlobalBottomNav(
                currentIndex: 3,
              ), // Pass index 2 for the "Medicine" tab
            ),
          ],
        ),
      ),
    );
  }
}
