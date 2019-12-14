import 'package:redux/redux.dart';
import 'package:fusecash/models/app_state.dart';
import 'package:fusecash/redux/actions/user_actions.dart';

class OnboardViewModel {
  final String countryCode;
  final String phoneNumber;
  final String accountAddress;
  final bool loginRequestSuccess;
  final bool loginVerifySuccess;
  final Function(String, String, String, String) signUp;
  final Function(String, String, String, String) verify;

  OnboardViewModel({
    this.countryCode,
    this.phoneNumber,
    this.accountAddress,
    this.loginRequestSuccess,
    this.loginVerifySuccess,
    this.signUp,
    this.verify
  });

  static OnboardViewModel fromStore(Store<AppState> store) {
    return OnboardViewModel(
      countryCode: store.state.userState.countryCode,
      phoneNumber: store.state.userState.phoneNumber,
      accountAddress: store.state.userState.accountAddress,
      loginRequestSuccess: store.state.userState.loginRequestSuccess,
      loginVerifySuccess: store.state.userState.loginVerifySuccess,
      signUp: (countryCode, phoneNumber, fullName, email) {
        store.dispatch(loginRequestCall(countryCode, phoneNumber, fullName, email));
      },
      verify: (countryCode, phoneNumber, verificationCode, accountAddress) {
        store.dispatch(loginVerifyCall(countryCode, phoneNumber, verificationCode, accountAddress));
      }
    );
  }

  bool operator ==(other) {
    if (other is OnboardViewModel) {
      if (
        countryCode == other.countryCode &&
        phoneNumber == other.phoneNumber &&
        accountAddress == other.accountAddress &&
        loginRequestSuccess == other.loginRequestSuccess &&
        loginVerifySuccess == other.loginVerifySuccess
      )
      return true;
    }
    return false;
  }

}