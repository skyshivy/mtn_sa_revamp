// To parse this JSON data, do
//
//     final appSettingModel = appSettingModelFromJson(jsonString);

import 'dart:convert';

AppSettingModel appSettingModelFromJson(String str) =>
    AppSettingModel.fromJson(json.decode(str));

String appSettingModelToJson(AppSettingModel data) =>
    json.encode(data.toJson());

class AppSettingModel {
  ResponseMap? responseMap;
  String? message;
  String? respTime;
  String? statusCode;

  AppSettingModel({
    this.responseMap,
    this.message,
    this.respTime,
    this.statusCode,
  });

  factory AppSettingModel.fromJson(Map<String, dynamic> json) =>
      AppSettingModel(
        responseMap: json["responseMap"] == null
            ? null
            : ResponseMap.fromJson(json["responseMap"]),
        message: json["message"],
        respTime: json["respTime"],
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "responseMap": responseMap?.toJson(),
        "message": message,
        "respTime": respTime,
        "statusCode": statusCode,
      };
}

class ResponseMap {
  Settings? settings;

  ResponseMap({
    this.settings,
  });

  factory ResponseMap.fromJson(Map<String, dynamic> json) => ResponseMap(
        settings: json["settings"] == null
            ? null
            : Settings.fromJson(json["settings"]),
      );

  Map<String, dynamic> toJson() => {
        "settings": settings?.toJson(),
      };
}

class Settings {
  Others? others;

  Settings({
    this.others,
  });

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        others: json["others"] == null ? null : Others.fromJson(json["others"]),
      );

  Map<String, dynamic> toJson() => {
        "others": others?.toJson(),
      };
}

class Others {
  AboutAppurlBurmese? featuredCategoryEnglish;
  AboutAppurlBurmese? featuredCategoryBurmese;
  AboutAppurlBurmese? loginFeaturedCategoryEnglish;
  AboutAppurlBurmese? loginFeaturedCategoryBurmese;
  AboutAppurlBurmese? karaokePrice;
  AboutAppurlBurmese? tonePrice;
  AboutAppurlBurmese? karaokePriceEnglish;
  AboutAppurlBurmese? karaokePriceBurmese;
  AboutAppurlBurmese? playlistPriceBurmese;
  AboutAppurlBurmese? playlistPriceEnglish;
  AboutAppurlBurmese? filterParams;
  AboutAppurlBurmese? channelId;
  AboutAppurlBurmese? playlistEnglish;
  AboutAppurlBurmese? playlistBurmese;
  AboutAppurlBurmese? tndEnglish;
  AboutAppurlBurmese? tndBurmese;
  AboutAppurlBurmese? aboutAppurlBurmese;
  AboutAppurlBurmese? aboutAppurlEnglish;
  AboutAppurlBurmese? exploreTunesBurmese;
  AboutAppurlBurmese? exploreTunesEnglish;
  AboutAppurlBurmese? diyTndEnglish;
  AboutAppurlBurmese? diyTndBurmese;
  AboutAppurlBurmese? helpEnglish;
  AboutAppurlBurmese? helpBurmese;
  AboutAppurlBurmese? pPolicyEnglish;
  AboutAppurlBurmese? pPolicyBurmese;
  AboutAppurlBurmese? validityBurmese;
  AboutAppurlBurmese? validityEnglish;
  AboutAppurlBurmese? diyPriceEnglish;
  AboutAppurlBurmese? mcPriceEnglish;
  AboutAppurlBurmese? diyPriceBurmese;
  AboutAppurlBurmese? packnameBurmese;
  AboutAppurlBurmese? packnameEnglish;
  AboutAppurlBurmese? buyToneEnglish;
  AboutAppurlBurmese? setDefaultToneEnglish;
  AboutAppurlBurmese? giftToneEnglish;
  AboutAppurlBurmese? specificToneEnglish;
  AboutAppurlBurmese? setTimeEnglish;
  AboutAppurlBurmese? defaultTonePriceEnglish;
  AboutAppurlBurmese? defaultTone;
  AboutAppurlBurmese? defaultToneExpiryDateEnglish;
  AboutAppurlBurmese? defaultToneExpiryDateBurmese;
  AboutAppurlBurmese? nameTuneCategoryid;
  WishlistImageUrl? wishlistImageUrl;
  MtnHomeLink? wishlistToneUrl;
  AboutAppurlBurmese? fetchLimit;
  AboutAppurlBurmese? status;
  AboutAppurlBurmese? statusrbtEnglish;
  AboutAppurlBurmese? statusrbtBurmese;
  AboutAppurlBurmese? statusPriceTextEnglish;
  AboutAppurlBurmese? nametunePriceBurmese;
  AboutAppurlBurmese? nametunePriceEnglish;
  AboutAppurlBurmese? crbtVipOfferCode;
  AboutAppurlBurmese? crbtWeeklyOfferCode;
  AboutAppurlBurmese? crbtMonthlyOfferCode;
  AboutAppurlBurmese? crbtDailyOfferCode;
  MtnHomeLink? mtnHomeLink;
  Faq? faqBurmese;
  Faq? faqEnglish;

