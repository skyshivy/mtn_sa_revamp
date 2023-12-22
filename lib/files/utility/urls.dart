import 'package:mtn_sa_revamp/files/store_manager/store_manager.dart';
import 'package:mtn_sa_revamp/files/utility/constants.dart';

String versionCode = '7.0';
String appVersion = '1.0.6';
String channelId = '4';
String appId = "com.sixdee.oml_rbt_portal"; //'com.sixdee.oml_rbt_portal'; //
String os = "ios";
String ccid = '';
String userName = '';
String password = 'Oem@L#@1';
int timeOut = 30;
int resendOtpDuration = 90;
String facebook_url = '';
String instagram_url = '';
String twitter_url = '';
String linkedin_url = '';
String youtube_url = '';
String messanger_url = '';
String defaultImageUrl = ''; //DEFAULT_IMAGE_URL
String baseUrl = "";
String baseUrlSecurity = '';
String faqUrl = '';
String settingUrl = '${baseUrl}settings';
String checkOtpNewUserUrl = "${baseUrl}otp-check";
String buyTuneUrl = "${baseUrlSecurity}set-tone";
String getHistoryUrl = "${baseUrlSecurity}view-transactions-scm?";
String getTonePriceUrl = "${baseUrl}get-tone-price";
String addToWishlistUrl = "${baseUrlSecurity}add-to-wishlist";
String getpackStatusUrl = "${baseUrlSecurity}pack-status?";
String deleteDedicatedTuneUrl = "${baseUrlSecurity}delete-dedication";
String deletePlayingTuneUrl = "${baseUrlSecurity}delete-from-shuffle";
String deleteTuneUrl = "${baseUrlSecurity}delete-tone";
String deActivatePackUrl = "${baseUrlSecurity}deactivate-pack";

String regenTokenUrl = "${baseUrlSecurity}regen-token";
String recomurl = "${baseUrl}get-recommendation-songs?";
String homeBannerurl = "${baseUrl}banner?language=";
String newUserRegistrationUrl = "${baseUrl}registration";
String searchSpecificToneUrl = '${baseUrl}specific-search-tones?language';
String searchByTuneIdUrl =
    '${baseUrl}search-tone?language=English&pageNo=0&perPageCount=$pagePerCount&toneId=';
String getArtistSearchTuneUrl = "${baseUrl}search-tone?language=";
String subscriberValidationUrl = "${baseUrl}subscriber-validation";
String generateOtpUrl = "${baseUrl}generate-otp";
String confirmOtpUrl = "${baseUrl}confirm-otp";
String getSecurityTokenUrl = "${baseUrl}security-token";
String editProfileUrl = "${baseUrlSecurity}edit-profile";
String passwordValidationUrl = "${baseUrl}password-validation";
String passwordValidationAutoLoginUrl =
    "${baseUrl}password-validation"; //"${baseUrl}password-validation-3pp";
String categoryListUrl1 = "${baseUrl}categories";
String myWishListUrl = "${baseUrlSecurity}view-wishlist";
String deleteFromWishListUrl = "${baseUrlSecurity}delete-from-wishlist";

String suspendResumePackUrl = '${baseUrlSecurity}suspend-resume-pack';
String searchToneIdUrl = "${baseUrl}search-tone";
String sendGiftUrl = "${baseUrl}send-gift";
String nameTuneSearchUrl = "${baseUrl}specific-search-tones";

String getCategoryDetailUrl = "${baseUrl}search-tone";
String bannerDetailUrl = "${baseUrl}banner-search";
String bannerDetailManualUrl = "${baseUrl}get-banner-details";
String tuneSuffleUrl = '${baseUrlSecurity}shuffle-activation-deactivation';
String getprofileDetailUrl = "${baseUrlSecurity}get-profile-details";
String getPlayingTunesUrl =
    '${baseUrl}list-tones?language=0&startIndex=0&endIndex=40&rbtMode=0';
String getMyTuneListUrl =
    '${baseUrl}list-tones?language=0&startIndex=0&endIndex=40&rbtMode=400';

//====================================

String timeBaseTuneSetUrl =
    '${baseUrlSecurity}time-based-setting-for-already-activated';
String addToneToSuffleUrl = '${baseUrlSecurity}add-tone-to-shuffle';
String dedicatedTuneSetUrl =
    '${baseUrlSecurity}dedicated-user-tone-addition-with-time-setting';
    

  
// String fulldayTuneSetUrl =
//     '${baseUrlSecurity}time-based-setting-for-already-activated';
// String timeBaseTuneSet =
//     '${baseUrlSecurity}time-based-setting-for-already-activated';
    
