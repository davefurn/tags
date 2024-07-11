import 'package:flutter/material.dart';

const String emptyEmailField = 'Email field cannot be empty!';
const String emptyTextField = 'Field cannot be empty!';
const String phoneField = 'Phone Field cannot be empty!';
const String emptyPasswordField = 'Password field cannot be empty';
const String invalidEmailField =
    "Email provided isn't valid.Try another email address";
const String invalidUsernameField = 'username must contain no space';
const String passwordLengthError = 'Password length must be greater than 3';
const String invalidPassword =
    'password must contain at least 1 symbol, \n1 number, 1 lowercase & 1 uppercase';
const String emptyUsernameField = 'Username  cannot be empty';
const String usernameLengthError = 'Username length must be greater than 6';
const String emailRegex = '[a-zA-Z0-9+._%-+]{1,256}'
    r'\@'
    r'[a-zA-Z0-9][a-zA-Z0-9\-]{0,64}'
    '('
    r'\.'
    r'[a-zA-Z0-9][a-zA-Z0-9\-]{0,25}'
    ')+';
const String usernameRegex =
    r'\s'; //a string consisting only of non-whitespaces
const String passwordRegex =
    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
const String upperCaseRegex = r'^(?=.*?[A-Z]).{1,}$';
const String lowerCaseRegex = r'^(?=.*?[a-z]).{1,}$';
const String symbolRegex = r'^(?=.*?[!@#\$&*~]).{1,}$';
const String digitRegex = r'^(?=.*?[0-9]).{1,}$';

const String phoneNumberRegex = r'0[789][01]\d{8}';

const String phoneNumberLengthError = 'Phone number must be 11 digits';

const String invalidPhoneNumberField =
    "Number provided isn't valid.Try another phone number";

const String invalidAccountNumberField =
    "Number provided isn't a valid account number";

const String invalidNINField = 'NIN should contain 11 digits';

const String invalidDOBField = 'Date of Birth Provided is incomplete';

const String invalidPinNumberField = 'PIN must be 4 digits long';
const String invalidPasswordNumberField = 'Password must be 6 digits long';

const String invalidGender = 'Gender should be Male or Female';
const String invalidBVNField = 'BVN provided is incomplete';

//MediaQuery Width
double width(BuildContext context) => MediaQuery.of(context).size.width;

//MediaQuery Height
double height(BuildContext context) => MediaQuery.of(context).size.height;

String capitalize(String s) =>
    s[0].toUpperCase() + s.substring(1).toLowerCase();

const double bodyPadding = 20;
const double topPadding = 52;

//BillS
const String billPayment = 'bill_payment';
const String utility = 'utility';
const String airtime = 'airtime';
const String data = 'data';

const String others = 'others';
const String liveToken = 'live_token';

// const int bankId = 2;
const int bankId = 1;

//Transfer
const String transfer = 'transfer';
const String otherbanktransfer = 'other_bank_transfer';
const selftransfer = 'self_transfer';

const String kcbanktransfer = 'kc_bank_transfer';
const kcMicrofinance = 'KC Micro-finance Bank';

//OTP
const String passwordResetSentOTP =
    'A Password reset OTP has been sent to your phone number and Email Address';
const String invalidOTPField = 'OTP should contain 6 digits';
const String localFundsTransfer = 'LOCALFUNDSTRANSFER';
// const String kcmfbPhone = "09164500122";
// const String kcmfbEmail = "transact@kcmfb.com";
const String disclaimer =
    "Your transaction has been successfully processed. Note, however, that completion of any transfer may be affected by other factors including but not limited to transmission errors, incomplete information, flunctuations on the network/internet, interruptions, glitch, delayed information or other matters beyond the Bank's control which may impact on the transaction and for which the Bank will not be liable. All transactions are subject to confirmation and fraud proof verification.";
const String enquiryContact =
    'If you have any questions or would like more information, please do not hesistate contact our e-service team on 09164500122 or send an email to transact@kcmfb.com';

const String sendemail = ' or send an email to ';
// const String thanks = "Thank you for choosing KC Microfinance Bank.";

// List<DropDownModel> complaintList = [
//   DropDownModel(value: 'account issues', display: 'Account Issues'),
//   DropDownModel(
//       value: 'mobile banking issues', display: 'Mobile Banking Issues'),
//   DropDownModel(
//       value: 'unsuccessful transfer', display: 'Unsuccessful Transfer'),
//   DropDownModel(value: 'loan issues', display: 'Loan Issues'),
//   DropDownModel(
//       value: 'bill payment/airtime issues',
//       display: 'Bill Payment/Airtime Issues'),
//   DropDownModel(value: 'debit card issues', display: 'Debit Card Issues'),
//   DropDownModel(value: 'others', display: 'Others'),
// ];

//Log Issues TExts
const String issue1 =
    'Recipient’s bank could not confirm \nthe transaction with the bank reference';
const String issue2 =
    'Recipient of this wrong transfer has returned  \nmy money and I want to cancel the recall request';
const String issue3 =
    'I have neither executed nor authorized  \nthe following transaction (POS)';
const String issue4 =
    'I have been charged more than once  \nfor a single transaction';
const String issue5 = 'Other Issues';

//Make request Strings...
const String request1 = 'Request for increase in transaction Limit';
const String request2 = 'Request for Fund';
const String request3 = 'Request for raise in commission';
const String request4 = 'Others';