  Others({
    this.featuredCategoryEnglish,
    this.featuredCategoryBurmese,
    this.loginFeaturedCategoryEnglish,
    this.loginFeaturedCategoryBurmese,
    this.karaokePrice,
    this.tonePrice,
    this.karaokePriceEnglish,
    this.karaokePriceBurmese,
    this.playlistPriceBurmese,
    this.playlistPriceEnglish,
    this.filterParams,
    this.channelId,
    this.playlistEnglish,
    this.playlistBurmese,
    this.tndEnglish,
    this.tndBurmese,
    this.aboutAppurlBurmese,
    this.aboutAppurlEnglish,
    this.exploreTunesBurmese,
    this.exploreTunesEnglish,
    this.diyTndEnglish,
    this.diyTndBurmese,
    this.helpEnglish,
    this.helpBurmese,
    this.pPolicyEnglish,
    this.pPolicyBurmese,
    this.validityBurmese,
    this.validityEnglish,
    this.diyPriceEnglish,
    this.mcPriceEnglish,
    this.diyPriceBurmese,
    this.packnameBurmese,
    this.packnameEnglish,
    this.buyToneEnglish,
    this.setDefaultToneEnglish,
    this.giftToneEnglish,
    this.specificToneEnglish,
    this.setTimeEnglish,
    this.defaultTonePriceEnglish,
    this.defaultTone,
    this.defaultToneExpiryDateEnglish,
    this.defaultToneExpiryDateBurmese,
    this.nameTuneCategoryid,
    this.wishlistImageUrl,
    this.wishlistToneUrl,
    this.fetchLimit,
    this.status,
    this.statusrbtEnglish,
    this.statusrbtBurmese,
    this.statusPriceTextEnglish,
    this.nametunePriceBurmese,
    this.nametunePriceEnglish,
    this.crbtVipOfferCode,
    this.crbtWeeklyOfferCode,
    this.crbtMonthlyOfferCode,
    this.crbtDailyOfferCode,
    this.mtnHomeLink,
    this.faqBurmese,
    this.faqEnglish,
  });

