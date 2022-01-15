import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService{
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth fireBaseAuth = FirebaseAuth.instance;
  Future<UserDetails> signIn() async {
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken);
    FirebaseUser userDetails = (await fireBaseAuth.signInWithCredential(credential)).user;
    ProviderDetails providerInfo = new ProviderDetails(userDetails.providerId);
    List<ProviderDetails> providerData = new List<ProviderDetails>();
    providerData.add(providerInfo);
    return await GoogleAuthService().currentUserDetails();
  }
//  Future<FirebaseUser> signIn() async {
//    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
//    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//    final AuthCredential credential = GoogleAuthProvider.getCredential(
//        idToken: googleAuth.idToken,
//        accessToken: googleAuth.accessToken);
//    FirebaseUser userDetails = (await fireBaseAuth.signInWithCredential(credential)).user;
//    ProviderDetails providerInfo = new ProviderDetails(userDetails.providerId);
//    List<ProviderDetails> providerData = new List<ProviderDetails>();
//    providerData.add(providerInfo);
//    return userDetails;
//  }
  Future<UserDetails> currentUserDetails() async => await GoogleAuthService().isUserSignedIn ? UserDetails(
    providerDetails: (await currentUser).providerId,
    userName: (await currentUser).displayName,
    userImageUrl: (await currentUser).photoUrl,
    userEmail: (await currentUser).email,) : null ;
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
  UserDetails({this.providerDetails, this.userName, this.userImageUrl, this.userEmail });
}
class ProviderDetails{
  ProviderDetails(String providerDetails);
}