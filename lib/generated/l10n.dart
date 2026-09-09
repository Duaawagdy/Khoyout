// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Connection to server failed`
  String get connectionToServerFailed {
    return Intl.message(
      'Connection to server failed',
      name: 'connectionToServerFailed',
      desc: '',
      args: [],
    );
  }

  /// `requestToTheServerWasCancelled`
  String get requestToTheServerWasCancelled {
    return Intl.message(
      'requestToTheServerWasCancelled',
      name: 'requestToTheServerWasCancelled',
      desc: '',
      args: [],
    );
  }

  /// `Connection timeout with the server`
  String get connectionTimeoutWithTheServer {
    return Intl.message(
      'Connection timeout with the server',
      name: 'connectionTimeoutWithTheServer',
      desc: '',
      args: [],
    );
  }

  /// `Connection to the server failed due to internet connection`
  String get connectionToTheServerFailedDueToInternetConnection {
    return Intl.message(
      'Connection to the server failed due to internet connection',
      name: 'connectionToTheServerFailedDueToInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `Receive timeout in connection with the server`
  String get receiveTimeOutInConnectionWithTheServer {
    return Intl.message(
      'Receive timeout in connection with the server',
      name: 'receiveTimeOutInConnectionWithTheServer',
      desc: '',
      args: [],
    );
  }

  /// `Send timeout in connection with the server`
  String get sendTimeoutInConnectionWithTheServer {
    return Intl.message(
      'Send timeout in connection with the server',
      name: 'sendTimeoutInConnectionWithTheServer',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get somethingWentWrong {
    return Intl.message(
      'Something went wrong',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Unexpected error occurred`
  String get UnexpectedErrorOccurred {
    return Intl.message(
      'Unexpected error occurred',
      name: 'UnexpectedErrorOccurred',
      desc: '',
      args: [],
    );
  }

  /// `E-mail`
  String get Email {
    return Intl.message(
      'E-mail',
      name: 'Email',
      desc: '',
      args: [],
    );
  }

  /// `Enter your Email`
  String get EnteryourEmail {
    return Intl.message(
      'Enter your Email',
      name: 'EnteryourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get Password {
    return Intl.message(
      'Password',
      name: 'Password',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get Enteryourpassword {
    return Intl.message(
      'Enter your password',
      name: 'Enteryourpassword',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password ?`
  String get ForgotPassword {
    return Intl.message(
      'Forgot Password ?',
      name: 'ForgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get Login {
    return Intl.message(
      'Login',
      name: 'Login',
      desc: '',
      args: [],
    );
  }

  /// `name`
  String get name {
    return Intl.message(
      'name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `View All`
  String get ViewAll {
    return Intl.message(
      'View All',
      name: 'ViewAll',
      desc: '',
      args: [],
    );
  }

  /// `Products`
  String get Products {
    return Intl.message(
      'Products',
      name: 'Products',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get ConfirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'ConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter your name`
  String get Enteryourname {
    return Intl.message(
      'Enter your name',
      name: 'Enteryourname',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get SignUp {
    return Intl.message(
      'Sign Up',
      name: 'SignUp',
      desc: '',
      args: [],
    );
  }

  /// `I'm guest`
  String get Imguest {
    return Intl.message(
      'I\'m guest',
      name: 'Imguest',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get Continue {
    return Intl.message(
      'Continue',
      name: 'Continue',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get Cancel {
    return Intl.message(
      'Cancel',
      name: 'Cancel',
      desc: '',
      args: [],
    );
  }

  /// `Try again`
  String get Tryagain {
    return Intl.message(
      'Try again',
      name: 'Tryagain',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Khouyot`
  String get WelcometoKhouyot {
    return Intl.message(
      'Welcome to Khouyot',
      name: 'WelcometoKhouyot',
      desc: '',
      args: [],
    );
  }

  /// `Explore the latest collection of scarves and accessories with style and high quality.`
  String get Explorethelatestcollection {
    return Intl.message(
      'Explore the latest collection of scarves and accessories with style and high quality.',
      name: 'Explorethelatestcollection',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get Profile {
    return Intl.message(
      'Profile',
      name: 'Profile',
      desc: '',
      args: [],
    );
  }

  /// `Cart`
  String get Cart {
    return Intl.message(
      'Cart',
      name: 'Cart',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get Home {
    return Intl.message(
      'Home',
      name: 'Home',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get Categories {
    return Intl.message(
      'Categories',
      name: 'Categories',
      desc: '',
      args: [],
    );
  }

  /// `Forget Password`
  String get ForgetPassword {
    return Intl.message(
      'Forget Password',
      name: 'ForgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email account to reset password`
  String get Enteryouremailaccount {
    return Intl.message(
      'Enter your email account to reset password',
      name: 'Enteryouremailaccount',
      desc: '',
      args: [],
    );
  }

  /// `Passwords is not matching`
  String get Passwordsisnotmatching {
    return Intl.message(
      'Passwords is not matching',
      name: 'Passwordsisnotmatching',
      desc: '',
      args: [],
    );
  }

  /// `Enter Verification Code`
  String get EnterVerificationCode {
    return Intl.message(
      'Enter Verification Code',
      name: 'EnterVerificationCode',
      desc: '',
      args: [],
    );
  }

  /// `We have sent you a verification code`
  String get Wehavesentyouaverificationcode {
    return Intl.message(
      'We have sent you a verification code',
      name: 'Wehavesentyouaverificationcode',
      desc: '',
      args: [],
    );
  }

  /// `Don’t receive OTP ?`
  String get DontreceiveOTP {
    return Intl.message(
      'Don’t receive OTP ?',
      name: 'DontreceiveOTP',
      desc: '',
      args: [],
    );
  }

  /// ` Resend code `
  String get Resendcode {
    return Intl.message(
      ' Resend code ',
      name: 'Resendcode',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get Verify {
    return Intl.message(
      'Verify',
      name: 'Verify',
      desc: '',
      args: [],
    );
  }

  /// `error`
  String get error {
    return Intl.message(
      'error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `otp is not right`
  String get otpisnotright {
    return Intl.message(
      'otp is not right',
      name: 'otpisnotright',
      desc: '',
      args: [],
    );
  }

  /// `shop Now`
  String get shopNow {
    return Intl.message(
      'shop Now',
      name: 'shopNow',
      desc: '',
      args: [],
    );
  }

  /// `EGP`
  String get EGP {
    return Intl.message(
      'EGP',
      name: 'EGP',
      desc: '',
      args: [],
    );
  }

  /// `What are you looking for?`
  String get Whatareyoulookingfor {
    return Intl.message(
      'What are you looking for?',
      name: 'Whatareyoulookingfor',
      desc: '',
      args: [],
    );
  }

  /// `Featured Products`
  String get FeaturedProducts {
    return Intl.message(
      'Featured Products',
      name: 'FeaturedProducts',
      desc: '',
      args: [],
    );
  }

  /// `Best Sellers`
  String get BestSellers {
    return Intl.message(
      'Best Sellers',
      name: 'BestSellers',
      desc: '',
      args: [],
    );
  }

  /// `Add to cart`
  String get Addtocart {
    return Intl.message(
      'Add to cart',
      name: 'Addtocart',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get Quantity {
    return Intl.message(
      'Quantity',
      name: 'Quantity',
      desc: '',
      args: [],
    );
  }

  /// `description`
  String get description {
    return Intl.message(
      'description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Colors`
  String get Colors {
    return Intl.message(
      'Colors',
      name: 'Colors',
      desc: '',
      args: [],
    );
  }

  /// `Add To Your Cart`
  String get AddToYourCart {
    return Intl.message(
      'Add To Your Cart',
      name: 'AddToYourCart',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get CreateAccount {
    return Intl.message(
      'Create Account',
      name: 'CreateAccount',
      desc: '',
      args: [],
    );
  }

  /// `My Orders`
  String get MyOrders {
    return Intl.message(
      'My Orders',
      name: 'MyOrders',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get Favorites {
    return Intl.message(
      'Favorites',
      name: 'Favorites',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get Logout {
    return Intl.message(
      'Logout',
      name: 'Logout',
      desc: '',
      args: [],
    );
  }

  /// `My Addresses`
  String get MyAddresses {
    return Intl.message(
      'My Addresses',
      name: 'MyAddresses',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get Settings {
    return Intl.message(
      'Settings',
      name: 'Settings',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get Language {
    return Intl.message(
      'Language',
      name: 'Language',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get ChangePassword {
    return Intl.message(
      'Change Password',
      name: 'ChangePassword',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get PrivacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'PrivacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get Notifications {
    return Intl.message(
      'Notifications',
      name: 'Notifications',
      desc: '',
      args: [],
    );
  }

  /// `Add To Cart`
  String get AddToCart {
    return Intl.message(
      'Add To Cart',
      name: 'AddToCart',
      desc: '',
      args: [],
    );
  }

  /// `Browse Products`
  String get BrowseProducts {
    return Intl.message(
      'Browse Products',
      name: 'BrowseProducts',
      desc: '',
      args: [],
    );
  }

  /// `Your favorites list is empty`
  String get Yourfavoriteslistisempty {
    return Intl.message(
      'Your favorites list is empty',
      name: 'Yourfavoriteslistisempty',
      desc: '',
      args: [],
    );
  }

  /// `Start exploring Khyout collections and save the items you love.`
  String get StartexploringKhyout {
    return Intl.message(
      'Start exploring Khyout collections and save the items you love.',
      name: 'StartexploringKhyout',
      desc: '',
      args: [],
    );
  }

  /// `Reviews`
  String get Reviews {
    return Intl.message(
      'Reviews',
      name: 'Reviews',
      desc: '',
      args: [],
    );
  }

  /// `Please select a color option`
  String get pleaseSelectColor {
    return Intl.message(
      'Please select a color option',
      name: 'pleaseSelectColor',
      desc: '',
      args: [],
    );
  }

  /// `This product hasn’t been reviewed yet.`
  String get noReviewsYet {
    return Intl.message(
      'This product hasn’t been reviewed yet.',
      name: 'noReviewsYet',
      desc: '',
      args: [],
    );
  }

  /// `Best`
  String get Best {
    return Intl.message(
      'Best',
      name: 'Best',
      desc: '',
      args: [],
    );
  }

  /// `payment summary`
  String get paymentsummary {
    return Intl.message(
      'payment summary',
      name: 'paymentsummary',
      desc: '',
      args: [],
    );
  }

  /// `Subtotal`
  String get Subtotal {
    return Intl.message(
      'Subtotal',
      name: 'Subtotal',
      desc: '',
      args: [],
    );
  }

  /// `Password Not Matched`
  String get PasswordNotMatched {
    return Intl.message(
      'Password Not Matched',
      name: 'PasswordNotMatched',
      desc: '',
      args: [],
    );
  }

  /// `Password Too Short`
  String get PasswordTooShort {
    return Intl.message(
      'Password Too Short',
      name: 'PasswordTooShort',
      desc: '',
      args: [],
    );
  }

  /// `Discount`
  String get Discount {
    return Intl.message(
      'Discount',
      name: 'Discount',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get Total {
    return Intl.message(
      'Total',
      name: 'Total',
      desc: '',
      args: [],
    );
  }

  /// `Items`
  String get Items {
    return Intl.message(
      'Items',
      name: 'Items',
      desc: '',
      args: [],
    );
  }

  /// `Checkout`
  String get Checkout {
    return Intl.message(
      'Checkout',
      name: 'Checkout',
      desc: '',
      args: [],
    );
  }

  /// `Shipping Fee`
  String get ShippingFee {
    return Intl.message(
      'Shipping Fee',
      name: 'ShippingFee',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get Name {
    return Intl.message(
      'Name',
      name: 'Name',
      desc: '',
      args: [],
    );
  }

  /// `save`
  String get save {
    return Intl.message(
      'save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Current Password`
  String get CurrentPassword {
    return Intl.message(
      'Current Password',
      name: 'CurrentPassword',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get NewPassword {
    return Intl.message(
      'New Password',
      name: 'NewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm New Password`
  String get ConfirmNewPassword {
    return Intl.message(
      'Confirm New Password',
      name: 'ConfirmNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Update Password`
  String get UPdatePassword {
    return Intl.message(
      'Update Password',
      name: 'UPdatePassword',
      desc: '',
      args: [],
    );
  }

  /// `No items in your cart yet`
  String get Noitemsinyourcartyet {
    return Intl.message(
      'No items in your cart yet',
      name: 'Noitemsinyourcartyet',
      desc: '',
      args: [],
    );
  }

  /// `Pick your favorites and enjoy a smooth shopping experience.`
  String get Pickyourfavorites {
    return Intl.message(
      'Pick your favorites and enjoy a smooth shopping experience.',
      name: 'Pickyourfavorites',
      desc: '',
      args: [],
    );
  }

  /// `Browse product`
  String get Browseproduct {
    return Intl.message(
      'Browse product',
      name: 'Browseproduct',
      desc: '',
      args: [],
    );
  }

  /// `Color`
  String get Color {
    return Intl.message(
      'Color',
      name: 'Color',
      desc: '',
      args: [],
    );
  }

  /// `Home Wear`
  String get HomeWear {
    return Intl.message(
      'Home Wear',
      name: 'HomeWear',
      desc: '',
      args: [],
    );
  }

  /// `Shipping Address`
  String get ShippingAddress {
    return Intl.message(
      'Shipping Address',
      name: 'ShippingAddress',
      desc: '',
      args: [],
    );
  }

  /// `Add Address`
  String get AddAddress {
    return Intl.message(
      'Add Address',
      name: 'AddAddress',
      desc: '',
      args: [],
    );
  }

  /// `pay with`
  String get paywith {
    return Intl.message(
      'pay with',
      name: 'paywith',
      desc: '',
      args: [],
    );
  }

  /// `Coupon Code`
  String get CouponCode {
    return Intl.message(
      'Coupon Code',
      name: 'CouponCode',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get Apply {
    return Intl.message(
      'Apply',
      name: 'Apply',
      desc: '',
      args: [],
    );
  }

  /// `Order Summary`
  String get OrderSummary {
    return Intl.message(
      'Order Summary',
      name: 'OrderSummary',
      desc: '',
      args: [],
    );
  }

  /// `Select Payment`
  String get SelectPayment {
    return Intl.message(
      'Select Payment',
      name: 'SelectPayment',
      desc: '',
      args: [],
    );
  }

  /// `slide to order`
  String get slideorder {
    return Intl.message(
      'slide to order',
      name: 'slideorder',
      desc: '',
      args: [],
    );
  }

  /// `Processing your order...`
  String get Processingyouorder {
    return Intl.message(
      'Processing your order...',
      name: 'Processingyouorder',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get Address {
    return Intl.message(
      'Address',
      name: 'Address',
      desc: '',
      args: [],
    );
  }

  /// `password Reset Successfully`
  String get passwordResetSuccessfully {
    return Intl.message(
      'password Reset Successfully',
      name: 'passwordResetSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email address`
  String get InvalidEmail {
    return Intl.message(
      'Please enter a valid email address',
      name: 'InvalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 8 characters`
  String get PasswordMin8 {
    return Intl.message(
      'Password must be at least 8 characters',
      name: 'PasswordMin8',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one uppercase letter`
  String get PasswordUppercase {
    return Intl.message(
      'Password must contain at least one uppercase letter',
      name: 'PasswordUppercase',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one number`
  String get PasswordNumber {
    return Intl.message(
      'Password must contain at least one number',
      name: 'PasswordNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please wait a moment while we securely confirm your order.`
  String get Pleasewaitmomentwhile {
    return Intl.message(
      'Please wait a moment while we securely confirm your order.',
      name: 'Pleasewaitmomentwhile',
      desc: '',
      args: [],
    );
  }

  /// `Area / District`
  String get area {
    return Intl.message(
      'Area / District',
      name: 'area',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Save Address`
  String get SaveAddress {
    return Intl.message(
      'Save Address',
      name: 'SaveAddress',
      desc: '',
      args: [],
    );
  }

  /// `Street`
  String get street {
    return Intl.message(
      'Street',
      name: 'street',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get country {
    return Intl.message(
      'Country',
      name: 'country',
      desc: '',
      args: [],
    );
  }

  /// `Building Number`
  String get buildingNumber {
    return Intl.message(
      'Building Number',
      name: 'buildingNumber',
      desc: '',
      args: [],
    );
  }

  /// `Apartment Number`
  String get ApartamentNumber {
    return Intl.message(
      'Apartment Number',
      name: 'ApartamentNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please select payment Method`
  String get pleaseselectpaymentMethod {
    return Intl.message(
      'Please select payment Method',
      name: 'pleaseselectpaymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Please Add Address`
  String get pleaseAddAddress {
    return Intl.message(
      'Please Add Address',
      name: 'pleaseAddAddress',
      desc: '',
      args: [],
    );
  }

  /// `View Other Products`
  String get ViewOtherProducts {
    return Intl.message(
      'View Other Products',
      name: 'ViewOtherProducts',
      desc: '',
      args: [],
    );
  }

  /// `View cart`
  String get Viewcart {
    return Intl.message(
      'View cart',
      name: 'Viewcart',
      desc: '',
      args: [],
    );
  }

  /// `Cash on Delivery`
  String get CashonDelivery {
    return Intl.message(
      'Cash on Delivery',
      name: 'CashonDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Credit Card`
  String get CreditCard {
    return Intl.message(
      'Credit Card',
      name: 'CreditCard',
      desc: '',
      args: [],
    );
  }

  /// `Payment Method`
  String get PaymentMethod {
    return Intl.message(
      'Payment Method',
      name: 'PaymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Delivery date`
  String get Deliverydate {
    return Intl.message(
      'Delivery date',
      name: 'Deliverydate',
      desc: '',
      args: [],
    );
  }

  /// `Total Amount`
  String get TotalAmount {
    return Intl.message(
      'Total Amount',
      name: 'TotalAmount',
      desc: '',
      args: [],
    );
  }

  /// `Data`
  String get Data {
    return Intl.message(
      'Data',
      name: 'Data',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get Status {
    return Intl.message(
      'Status',
      name: 'Status',
      desc: '',
      args: [],
    );
  }

  /// `Order ID: #`
  String get orderid {
    return Intl.message(
      'Order ID: #',
      name: 'orderid',
      desc: '',
      args: [],
    );
  }

  /// `Order Details`
  String get OrderDetails {
    return Intl.message(
      'Order Details',
      name: 'OrderDetails',
      desc: '',
      args: [],
    );
  }

  /// `Back To Home`
  String get BackToHome {
    return Intl.message(
      'Back To Home',
      name: 'BackToHome',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get Filter {
    return Intl.message(
      'Filter',
      name: 'Filter',
      desc: '',
      args: [],
    );
  }

  /// `off`
  String get off {
    return Intl.message(
      'off',
      name: 'off',
      desc: '',
      args: [],
    );
  }

  /// `track your order`
  String get trackyourorder {
    return Intl.message(
      'track your order',
      name: 'trackyourorder',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Address`
  String get DeliveryAddress {
    return Intl.message(
      'Delivery Address',
      name: 'DeliveryAddress',
      desc: '',
      args: [],
    );
  }

  /// `Product Information`
  String get ProductInformation {
    return Intl.message(
      'Product Information',
      name: 'ProductInformation',
      desc: '',
      args: [],
    );
  }

  /// `review Product`
  String get reviewProduct {
    return Intl.message(
      'review Product',
      name: 'reviewProduct',
      desc: '',
      args: [],
    );
  }

  /// `Rating`
  String get Rating {
    return Intl.message(
      'Rating',
      name: 'Rating',
      desc: '',
      args: [],
    );
  }

  /// `Write Your Review`
  String get WriteYourReview {
    return Intl.message(
      'Write Your Review',
      name: 'WriteYourReview',
      desc: '',
      args: [],
    );
  }

  /// `Submit Review`
  String get SubmitReview {
    return Intl.message(
      'Submit Review',
      name: 'SubmitReview',
      desc: '',
      args: [],
    );
  }

  /// `Your product review has been submitted`
  String get Yourproductreviewhasbeensubmitted {
    return Intl.message(
      'Your product review has been submitted',
      name: 'Yourproductreviewhasbeensubmitted',
      desc: '',
      args: [],
    );
  }

  /// `Thank you for your review!`
  String get Thankyouforyourreview {
    return Intl.message(
      'Thank you for your review!',
      name: 'Thankyouforyourreview',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get Done {
    return Intl.message(
      'Done',
      name: 'Done',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get Title {
    return Intl.message(
      'Title',
      name: 'Title',
      desc: '',
      args: [],
    );
  }

  /// `you Already Reviewed this Product`
  String get youAleadyRevwiesthisProduct {
    return Intl.message(
      'you Already Reviewed this Product',
      name: 'youAleadyRevwiesthisProduct',
      desc: '',
      args: [],
    );
  }

  /// `Edit Address`
  String get editAddress {
    return Intl.message(
      'Edit Address',
      name: 'editAddress',
      desc: '',
      args: [],
    );
  }

  /// `Your order has been placed successfully!`
  String get Yourorderhasbeenplacedsuccessfully {
    return Intl.message(
      'Your order has been placed successfully!',
      name: 'Yourorderhasbeenplacedsuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `please Add Quantity`
  String get pleaseAddQuantity {
    return Intl.message(
      'please Add Quantity',
      name: 'pleaseAddQuantity',
      desc: '',
      args: [],
    );
  }

  /// `in your cart`
  String get inyourcart {
    return Intl.message(
      'in your cart',
      name: 'inyourcart',
      desc: '',
      args: [],
    );
  }

  /// `Login to your account`
  String get logintoyouraccount {
    return Intl.message(
      'Login to your account',
      name: 'logintoyouraccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign in to track your orders, save favorites, and enjoy a smoother shopping experience.`
  String get Signintotrackyourorders {
    return Intl.message(
      'Sign in to track your orders, save favorites, and enjoy a smoother shopping experience.',
      name: 'Signintotrackyourorders',
      desc: '',
      args: [],
    );
  }

  /// `Create your account`
  String get Createyouraccount {
    return Intl.message(
      'Create your account',
      name: 'Createyouraccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign up to enjoy a smoother shopping experience, save favorites, and track your orders easily.`
  String get Signuptoenjoysmoother {
    return Intl.message(
      'Sign up to enjoy a smoother shopping experience, save favorites, and track your orders easily.',
      name: 'Signuptoenjoysmoother',
      desc: '',
      args: [],
    );
  }

  /// `No Product For This Category`
  String get noProductForthisCategory {
    return Intl.message(
      'No Product For This Category',
      name: 'noProductForthisCategory',
      desc: '',
      args: [],
    );
  }

  /// `PriceRange`
  String get PriceRange {
    return Intl.message(
      'PriceRange',
      name: 'PriceRange',
      desc: '',
      args: [],
    );
  }

  /// `Must not Be Empty`
  String get MustnotBeEmpty {
    return Intl.message(
      'Must not Be Empty',
      name: 'MustnotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Processing your order...`
  String get Processingyourorder {
    return Intl.message(
      'Processing your order...',
      name: 'Processingyourorder',
      desc: '',
      args: [],
    );
  }

  /// `Please wait a moment while we securely confirm your order.`
  String get Pleasewaitmomentorder {
    return Intl.message(
      'Please wait a moment while we securely confirm your order.',
      name: 'Pleasewaitmomentorder',
      desc: '',
      args: [],
    );
  }

  /// `Add 850 EGP to cart and get free shipping!  `
  String get AddEGPtocartandgetfreeshipping {
    return Intl.message(
      'Add 850 EGP to cart and get free shipping!  ',
      name: 'AddEGPtocartandgetfreeshipping',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get language {
    return Intl.message(
      'English',
      name: 'language',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