  factory Others.fromJson(Map<String, dynamic> json) => Others(
        featuredCategoryEnglish: json["FeaturedCategory_ENGLISH"] == null
            ? null
            : AboutAppurlBurmese.fromJson(json["FeaturedCategory_ENGLISH"]),
        featuredCategoryBurmese: json["FeaturedCategory_BURMESE"] == null
            ? null
            : AboutAppurlBurmese.fromJson(json["FeaturedCategory_BURMESE"]),
        loginFeaturedCategoryEnglish:
            json["LOGIN_FeaturedCategory_ENGLISH"] == null
                ? null
                : AboutAppurlBurmese.fromJson(
                    json["LOGIN_FeaturedCategory_ENGLISH"]),
        loginFeaturedCategoryBurmese:
            json["LOGIN_FeaturedCategory_BURMESE"] == null
                ? null
                : AboutAppurlBurmese.fromJson(
                    json["LOGIN_FeaturedCategory_BURMESE"]),
        karaokePrice: json["KARAOKE_PRICE"] == null
            ? null
            : AboutAppurlBurmese.fromJson(json["KARAOKE_PRICE"]),
        tonePrice: json["TONE_PRICE"] == null
            ? null
            : AboutAppurlBurmese.fromJson(json["TONE_PRICE"]),
        karaokePriceEnglish: json["KARAOKE_PRICE_ENGLISH"] == null
            ? null
            : AboutAppurlBurmese.fromJson(json["KARAOKE_PRICE_ENGLISH"]),
        karaokePriceBurmese: json["KARAOKE_PRICE_BURMESE"] == null
            ? null
            : AboutAppurlBurmese.fromJson(json["KARAOKE_PRICE_BURMESE"]),
        playlistPriceBurmese: json["PLAYLIST_PRICE_BURMESE"] == null
            ? null
            : AboutAppurlBurmese.fromJson(json["PLAYLIST_PRICE_BURMESE"]),
        playlistPriceEnglish: json["PLAYLIST_PRICE_ENGLISH"] == null
            ? null
            : AboutAppurlBurmese.fromJson(json["PLAYLIST_PRICE_ENGLISH"]),
        filterParams: json["FILTER_PARAMS"] == null
            ? null
            : AboutAppurlBurmese.fromJson(json["FILTER_PARAMS"]),
        channelId: json["CHANNEL_ID"] == null
            ? null
            : AboutAppurlBurmese.fromJson(json["CHANNEL_ID"]),
        playlistEnglish: json["PLAYLIST_ENGLISH"] == null
            ? null
            : AboutAppurlBurmese.fromJson(json["PLAYLIST_ENGLISH"]),
        playlistBurmese: json["PLAYLIST_BURMESE"] == null
            ? null
            : AboutAppurlBurmese.fromJson(json["PLAYLIST_BURMESE"]),
        tndEnglish: json["TND_ENGLISH"] == null
            ? null
            : AboutAppurlBurmese.fromJson(json["TND_ENGLISH"]),
        tndBurmese: json["TND_BURMESE"] == null
            ? null
            : AboutAppurlBurmese.fromJson(json["TND_BURMESE"]),
        aboutAppurlBurmese: json["AboutAPPURL_BURMESE"] == null
            ? null
            : AboutAppurlBurmese.fromJson(json["AboutAPPURL_BURMESE"]),
        aboutAppurlEnglish: json["AboutAPPURL_ENGLISH"] == null
            ? null
            : AboutAppurlBurmese.fromJson(json["AboutAPPURL_ENGLISH"]),
        exploreTunesBurmese: json["ExploreTunes_BURMESE"] == null
            ? null
            : AboutAppurlBurmese.fromJson(json["ExploreTunes_BURMESE"]),
        exploreTunesEnglish: json["ExploreTunes_ENGLISH"] == null
            ? null
            : AboutAppurlBurmese.fromJson(json["ExploreTunes_ENGLISH"]),
        diyTndEnglish: json["DIY_TND_ENGLISH"] == null
            ? null
            : AboutAppurlBurmese.fromJson(json["DIY_TND_ENGLISH"]),
        diyTndBurmese: json["DIY_TND_BURMESE"] == null
            ? null
            : AboutAppurlBurmese.fromJson(json["DIY_TND_BURMESE"]),
        helpEnglish: json["HELP_ENGLISH"] == null
            ? null
            : AboutAppurlBurmese.fromJson(json["HELP_ENGLISH"]),
        helpBurmese: json["HELP_BURMESE"] == null
            ? null
            : AboutAppurlBurmese.fromJson(json["HELP_BURMESE"]),
        pPolicyEnglish: json["P_POLICY_ENGLISH"] == null
            ? null
            : AboutAppurlBurmese.fromJson(json["P_POLICY_ENGLISH"]),
        pPolicyBurmese: json["P_POLICY_BURMESE"] == null
            ? null
            : AboutAppurlBurmese.fromJson(json["P_POLICY_BURMESE"]),
        validityBurmese: json["VALIDITY_BURMESE"] == null
            ? null
            : AboutAppurlBurmese.fromJson(json["VALIDITY_BURMESE"]),
        validityEnglish: json["VALIDITY_ENGLISH"] == null
            ? null
            : AboutAppurlBurmese.fromJson(json["VALIDITY_ENGLISH"]),
        diyPriceEnglish: json["DIY_PRICE_ENGLISH"] == null
            ? null
            : AboutAppurlBurmese.fromJson(json["DIY_PRICE_ENGLISH"]),
        mcPriceEnglish: json["MC_PRICE_ENGLISH"] == null
            ? null
            : AboutAppurlBurmese.fromJson(json["MC_PRICE_ENGLISH"]),
        diyPriceBurmese: json["DIY_PRICE_BURMESE"] == null
            ? null
            : AboutAppurlBurmese.fromJson(json["DIY_PRICE_BURMESE"]),
        packnameBurmese: json["PACKNAME_BURMESE"] == null
            ? null
            : AboutAppurlBurmese.fromJson(json["PACKNAME_BURMESE"]),
        packnameEnglish: json["PACKNAME_ENGLISH"] == null
            ? null
            : AboutAppurlBurmese.fromJson(json["PACKNAME_ENGLISH"]),
        buyToneEnglish: json["BuyTone_ENGLISH"] == null
            ? null
            : AboutAppurlBurmese.fromJson(json["BuyTone_ENGLISH"]),
        setDefaultToneEnglish: json["SetDefaultTone_ENGLISH"] == null
            ? null
            : AboutAppurlBurmese.fromJson(json["SetDefaultTone_ENGLISH"]),
        giftToneEnglish: json["GiftTone_ENGLISH"] == null
            ? null
            : AboutAppurlBurmese.fromJson(json["GiftTone_ENGLISH"]),
        specificToneEnglish: json["SpecificTone_ENGLISH"] == null
            ? null
            : AboutAppurlBurmese.fromJson(json["SpecificTone_ENGLISH"]),
        setTimeEnglish: json["SetTime_ENGLISH"] == null
            ? null
            : AboutAppurlBurmese.fromJson(json["SetTime_ENGLISH"]),
        defaultTonePriceEnglish: json["DefaultTonePrice_ENGLISH"] == null
            ? null
            : AboutAppurlBurmese.fromJson(json["DefaultTonePrice_ENGLISH"]),
        defaultTone: json["DEFAULT_TONE"] == null
            ? null
            : AboutAppurlBurmese.fromJson(json["DEFAULT_TONE"]),
        defaultToneExpiryDateEnglish:
            json["DEFAULT_TONE_EXPIRY_DATE_ENGLISH"] == null
                ? null
                : AboutAppurlBurmese.fromJson(
                    json["DEFAULT_TONE_EXPIRY_DATE_ENGLISH"]),
        defaultToneExpiryDateBurmese:
            json["DEFAULT_TONE_EXPIRY_DATE_BURMESE"] == null
                ? null
                : AboutAppurlBurmese.fromJson(
                    json["DEFAULT_TONE_EXPIRY_DATE_BURMESE"]),
        nameTuneCategoryid: json["NAME_TUNE_CATEGORYID"] == null
            ? null
            : AboutAppurlBurmese.fromJson(json["NAME_TUNE_CATEGORYID"]),
        wishlistImageUrl: json["WISHLIST_IMAGE_URL"] == null
            ? null
            : WishlistImageUrl.fromJson(json["WISHLIST_IMAGE_URL"]),
        wishlistToneUrl: json["WISHLIST_TONE_URL"] == null
            ? null
            : MtnHomeLink.fromJson(json["WISHLIST_TONE_URL"]),
        fetchLimit: json["FETCH_LIMIT"] == null
            ? null
            : AboutAppurlBurmese.fromJson(json["FETCH_LIMIT"]),
        status: json["STATUS"] == null
            ? null
            : AboutAppurlBurmese.fromJson(json["STATUS"]),
        statusrbtEnglish: json["STATUSRBT_ENGLISH"] == null
            ? null
            : AboutAppurlBurmese.fromJson(json["STATUSRBT_ENGLISH"]),
        statusrbtBurmese: json["STATUSRBT_BURMESE"] == null
            ? null
            : AboutAppurlBurmese.fromJson(json["STATUSRBT_BURMESE"]),
        statusPriceTextEnglish: json["STATUS_PRICE_TEXT_ENGLISH"] == null
            ? null
            : AboutAppurlBurmese.fromJson(json["STATUS_PRICE_TEXT_ENGLISH"]),
        nametunePriceBurmese: json["NAMETUNE_PRICE_BURMESE"] == null
            ? null
            : AboutAppurlBurmese.fromJson(json["NAMETUNE_PRICE_BURMESE"]),
        nametunePriceEnglish: json["NAMETUNE_PRICE_ENGLISH"] == null
            ? null
            : AboutAppurlBurmese.fromJson(json["NAMETUNE_PRICE_ENGLISH"]),
        crbtVipOfferCode: json["CRBT_VIP_OFFER_CODE"] == null
            ? null
            : AboutAppurlBurmese.fromJson(json["CRBT_VIP_OFFER_CODE"]),
        crbtWeeklyOfferCode: json["CRBT_WEEKLY_OFFER_CODE"] == null
            ? null
            : AboutAppurlBurmese.fromJson(json["CRBT_WEEKLY_OFFER_CODE"]),
        crbtMonthlyOfferCode: json["CRBT_MONTHLY_OFFER_CODE"] == null
            ? null
            : AboutAppurlBurmese.fromJson(json["CRBT_MONTHLY_OFFER_CODE"]),
        crbtDailyOfferCode: json["CRBT_DAILY_OFFER_CODE"] == null
            ? null
            : AboutAppurlBurmese.fromJson(json["CRBT_DAILY_OFFER_CODE"]),
        mtnHomeLink: json["MTN_HOME_LINK"] == null
            ? null
            : MtnHomeLink.fromJson(json["MTN_HOME_LINK"]),
        faqBurmese: json["FAQ_BURMESE"] == null
            ? null
            : Faq.fromJson(json["FAQ_BURMESE"]),
        faqEnglish: json["FAQ_ENGLISH"] == null
            ? null
            : Faq.fromJson(json["FAQ_ENGLISH"]),
      );

