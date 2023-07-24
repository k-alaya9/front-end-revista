import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInApi{
  static const GOOGLE_CLIENT_DEV_KEY="377562171110-5m3jp4ac2rvbg930gjjgbvls02tbnm8j.apps.googleusercontent.com";
  static final _googleSignIn=GoogleSignIn(
    serverClientId: GOOGLE_CLIENT_DEV_KEY,
    hostedDomain: 'http://192.168.137.176.xip.io:8000',
    scopes: [
      'https://www.googleapis.com/auth/userinfo.email',
      'openid',
      'https://www.googleapis.com/auth/userinfo.profile',
    ],
  );
  static Future<GoogleSignInAccount?>  login()=> _googleSignIn.signIn();
  static Future<GoogleSignInAccount?>  logout()=> _googleSignIn.signOut();
}