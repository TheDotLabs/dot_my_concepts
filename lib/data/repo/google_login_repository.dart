import 'package:fa_flutter_core/fa_flutter_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_record_lesson/modules/profile/index.dart';
import 'package:flutter_record_lesson/utils/log_utils.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../login_repository.dart';

class GoogleLoginRepository extends LoginRepository {
  GoogleLoginRepository({required GoogleSignIn googleSignIn})
      : _googleSignIn = googleSignIn;

  final GoogleSignIn _googleSignIn;

  @override
  Future<Result> login() async {
    try {
      final googleUser =
          await (_googleSignIn.signIn() as Future<GoogleSignInAccount>);

      final googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final firebaseUser = await (getFirebaseUser(credential) as Future<User>);
      logger.i('User signed in $firebaseUser');
      final user = MyUser(
        id: firebaseUser.uid,
        name: firebaseUser.displayName.toString(),
        email: firebaseUser.email != null
            ? firebaseUser.email.toString()
            : googleUser.email,
        avatar: firebaseUser.photoURL!.replaceAll('s96-c', 's300-c'),
        provider: LoginProvider.google.name,
      );

      return await registerUser(user);
    } catch (e, s) {
      logger.e(e, s);
      return Result.failure(reason: '$e');
    }
  }

  @override
  Future<bool> isLoggedIn() => _googleSignIn.isSignedIn();

  @override
  Future<Result> logout() async {
    try {
      await logoutFirebase();
      final result = await _googleSignIn.signOut();
      return Result.success(data: result);
    } catch (error) {
      return Result.failure(reason: '${error.toString()}');
    }
  }

  @override
  Future<Result> loginWithCredentials() {
    // TODO: implement loginWithCredentials
    throw UnimplementedError();
  }
}
