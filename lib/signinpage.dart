import 'package:flutter/material.dart';
import 'package:raindrops/otppage.dart';

class SignIn_Page extends StatefulWidget {
  const SignIn_Page({super.key});

  @override
  State<SignIn_Page> createState() => _SignIn_PageState();
}

class _SignIn_PageState extends State<SignIn_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Center(
                child: ClipPath(
                  clipper: CustomImageClipper(),
                  child: Container(
                    height: 350,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'lib/assets/chicken.jpg'), // Add your image here
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Sign In To Your Account',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
              SizedBox(height: 8),
              Text(
                'Welcome Back! You\'ve Been Missed!',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              SizedBox(height: 24),
              Text(
                'Phone Number',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Enter your Phone Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        12), // Adjust the value for more or less curvature
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        12), // Ensure border remains rounded when not focused
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                        12), // Ensure border remains rounded when focused
                    borderSide: BorderSide(
                        color: Colors
                            .blue), // Change the border color when focused
                  ),
                ),
              ),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Navigator.push(context,MaterialPageRoute(builder: (context)=>ForgotPasswordScreen()));
                  },
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                                          Navigator.of(context).push(_createRoute());

                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => OTPVerificationScreen()));
                  },
                  child: Text(
                    'Sign In',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              // SizedBox(height: 16),
              // Center(
              //   child: Text(
              //     'Or Continue With',
              //     style: TextStyle(fontWeight: FontWeight.w600),
              //   ),
              // ),
              // SizedBox(height: 16),
              // SizedBox(
              //   width: double.infinity,
              //   height: 48,
              //   child: OutlinedButton.icon(
              //     icon: Image.asset('assets/google_icon.png', width: 24), // Add Google icon
              //     label: Text('Sign In With Google'),
              //     onPressed: () {},
              //     style: OutlinedButton.styleFrom(
              //       side: BorderSide(color: Colors.grey),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(12),
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(height: 12),
              // SizedBox(
              //   width: double.infinity,
              //   height: 48,
              //   child: OutlinedButton.icon(
              //     icon: Image.asset('assets/apple_icon.png', width: 24), // Add Apple icon
              //     label: Text('Sign In With Apple'),
              //     onPressed: () {},
              //     style: OutlinedButton.styleFrom(
              //       side: BorderSide(color: Colors.grey),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(12),
              //       ),
              //     ),
              //   ),
              // ),
              // SizedBox(height: 24),
              // Center(
              //   child: Text.rich(
              //     TextSpan(
              //       text: 'Not a member? ',
              //       style: TextStyle(color: Colors.grey),
              //       children: <TextSpan>[
              //         TextSpan(
              //           text: 'Create an account',
              //           style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomImageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double curveHeight = size.height * 0.2; // Adjust for the curve depth
    path.lineTo(0, size.height - curveHeight);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - curveHeight,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}


  // Create a PageRouteBuilder for smooth transition
  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => OTPVerificationScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
        transitionDuration: Duration(milliseconds: 500),
    );
  }
