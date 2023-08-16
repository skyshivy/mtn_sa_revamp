import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';

String versionCode = '7.0';
String appVersion = '1.0.6';
String channelId = '4';
String appId = "com.sixdee.oml_rbt_portal"; //'com.sixdee.oml_rbt_portal'; //
String os = "ios";

int perPageCount = 20;
String baseUrl = "";
String baseUrlSecurity = '';
String faqUrl = '';
String settingUrl = '${baseUrl}settings';
String regenTokenUrl = "${baseUrlSecurity}regen-token";
String recomurl = "${baseUrl}get-recommendation-songs?";
String homeBannerurl = "${baseUrl}banner?language=";
String searchSpecificToneUrl = '${baseUrl}specific-search-tones?language';
String searchByTuneIdUrl =
    '${baseUrl}search-tone?language=English&pageNo=0&perPageCount=20&toneId=';
String getArtistSearchTuneUrl = "${baseUrl}search-tone?language=";
String subscriberValidationUrl = "${baseUrl}subscriber-validation";
String generateOtpUrl = "${baseUrl}generate-otp";
String confirmOtpUrl = "${baseUrl}confirm-otp";
String getSecurityTokenUrl = "${baseUrl}security-token";
String editProfileUrl = "${baseUrlSecurity}edit-profile";
String passwordValidationUrl = "${baseUrl}password-validation";
String categoryListUrl =
    "${baseUrl}categories?language=${StoreManager().language}";
String getCategoryDetailUrl =
    "${baseUrl}search-tone?language=${StoreManager().language}";
String bannerDetailUrl =
    "${baseUrl}banner-search?language=${StoreManager().language}";
String tuneSuffleUrl = '${baseUrlSecurity}shuffle-activation-deactivation';
String getprofileDetailUrl = "${baseUrlSecurity}get-profile-details";
String getPlayingTunesUrl =
    '${baseUrl}list-tones?language=0&msisdn=${StoreManager().msisdn}&startIndex=0&endIndex=40&rbtMode=0';
String getMyTuneListUrl =
    '${baseUrl}list-tones?language=0&msisdn=${StoreManager().msisdn}&startIndex=0&endIndex=40&rbtMode=400';