  Map<String, dynamic> toJson() => {
        "FeaturedCategory_ENGLISH": featuredCategoryEnglish?.toJson(),
        "FeaturedCategory_BURMESE": featuredCategoryBurmese?.toJson(),
        "LOGIN_FeaturedCategory_ENGLISH":
            loginFeaturedCategoryEnglish?.toJson(),
        "LOGIN_FeaturedCategory_BURMESE":
            loginFeaturedCategoryBurmese?.toJson(),
        "KARAOKE_PRICE": karaokePrice?.toJson(),
        "TONE_PRICE": tonePrice?.toJson(),
        "KARAOKE_PRICE_ENGLISH": karaokePriceEnglish?.toJson(),
        "KARAOKE_PRICE_BURMESE": karaokePriceBurmese?.toJson(),
        "PLAYLIST_PRICE_BURMESE": playlistPriceBurmese?.toJson(),
        "PLAYLIST_PRICE_ENGLISH": playlistPriceEnglish?.toJson(),
        "FILTER_PARAMS": filterParams?.toJson(),
        "CHANNEL_ID": channelId?.toJson(),
        "PLAYLIST_ENGLISH": playlistEnglish?.toJson(),
        "PLAYLIST_BURMESE": playlistBurmese?.toJson(),
        "TND_ENGLISH": tndEnglish?.toJson(),
        "TND_BURMESE": tndBurmese?.toJson(),
        "AboutAPPURL_BURMESE": aboutAppurlBurmese?.toJson(),
        "AboutAPPURL_ENGLISH": aboutAppurlEnglish?.toJson(),
        "ExploreTunes_BURMESE": exploreTunesBurmese?.toJson(),
        "ExploreTunes_ENGLISH": exploreTunesEnglish?.toJson(),
        "DIY_TND_ENGLISH": diyTndEnglish?.toJson(),
        "DIY_TND_BURMESE": diyTndBurmese?.toJson(),
        "HELP_ENGLISH": helpEnglish?.toJson(),
        "HELP_BURMESE": helpBurmese?.toJson(),
        "P_POLICY_ENGLISH": pPolicyEnglish?.toJson(),
        "P_POLICY_BURMESE": pPolicyBurmese?.toJson(),
        "VALIDITY_BURMESE": validityBurmese?.toJson(),
        "VALIDITY_ENGLISH": validityEnglish?.toJson(),
        "DIY_PRICE_ENGLISH": diyPriceEnglish?.toJson(),
        "MC_PRICE_ENGLISH": mcPriceEnglish?.toJson(),
        "DIY_PRICE_BURMESE": diyPriceBurmese?.toJson(),
        "PACKNAME_BURMESE": packnameBurmese?.toJson(),
        "PACKNAME_ENGLISH": packnameEnglish?.toJson(),
        "BuyTone_ENGLISH": buyToneEnglish?.toJson(),
        "SetDefaultTone_ENGLISH": setDefaultToneEnglish?.toJson(),
        "GiftTone_ENGLISH": giftToneEnglish?.toJson(),
        "SpecificTone_ENGLISH": specificToneEnglish?.toJson(),
        "SetTime_ENGLISH": setTimeEnglish?.toJson(),
        "DefaultTonePrice_ENGLISH": defaultTonePriceEnglish?.toJson(),
        "DEFAULT_TONE": defaultTone?.toJson(),
        "DEFAULT_TONE_EXPIRY_DATE_ENGLISH":
            defaultToneExpiryDateEnglish?.toJson(),
        "DEFAULT_TONE_EXPIRY_DATE_BURMESE":
            defaultToneExpiryDateBurmese?.toJson(),
        "NAME_TUNE_CATEGORYID": nameTuneCategoryid?.toJson(),
        "WISHLIST_IMAGE_URL": wishlistImageUrl?.toJson(),
        "WISHLIST_TONE_URL": wishlistToneUrl?.toJson(),
        "FETCH_LIMIT": fetchLimit?.toJson(),
        "STATUS": status?.toJson(),
        "STATUSRBT_ENGLISH": statusrbtEnglish?.toJson(),
        "STATUSRBT_BURMESE": statusrbtBurmese?.toJson(),
        "STATUS_PRICE_TEXT_ENGLISH": statusPriceTextEnglish?.toJson(),
        "NAMETUNE_PRICE_BURMESE": nametunePriceBurmese?.toJson(),
        "NAMETUNE_PRICE_ENGLISH": nametunePriceEnglish?.toJson(),
        "CRBT_VIP_OFFER_CODE": crbtVipOfferCode?.toJson(),
        "CRBT_WEEKLY_OFFER_CODE": crbtWeeklyOfferCode?.toJson(),
        "CRBT_MONTHLY_OFFER_CODE": crbtMonthlyOfferCode?.toJson(),
        "CRBT_DAILY_OFFER_CODE": crbtDailyOfferCode?.toJson(),
        "MTN_HOME_LINK": mtnHomeLink?.toJson(),
        "FAQ_BURMESE": faqBurmese?.toJson(),
        "FAQ_ENGLISH": faqEnglish?.toJson(),
      };
}

