import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService{
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth fireBaseAuth = FirebaseAuth.instance;
  Future<FirebaseUser> signIn() async {
//    Scaffold.of(context).showSnackBar(new SnackBar(content: new Text('sign in')));
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken);
    FirebaseUser userDetails = (await fireBaseAuth.signInWithCredential(credential)).user;
    ProviderDetails providerInfo = new ProviderDetails(userDetails.providerId);
    List<ProviderDetails> providerData = new List<ProviderDetails>();
    providerData.add(providerInfo);
//    UserDetails details = new UserDetails(
//        userDetails.providerId,
//        userDetails.displayName,
//        userDetails.photoUrl,
//        userDetails.email,
//        providerData);
    return userDetails;
  }
  Future<UserDetails> currentUserDetails() async {
    return UserDetails(
      providerDetails: (await currentUser).providerId,
      userName: (await currentUser).displayName,
      userImageUrl: (await currentUser).photoUrl,
      userEmail: (await currentUser).email,
//      providerData: new ProviderDetails((await currentUser).providerId)
    );
  }
  Future<FirebaseUser> get currentUser async => await fireBaseAuth.currentUser();
  Future<void> signOut() async => fireBaseAuth.signOut();
  Future<void> get sendEmailVerification async => (await fireBaseAuth.currentUser()).sendEmailVerification();
  Future<bool> get isEmailVerified async => (await fireBaseAuth.currentUser()).isEmailVerified;
  Future<bool> get isUserSignedIn async => await currentUser.then((fireBaseUser) => fireBaseUser == null ? false : true);
}
class UserDetails{
  final String providerDetails;
  final String userName;
  final String userImageUrl;
  final String userEmail;
//  final List<ProviderDetails> providerData;
  UserDetails({this.providerDetails, this.userName, this.userImageUrl, this.userEmail /*, this.providerData*/});
}
class ProviderDetails{
  ProviderDetails(this.providerDetails);
  final String providerDetails;
}