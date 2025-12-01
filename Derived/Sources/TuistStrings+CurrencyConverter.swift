// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {
  /// Added currency: %@
  public static func addedCurrency(_ p1: Any) -> String {
    return L10n.tr("Localizable", "added_currency", String(describing: p1), fallback: "Added currency: %@")
  }
  /// All Currencies
  public static var allCurrencies: String { return L10n.tr("Localizable", "all_currencies", fallback: "All Currencies") }
  /// All Currencies %@
  public static func allCurrenciesWithCount(_ p1: Any) -> String {
    return L10n.tr("Localizable", "all_currencies_with_count", String(describing: p1), fallback: "All Currencies %@")
  }
  /// Amount to convert
  public static var amountInputLabel: String { return L10n.tr("Localizable", "amount_input_label", fallback: "Amount to convert") }
  /// Enter amount in %@
  public static func amountPlaceholder(_ p1: Any) -> String {
    return L10n.tr("Localizable", "amount_placeholder", String(describing: p1), fallback: "Enter amount in %@")
  }
  /// Data decoding error
  public static var apiErrorDecoding: String { return L10n.tr("Localizable", "api_error_decoding", fallback: "Data decoding error") }
  /// Invalid API URL
  public static var apiErrorInvalidUrl: String { return L10n.tr("Localizable", "api_error_invalid_url", fallback: "Invalid API URL") }
  /// No data from server
  public static var apiErrorNoData: String { return L10n.tr("Localizable", "api_error_no_data", fallback: "No data from server") }
  /// No internet connection. Internet connection is required for the first launch.
  public static var apiErrorNoDataAndNoConnection: String { return L10n.tr("Localizable", "api_error_no_data_and_no_connection", fallback: "No internet connection. Internet connection is required for the first launch.") }
  /// Conversion Result
  public static var conversionResult: String { return L10n.tr("Localizable", "conversion_result", fallback: "Conversion Result") }
  /// Convert
  public static var convertButton: String { return L10n.tr("Localizable", "convert_button", fallback: "Convert") }
  /// Currency added!
  public static var currencyAdded: String { return L10n.tr("Localizable", "currency_added", fallback: "Currency added!") }
  /// %@ - %@
  /// added to currency list
  public static func currencyAddedMessage(_ p1: Any, _ p2: Any) -> String {
    return L10n.tr("Localizable", "currency_added_message", String(describing: p1), String(describing: p2), fallback: "%@ - %@\nadded to currency list")
  }
  /// UAE Dirham
  public static var currencyAED: String { return L10n.tr("Localizable", "currency_AED", fallback: "UAE Dirham") }
  /// Afghan Afghani
  public static var currencyAFN: String { return L10n.tr("Localizable", "currency_AFN", fallback: "Afghan Afghani") }
  /// Albanian Lek
  public static var currencyALL: String { return L10n.tr("Localizable", "currency_ALL", fallback: "Albanian Lek") }
  /// Armenian Dram
  public static var currencyAMD: String { return L10n.tr("Localizable", "currency_AMD", fallback: "Armenian Dram") }
  /// Argentine Peso
  public static var currencyARS: String { return L10n.tr("Localizable", "currency_ARS", fallback: "Argentine Peso") }
  /// Australian Dollar
  public static var currencyAUD: String { return L10n.tr("Localizable", "currency_AUD", fallback: "Australian Dollar") }
  /// Azerbaijani Manat
  public static var currencyAZN: String { return L10n.tr("Localizable", "currency_AZN", fallback: "Azerbaijani Manat") }
  /// Bosnia and Herzegovina Convertible Mark
  public static var currencyBAM: String { return L10n.tr("Localizable", "currency_BAM", fallback: "Bosnia and Herzegovina Convertible Mark") }
  /// Bulgarian Lev
  public static var currencyBGN: String { return L10n.tr("Localizable", "currency_BGN", fallback: "Bulgarian Lev") }
  /// Bahraini Dinar
  public static var currencyBHD: String { return L10n.tr("Localizable", "currency_BHD", fallback: "Bahraini Dinar") }
  /// Bolivian Boliviano
  public static var currencyBOB: String { return L10n.tr("Localizable", "currency_BOB", fallback: "Bolivian Boliviano") }
  /// Brazilian Real
  public static var currencyBRL: String { return L10n.tr("Localizable", "currency_BRL", fallback: "Brazilian Real") }
  /// Belarusian Ruble
  public static var currencyBYN: String { return L10n.tr("Localizable", "currency_BYN", fallback: "Belarusian Ruble") }
  /// Canadian Dollar
  public static var currencyCAD: String { return L10n.tr("Localizable", "currency_CAD", fallback: "Canadian Dollar") }
  /// Swiss Franc
  public static var currencyCHF: String { return L10n.tr("Localizable", "currency_CHF", fallback: "Swiss Franc") }
  /// Chilean Peso
  public static var currencyCLP: String { return L10n.tr("Localizable", "currency_CLP", fallback: "Chilean Peso") }
  /// Chinese Yuan
  public static var currencyCNY: String { return L10n.tr("Localizable", "currency_CNY", fallback: "Chinese Yuan") }
  /// Currency Converter
  public static var currencyConverterTitle: String { return L10n.tr("Localizable", "currency_converter_title", fallback: "Currency Converter") }
  /// Colombian Peso
  public static var currencyCOP: String { return L10n.tr("Localizable", "currency_COP", fallback: "Colombian Peso") }
  /// Czech Koruna
  public static var currencyCZK: String { return L10n.tr("Localizable", "currency_CZK", fallback: "Czech Koruna") }
  /// Danish Krone
  public static var currencyDKK: String { return L10n.tr("Localizable", "currency_DKK", fallback: "Danish Krone") }
  /// Egyptian Pound
  public static var currencyEGP: String { return L10n.tr("Localizable", "currency_EGP", fallback: "Egyptian Pound") }
  /// Ethiopian Birr
  public static var currencyETB: String { return L10n.tr("Localizable", "currency_ETB", fallback: "Ethiopian Birr") }
  /// Euro
  public static var currencyEUR: String { return L10n.tr("Localizable", "currency_EUR", fallback: "Euro") }
  /// Fijian Dollar
  public static var currencyFJD: String { return L10n.tr("Localizable", "currency_FJD", fallback: "Fijian Dollar") }
  /// British Pound Sterling
  public static var currencyGBP: String { return L10n.tr("Localizable", "currency_GBP", fallback: "British Pound Sterling") }
  /// Georgian Lari
  public static var currencyGEL: String { return L10n.tr("Localizable", "currency_GEL", fallback: "Georgian Lari") }
  /// Ghanaian Cedi
  public static var currencyGHS: String { return L10n.tr("Localizable", "currency_GHS", fallback: "Ghanaian Cedi") }
  /// Hong Kong Dollar
  public static var currencyHKD: String { return L10n.tr("Localizable", "currency_HKD", fallback: "Hong Kong Dollar") }
  /// Croatian Kuna
  public static var currencyHRK: String { return L10n.tr("Localizable", "currency_HRK", fallback: "Croatian Kuna") }
  /// Hungarian Forint
  public static var currencyHUF: String { return L10n.tr("Localizable", "currency_HUF", fallback: "Hungarian Forint") }
  /// Indonesian Rupiah
  public static var currencyIDR: String { return L10n.tr("Localizable", "currency_IDR", fallback: "Indonesian Rupiah") }
  /// Israeli New Shekel
  public static var currencyILS: String { return L10n.tr("Localizable", "currency_ILS", fallback: "Israeli New Shekel") }
  /// Indian Rupee
  public static var currencyINR: String { return L10n.tr("Localizable", "currency_INR", fallback: "Indian Rupee") }
  /// Icelandic Krona
  public static var currencyISK: String { return L10n.tr("Localizable", "currency_ISK", fallback: "Icelandic Krona") }
  /// Jordanian Dinar
  public static var currencyJOD: String { return L10n.tr("Localizable", "currency_JOD", fallback: "Jordanian Dinar") }
  /// Japanese Yen
  public static var currencyJPY: String { return L10n.tr("Localizable", "currency_JPY", fallback: "Japanese Yen") }
  /// Kenyan Shilling
  public static var currencyKES: String { return L10n.tr("Localizable", "currency_KES", fallback: "Kenyan Shilling") }
  /// Kyrgystani Som
  public static var currencyKGS: String { return L10n.tr("Localizable", "currency_KGS", fallback: "Kyrgystani Som") }
  /// South Korean Won
  public static var currencyKRW: String { return L10n.tr("Localizable", "currency_KRW", fallback: "South Korean Won") }
  /// Kuwaiti Dinar
  public static var currencyKWD: String { return L10n.tr("Localizable", "currency_KWD", fallback: "Kuwaiti Dinar") }
  /// Kazakhstani Tenge
  public static var currencyKZT: String { return L10n.tr("Localizable", "currency_KZT", fallback: "Kazakhstani Tenge") }
  /// Lebanese Pound
  public static var currencyLBP: String { return L10n.tr("Localizable", "currency_LBP", fallback: "Lebanese Pound") }
  /// Moroccan Dirham
  public static var currencyMAD: String { return L10n.tr("Localizable", "currency_MAD", fallback: "Moroccan Dirham") }
  /// Moldovan Leu
  public static var currencyMDL: String { return L10n.tr("Localizable", "currency_MDL", fallback: "Moldovan Leu") }
  /// Macedonian Denar
  public static var currencyMKD: String { return L10n.tr("Localizable", "currency_MKD", fallback: "Macedonian Denar") }
  /// Mexican Peso
  public static var currencyMXN: String { return L10n.tr("Localizable", "currency_MXN", fallback: "Mexican Peso") }
  /// Malaysian Ringgit
  public static var currencyMYR: String { return L10n.tr("Localizable", "currency_MYR", fallback: "Malaysian Ringgit") }
  /// Nigerian Naira
  public static var currencyNGN: String { return L10n.tr("Localizable", "currency_NGN", fallback: "Nigerian Naira") }
  /// Norwegian Krone
  public static var currencyNOK: String { return L10n.tr("Localizable", "currency_NOK", fallback: "Norwegian Krone") }
  /// New Zealand Dollar
  public static var currencyNZD: String { return L10n.tr("Localizable", "currency_NZD", fallback: "New Zealand Dollar") }
  /// Omani Rial
  public static var currencyOMR: String { return L10n.tr("Localizable", "currency_OMR", fallback: "Omani Rial") }
  /// Peruvian Sol
  public static var currencyPEN: String { return L10n.tr("Localizable", "currency_PEN", fallback: "Peruvian Sol") }
  /// Papua New Guinean Kina
  public static var currencyPGK: String { return L10n.tr("Localizable", "currency_PGK", fallback: "Papua New Guinean Kina") }
  /// Philippine Peso
  public static var currencyPHP: String { return L10n.tr("Localizable", "currency_PHP", fallback: "Philippine Peso") }
  /// Polish Zloty
  public static var currencyPLN: String { return L10n.tr("Localizable", "currency_PLN", fallback: "Polish Zloty") }
  /// Paraguayan Guarani
  public static var currencyPYG: String { return L10n.tr("Localizable", "currency_PYG", fallback: "Paraguayan Guarani") }
  /// Qatari Rial
  public static var currencyQAR: String { return L10n.tr("Localizable", "currency_QAR", fallback: "Qatari Rial") }
  /// Romanian Leu
  public static var currencyRON: String { return L10n.tr("Localizable", "currency_RON", fallback: "Romanian Leu") }
  /// Serbian Dinar
  public static var currencyRSD: String { return L10n.tr("Localizable", "currency_RSD", fallback: "Serbian Dinar") }
  /// Russian Ruble
  public static var currencyRUB: String { return L10n.tr("Localizable", "currency_RUB", fallback: "Russian Ruble") }
  /// Saudi Riyal
  public static var currencySAR: String { return L10n.tr("Localizable", "currency_SAR", fallback: "Saudi Riyal") }
  /// Solomon Islands Dollar
  public static var currencySBD: String { return L10n.tr("Localizable", "currency_SBD", fallback: "Solomon Islands Dollar") }
  /// Swedish Krona
  public static var currencySEK: String { return L10n.tr("Localizable", "currency_SEK", fallback: "Swedish Krona") }
  /// Singapore Dollar
  public static var currencySGD: String { return L10n.tr("Localizable", "currency_SGD", fallback: "Singapore Dollar") }
  /// Thai Baht
  public static var currencyTHB: String { return L10n.tr("Localizable", "currency_THB", fallback: "Thai Baht") }
  /// Tajikistani Somoni
  public static var currencyTJS: String { return L10n.tr("Localizable", "currency_TJS", fallback: "Tajikistani Somoni") }
  /// Turkmenistani Manat
  public static var currencyTMT: String { return L10n.tr("Localizable", "currency_TMT", fallback: "Turkmenistani Manat") }
  /// Tunisian Dinar
  public static var currencyTND: String { return L10n.tr("Localizable", "currency_TND", fallback: "Tunisian Dinar") }
  /// Tongan Pa'anga
  public static var currencyTOP: String { return L10n.tr("Localizable", "currency_TOP", fallback: "Tongan Pa'anga") }
  /// Turkish Lira
  public static var currencyTRY: String { return L10n.tr("Localizable", "currency_TRY", fallback: "Turkish Lira") }
  /// Tanzanian Shilling
  public static var currencyTZS: String { return L10n.tr("Localizable", "currency_TZS", fallback: "Tanzanian Shilling") }
  /// Ukrainian Hryvnia
  public static var currencyUAH: String { return L10n.tr("Localizable", "currency_UAH", fallback: "Ukrainian Hryvnia") }
  /// Ugandan Shilling
  public static var currencyUGX: String { return L10n.tr("Localizable", "currency_UGX", fallback: "Ugandan Shilling") }
  /// US Dollar
  public static var currencyUSD: String { return L10n.tr("Localizable", "currency_USD", fallback: "US Dollar") }
  /// Uruguayan Peso
  public static var currencyUYU: String { return L10n.tr("Localizable", "currency_UYU", fallback: "Uruguayan Peso") }
  /// Uzbekistani Som
  public static var currencyUZS: String { return L10n.tr("Localizable", "currency_UZS", fallback: "Uzbekistani Som") }
  /// Vietnamese Dong
  public static var currencyVND: String { return L10n.tr("Localizable", "currency_VND", fallback: "Vietnamese Dong") }
  /// Vanuatu Vatu
  public static var currencyVUV: String { return L10n.tr("Localizable", "currency_VUV", fallback: "Vanuatu Vatu") }
  /// Samoan Tala
  public static var currencyWST: String { return L10n.tr("Localizable", "currency_WST", fallback: "Samoan Tala") }
  /// Central African CFA Franc
  public static var currencyXAF: String { return L10n.tr("Localizable", "currency_XAF", fallback: "Central African CFA Franc") }
  /// East Caribbean Dollar
  public static var currencyXCD: String { return L10n.tr("Localizable", "currency_XCD", fallback: "East Caribbean Dollar") }
  /// West African CFA Franc
  public static var currencyXOF: String { return L10n.tr("Localizable", "currency_XOF", fallback: "West African CFA Franc") }
  /// CFP Franc
  public static var currencyXPF: String { return L10n.tr("Localizable", "currency_XPF", fallback: "CFP Franc") }
  /// South African Rand
  public static var currencyZAR: String { return L10n.tr("Localizable", "currency_ZAR", fallback: "South African Rand") }
  /// Dark Mode
  public static var darkMode: String { return L10n.tr("Localizable", "dark_mode", fallback: "Dark Mode") }
  /// Data outdated
  public static var dataOutdated: String { return L10n.tr("Localizable", "data_outdated", fallback: "Data outdated") }
  /// Decimal Precision
  public static var decimalPrecision: String { return L10n.tr("Localizable", "decimal_precision", fallback: "Decimal Precision") }
  /// Delete
  public static var delete: String { return L10n.tr("Localizable", "delete", fallback: "Delete") }
  /// Done
  public static var done: String { return L10n.tr("Localizable", "done", fallback: "Done") }
  /// Error: %@
  public static func errorColon(_ p1: Any) -> String {
    return L10n.tr("Localizable", "error_colon", String(describing: p1), fallback: "Error: %@")
  }
  /// Error: %@
  public static func errorPrefix(_ p1: Any) -> String {
    return L10n.tr("Localizable", "error_prefix", String(describing: p1), fallback: "Error: %@")
  }
  /// Rate:
  public static var exchangeRate: String { return L10n.tr("Localizable", "exchange_rate", fallback: "Rate:") }
  /// From
  public static var fromAmount: String { return L10n.tr("Localizable", "from_amount", fallback: "From") }
  /// FROM
  public static var fromCurrency: String { return L10n.tr("Localizable", "from_currency", fallback: "FROM") }
  /// Language
  public static var language: String { return L10n.tr("Localizable", "language", fallback: "Language") }
  /// Loading currencies...
  public static var loadingCurrencies: String { return L10n.tr("Localizable", "loading_currencies", fallback: "Loading currencies...") }
  /// Loading error
  public static var loadingError: String { return L10n.tr("Localizable", "loading_error", fallback: "Loading error") }
  /// Loading rates...
  public static var loadingRates: String { return L10n.tr("Localizable", "loading_rates", fallback: "Loading rates...") }
  /// No connection
  public static var noConnection: String { return L10n.tr("Localizable", "no_connection", fallback: "No connection") }
  /// OK
  public static var ok: String { return L10n.tr("Localizable", "ok", fallback: "OK") }
  /// Preferences
  public static var preferencesSection: String { return L10n.tr("Localizable", "preferences_section", fallback: "Preferences") }
  /// Rate App
  public static var rateApp: String { return L10n.tr("Localizable", "rate_app", fallback: "Rate App") }
  /// Retry
  public static var retry: String { return L10n.tr("Localizable", "retry", fallback: "Retry") }
  /// Search currencies
  public static var searchCurrencies: String { return L10n.tr("Localizable", "search_currencies", fallback: "Search currencies") }
  /// Select Currency
  public static var selectCurrency: String { return L10n.tr("Localizable", "select_currency", fallback: "Select Currency") }
  /// Send Feedback
  public static var sendFeedback: String { return L10n.tr("Localizable", "send_feedback", fallback: "Send Feedback") }
  /// Settings
  public static var settingsTitle: String { return L10n.tr("Localizable", "settings_title", fallback: "Settings") }
  /// Support
  public static var supportSection: String { return L10n.tr("Localizable", "support_section", fallback: "Support") }
  /// To
  public static var toAmount: String { return L10n.tr("Localizable", "to_amount", fallback: "To") }
  /// TO
  public static var toCurrency: String { return L10n.tr("Localizable", "to_currency", fallback: "TO") }
  /// Unknown currency
  public static var unknownCurrency: String { return L10n.tr("Localizable", "unknown_currency", fallback: "Unknown currency") }
  /// Updated: %@
  public static func updatedColon(_ p1: Any) -> String {
    return L10n.tr("Localizable", "updated_colon", String(describing: p1), fallback: "Updated: %@")
  }
  /// Version
  public static var version: String { return L10n.tr("Localizable", "version", fallback: "Version") }
  /// Welcome!
  public static var welcomeSubtitle: String { return L10n.tr("Localizable", "welcome_subtitle", fallback: "Welcome!") }
  /// Localizable.strings (English)
  ///   CurrencyConverter
  ///   Created by afon.com on 13.10.2025.
  public static var welcomeTitle: String { return L10n.tr("Localizable", "welcome_title", fallback: "Currency Converter") }
  public enum Language {
    /// 🇺🇸 English
    public static var english: String { return L10n.tr("Localizable", "language.english", fallback: "🇺🇸 English") }
    /// 🇷🇺 Русский
    public static var russian: String { return L10n.tr("Localizable", "language.russian", fallback: "🇷🇺 Русский") }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private enum LanguageCode: String {
  case russian = "ru"
  case english = "en"
  
  static var current: LanguageCode {
    let savedLanguage = UserDefaults.standard.string(forKey: "selectedLanguage")
    
    if let saved = savedLanguage,
       let language = LanguageCode(rawValue: saved) {
      return language
    }
    
    return .english
  }
}

private final class BundleToken {
  static var bundle: Bundle {
    let languageCode = LanguageCode.current.rawValue

    if let path = Bundle.main.path(forResource: languageCode, ofType: "lproj"),
       let bundle = Bundle(path: path) {
      return bundle
    }

    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }
}
// swiftlint:enable convenience_type

// swiftlint:enable all
