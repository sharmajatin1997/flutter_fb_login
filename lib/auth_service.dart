import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_social_login/screens/home.dart';
import 'package:flutter_social_login/screens/login.dart';
import 'package:google_sign_in/google_sign_in.dart';


class AuthService {
  handleAuthState() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return LoginPage();
          }
        });
  }

  signInWithGoogle() async {
    //  Trigger the authentication flow
    //  finds google user
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: <String>["email"]).signIn();
  //  Obtaine the auth details from the request
  //  request to login if found
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
  //  Create new credentials
  //  create new credentials if logged in
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );
  // Once signed in return the user's credential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  signOut(){
    return FirebaseAuth.instance.signOut();
  }
}