class AboutAppurlBurmese {
  bool? enable;
  String? description;
  String? attribute;

  AboutAppurlBurmese({
    this.enable,
    this.description,
    this.attribute,
  });

  factory AboutAppurlBurmese.fromJson(Map<String, dynamic> json) =>
      AboutAppurlBurmese(
        enable: json["enable"],
        description: json["description"],
        attribute: json["attribute"],
      );

  Map<String, dynamic> toJson() => {
        "enable": enable,
        "description": description,
        "attribute": attribute,
      };
}

class Faq {
  bool? enable;
  String? description;
  String? attribute;

  Faq({
    this.enable,
    this.description,
    this.attribute,
  });

  factory Faq.fromJson(Map<String, dynamic> json) => Faq(
        enable: json["enable"],
        description: json["description"],
        attribute: json["attribute"],
      );

  Map<String, dynamic> toJson() => {
        "enable": enable,
        "description": description,
        "attribute": attribute,
      };
}

class MtnHomeLink {
  bool? enable;
  String? description;
  String? attribute;

  MtnHomeLink({
    this.enable,
    this.description,
    this.attribute,
  });

  factory MtnHomeLink.fromJson(Map<String, dynamic> json) => MtnHomeLink(
        enable: json["enable"],
        description: json["description"],
        attribute: json["attribute"],
      );

  Map<String, dynamic> toJson() => {
        "enable": enable,
        "description": description,
        "attribute": attribute,
      };
}

class WishlistImageUrl {
  bool? enable;
  String? description;
  String? attribute;

  WishlistImageUrl({
    this.enable,
    this.description,
    this.attribute,
  });

  factory WishlistImageUrl.fromJson(Map<String, dynamic> json) =>
      WishlistImageUrl(
        enable: json["enable"],
        description: json["description"],
        attribute: json["attribute"],
      );

  Map<String, dynamic> toJson() => {
        "enable": enable,
        "description": description,
        "attribute": attribute,
      };
}
