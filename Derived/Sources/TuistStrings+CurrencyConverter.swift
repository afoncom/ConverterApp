// swiftlint:disable:this file_name
// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
public enum CurrencyConverterStrings: Sendable {
  /// Added currency: %@
  public static func addedCurrency(_ p1: Any) -> String {
    return CurrencyConverterStrings.tr("Localizable", "added_currency",String(describing: p1))
  }
  /// All Currencies
  public static let allCurrencies = CurrencyConverterStrings.tr("Localizable", "all_currencies")
  /// All Currencies %@
  public static func allCurrenciesWithCount(_ p1: Any) -> String {
    return CurrencyConverterStrings.tr("Localizable", "all_currencies_with_count",String(describing: p1))
  }
  /// Amount to convert
  public static let amountInputLabel = CurrencyConverterStrings.tr("Localizable", "amount_input_label")
  /// Enter amount in %@
  public static func amountPlaceholder(_ p1: Any) -> String {
    return CurrencyConverterStrings.tr("Localizable", "amount_placeholder",String(describing: p1))
  }
  /// Data decoding error
  public static let apiErrorDecoding = CurrencyConverterStrings.tr("Localizable", "api_error_decoding")
  /// Invalid API URL
  public static let apiErrorInvalidUrl = CurrencyConverterStrings.tr("Localizable", "api_error_invalid_url")
  /// No data from server
  public static let apiErrorNoData = CurrencyConverterStrings.tr("Localizable", "api_error_no_data")
  /// No internet connection. Internet connection is required for the first launch.
  public static let apiErrorNoDataAndNoConnection = CurrencyConverterStrings.tr("Localizable", "api_error_no_data_and_no_connection")
  /// Conversion Result
  public static let conversionResult = CurrencyConverterStrings.tr("Localizable", "conversion_result")
  /// Convert
  public static let convertButton = CurrencyConverterStrings.tr("Localizable", "convert_button")
  /// Currency added!
  public static let currencyAdded = CurrencyConverterStrings.tr("Localizable", "currency_added")
  /// %@ - %@\nadded to currency list
  public static func currencyAddedMessage(_ p1: Any, _ p2: Any) -> String {
    return CurrencyConverterStrings.tr("Localizable", "currency_added_message",String(describing: p1), String(describing: p2))
  }
  /// UAE Dirham
  public static let currencyAED = CurrencyConverterStrings.tr("Localizable", "currency_AED")
  /// Afghan Afghani
  public static let currencyAFN = CurrencyConverterStrings.tr("Localizable", "currency_AFN")
  /// Albanian Lek
  public static let currencyALL = CurrencyConverterStrings.tr("Localizable", "currency_ALL")
  /// Armenian Dram
  public static let currencyAMD = CurrencyConverterStrings.tr("Localizable", "currency_AMD")
  /// Argentine Peso
  public static let currencyARS = CurrencyConverterStrings.tr("Localizable", "currency_ARS")
  /// Australian Dollar
  public static let currencyAUD = CurrencyConverterStrings.tr("Localizable", "currency_AUD")
  /// Azerbaijani Manat
  public static let currencyAZN = CurrencyConverterStrings.tr("Localizable", "currency_AZN")
  /// Bosnia and Herzegovina Convertible Mark
  public static let currencyBAM = CurrencyConverterStrings.tr("Localizable", "currency_BAM")
  /// Bulgarian Lev
  public static let currencyBGN = CurrencyConverterStrings.tr("Localizable", "currency_BGN")
  /// Bahraini Dinar
  public static let currencyBHD = CurrencyConverterStrings.tr("Localizable", "currency_BHD")
  /// Bolivian Boliviano
  public static let currencyBOB = CurrencyConverterStrings.tr("Localizable", "currency_BOB")
  /// Brazilian Real
  public static let currencyBRL = CurrencyConverterStrings.tr("Localizable", "currency_BRL")
  /// Belarusian Ruble
  public static let currencyBYN = CurrencyConverterStrings.tr("Localizable", "currency_BYN")
  /// Canadian Dollar
  public static let currencyCAD = CurrencyConverterStrings.tr("Localizable", "currency_CAD")
  /// Swiss Franc
  public static let currencyCHF = CurrencyConverterStrings.tr("Localizable", "currency_CHF")
  /// Chilean Peso
  public static let currencyCLP = CurrencyConverterStrings.tr("Localizable", "currency_CLP")
  /// Chinese Yuan
  public static let currencyCNY = CurrencyConverterStrings.tr("Localizable", "currency_CNY")
  /// Currency Converter
  public static let currencyConverterTitle = CurrencyConverterStrings.tr("Localizable", "currency_converter_title")
  /// Colombian Peso
  public static let currencyCOP = CurrencyConverterStrings.tr("Localizable", "currency_COP")
  /// Czech Koruna
  public static let currencyCZK = CurrencyConverterStrings.tr("Localizable", "currency_CZK")
  /// Danish Krone
  public static let currencyDKK = CurrencyConverterStrings.tr("Localizable", "currency_DKK")
  /// Egyptian Pound
  public static let currencyEGP = CurrencyConverterStrings.tr("Localizable", "currency_EGP")
  /// Ethiopian Birr
  public static let currencyETB = CurrencyConverterStrings.tr("Localizable", "currency_ETB")
  /// Euro
  public static let currencyEUR = CurrencyConverterStrings.tr("Localizable", "currency_EUR")
  /// Fijian Dollar
  public static let currencyFJD = CurrencyConverterStrings.tr("Localizable", "currency_FJD")
  /// British Pound Sterling
  public static let currencyGBP = CurrencyConverterStrings.tr("Localizable", "currency_GBP")
  /// Georgian Lari
  public static let currencyGEL = CurrencyConverterStrings.tr("Localizable", "currency_GEL")
  /// Ghanaian Cedi
  public static let currencyGHS = CurrencyConverterStrings.tr("Localizable", "currency_GHS")
  /// Hong Kong Dollar
  public static let currencyHKD = CurrencyConverterStrings.tr("Localizable", "currency_HKD")
  /// Croatian Kuna
  public static let currencyHRK = CurrencyConverterStrings.tr("Localizable", "currency_HRK")
  /// Hungarian Forint
  public static let currencyHUF = CurrencyConverterStrings.tr("Localizable", "currency_HUF")
  /// Indonesian Rupiah
  public static let currencyIDR = CurrencyConverterStrings.tr("Localizable", "currency_IDR")
  /// Israeli New Shekel
  public static let currencyILS = CurrencyConverterStrings.tr("Localizable", "currency_ILS")
  /// Indian Rupee
  public static let currencyINR = CurrencyConverterStrings.tr("Localizable", "currency_INR")
  /// Icelandic Krona
  public static let currencyISK = CurrencyConverterStrings.tr("Localizable", "currency_ISK")
  /// Jordanian Dinar
  public static let currencyJOD = CurrencyConverterStrings.tr("Localizable", "currency_JOD")
  /// Japanese Yen
  public static let currencyJPY = CurrencyConverterStrings.tr("Localizable", "currency_JPY")
  /// Kenyan Shilling
  public static let currencyKES = CurrencyConverterStrings.tr("Localizable", "currency_KES")
  /// Kyrgystani Som
  public static let currencyKGS = CurrencyConverterStrings.tr("Localizable", "currency_KGS")
  /// South Korean Won
  public static let currencyKRW = CurrencyConverterStrings.tr("Localizable", "currency_KRW")
  /// Kuwaiti Dinar
  public static let currencyKWD = CurrencyConverterStrings.tr("Localizable", "currency_KWD")
  /// Kazakhstani Tenge
  public static let currencyKZT = CurrencyConverterStrings.tr("Localizable", "currency_KZT")
  /// Lebanese Pound
  public static let currencyLBP = CurrencyConverterStrings.tr("Localizable", "currency_LBP")
  /// Moroccan Dirham
  public static let currencyMAD = CurrencyConverterStrings.tr("Localizable", "currency_MAD")
  /// Moldovan Leu
  public static let currencyMDL = CurrencyConverterStrings.tr("Localizable", "currency_MDL")
  /// Macedonian Denar
  public static let currencyMKD = CurrencyConverterStrings.tr("Localizable", "currency_MKD")
  /// Mexican Peso
  public static let currencyMXN = CurrencyConverterStrings.tr("Localizable", "currency_MXN")
  /// Malaysian Ringgit
  public static let currencyMYR = CurrencyConverterStrings.tr("Localizable", "currency_MYR")
  /// Nigerian Naira
  public static let currencyNGN = CurrencyConverterStrings.tr("Localizable", "currency_NGN")
  /// Norwegian Krone
  public static let currencyNOK = CurrencyConverterStrings.tr("Localizable", "currency_NOK")
  /// New Zealand Dollar
  public static let currencyNZD = CurrencyConverterStrings.tr("Localizable", "currency_NZD")
  /// Omani Rial
  public static let currencyOMR = CurrencyConverterStrings.tr("Localizable", "currency_OMR")
  /// Peruvian Sol
  public static let currencyPEN = CurrencyConverterStrings.tr("Localizable", "currency_PEN")
  /// Papua New Guinean Kina
  public static let currencyPGK = CurrencyConverterStrings.tr("Localizable", "currency_PGK")
  /// Philippine Peso
  public static let currencyPHP = CurrencyConverterStrings.tr("Localizable", "currency_PHP")
  /// Polish Zloty
  public static let currencyPLN = CurrencyConverterStrings.tr("Localizable", "currency_PLN")
  /// Paraguayan Guarani
  public static let currencyPYG = CurrencyConverterStrings.tr("Localizable", "currency_PYG")
  /// Qatari Rial
  public static let currencyQAR = CurrencyConverterStrings.tr("Localizable", "currency_QAR")
  /// Romanian Leu
  public static let currencyRON = CurrencyConverterStrings.tr("Localizable", "currency_RON")
  /// Serbian Dinar
  public static let currencyRSD = CurrencyConverterStrings.tr("Localizable", "currency_RSD")
  /// Russian Ruble
  public static let currencyRUB = CurrencyConverterStrings.tr("Localizable", "currency_RUB")
  /// Saudi Riyal
  public static let currencySAR = CurrencyConverterStrings.tr("Localizable", "currency_SAR")
  /// Solomon Islands Dollar
  public static let currencySBD = CurrencyConverterStrings.tr("Localizable", "currency_SBD")
  /// Swedish Krona
  public static let currencySEK = CurrencyConverterStrings.tr("Localizable", "currency_SEK")
  /// Singapore Dollar
  public static let currencySGD = CurrencyConverterStrings.tr("Localizable", "currency_SGD")
  /// Thai Baht
  public static let currencyTHB = CurrencyConverterStrings.tr("Localizable", "currency_THB")
  /// Tajikistani Somoni
  public static let currencyTJS = CurrencyConverterStrings.tr("Localizable", "currency_TJS")
  /// Turkmenistani Manat
  public static let currencyTMT = CurrencyConverterStrings.tr("Localizable", "currency_TMT")
  /// Tunisian Dinar
  public static let currencyTND = CurrencyConverterStrings.tr("Localizable", "currency_TND")
  /// Tongan Pa'anga
  public static let currencyTOP = CurrencyConverterStrings.tr("Localizable", "currency_TOP")
  /// Turkish Lira
  public static let currencyTRY = CurrencyConverterStrings.tr("Localizable", "currency_TRY")
  /// Tanzanian Shilling
  public static let currencyTZS = CurrencyConverterStrings.tr("Localizable", "currency_TZS")
  /// Ukrainian Hryvnia
  public static let currencyUAH = CurrencyConverterStrings.tr("Localizable", "currency_UAH")
  /// Ugandan Shilling
  public static let currencyUGX = CurrencyConverterStrings.tr("Localizable", "currency_UGX")
  /// US Dollar
  public static let currencyUSD = CurrencyConverterStrings.tr("Localizable", "currency_USD")
  /// Uruguayan Peso
  public static let currencyUYU = CurrencyConverterStrings.tr("Localizable", "currency_UYU")
  /// Uzbekistani Som
  public static let currencyUZS = CurrencyConverterStrings.tr("Localizable", "currency_UZS")
  /// Vietnamese Dong
  public static let currencyVND = CurrencyConverterStrings.tr("Localizable", "currency_VND")
  /// Vanuatu Vatu
  public static let currencyVUV = CurrencyConverterStrings.tr("Localizable", "currency_VUV")
  /// Samoan Tala
  public static let currencyWST = CurrencyConverterStrings.tr("Localizable", "currency_WST")
  /// Central African CFA Franc
  public static let currencyXAF = CurrencyConverterStrings.tr("Localizable", "currency_XAF")
  /// East Caribbean Dollar
  public static let currencyXCD = CurrencyConverterStrings.tr("Localizable", "currency_XCD")
  /// West African CFA Franc
  public static let currencyXOF = CurrencyConverterStrings.tr("Localizable", "currency_XOF")
  /// CFP Franc
  public static let currencyXPF = CurrencyConverterStrings.tr("Localizable", "currency_XPF")
  /// South African Rand
  public static let currencyZAR = CurrencyConverterStrings.tr("Localizable", "currency_ZAR")
  /// Dark Mode
  public static let darkMode = CurrencyConverterStrings.tr("Localizable", "dark_mode")
  /// Data outdated
  public static let dataOutdated = CurrencyConverterStrings.tr("Localizable", "data_outdated")
  /// Decimal Precision
  public static let decimalPrecision = CurrencyConverterStrings.tr("Localizable", "decimal_precision")
  /// Delete
  public static let delete = CurrencyConverterStrings.tr("Localizable", "delete")
  /// Done
  public static let done = CurrencyConverterStrings.tr("Localizable", "done")
  /// Error: %@
  public static func errorColon(_ p1: Any) -> String {
    return CurrencyConverterStrings.tr("Localizable", "error_colon",String(describing: p1))
  }
  /// Error: %@
  public static func errorPrefix(_ p1: Any) -> String {
    return CurrencyConverterStrings.tr("Localizable", "error_prefix",String(describing: p1))
  }
  /// Rate:
  public static let exchangeRate = CurrencyConverterStrings.tr("Localizable", "exchange_rate")
  /// From
  public static let fromAmount = CurrencyConverterStrings.tr("Localizable", "from_amount")
  /// FROM
  public static let fromCurrency = CurrencyConverterStrings.tr("Localizable", "from_currency")
  /// Language
  public static let language = CurrencyConverterStrings.tr("Localizable", "language")
  /// Loading currencies...
  public static let loadingCurrencies = CurrencyConverterStrings.tr("Localizable", "loading_currencies")
  /// Loading error
  public static let loadingError = CurrencyConverterStrings.tr("Localizable", "loading_error")
  /// Loading rates...
  public static let loadingRates = CurrencyConverterStrings.tr("Localizable", "loading_rates")
  /// No connection
  public static let noConnection = CurrencyConverterStrings.tr("Localizable", "no_connection")
  /// OK
  public static let ok = CurrencyConverterStrings.tr("Localizable", "ok")
  /// Preferences
  public static let preferencesSection = CurrencyConverterStrings.tr("Localizable", "preferences_section")
  /// Rate App
  public static let rateApp = CurrencyConverterStrings.tr("Localizable", "rate_app")
  /// Retry
  public static let retry = CurrencyConverterStrings.tr("Localizable", "retry")
  /// Search currencies
  public static let searchCurrencies = CurrencyConverterStrings.tr("Localizable", "search_currencies")
  /// Select Currency
  public static let selectCurrency = CurrencyConverterStrings.tr("Localizable", "select_currency")
  /// Send Feedback
  public static let sendFeedback = CurrencyConverterStrings.tr("Localizable", "send_feedback")
  /// Settings
  public static let settingsTitle = CurrencyConverterStrings.tr("Localizable", "settings_title")
  /// Support
  public static let supportSection = CurrencyConverterStrings.tr("Localizable", "support_section")
  /// To
  public static let toAmount = CurrencyConverterStrings.tr("Localizable", "to_amount")
  /// TO
  public static let toCurrency = CurrencyConverterStrings.tr("Localizable", "to_currency")
  /// Unknown currency
  public static let unknownCurrency = CurrencyConverterStrings.tr("Localizable", "unknown_currency")
  /// Updated: %@
  public static func updatedColon(_ p1: Any) -> String {
    return CurrencyConverterStrings.tr("Localizable", "updated_colon",String(describing: p1))
  }
  /// Version
  public static let version = CurrencyConverterStrings.tr("Localizable", "version")
  /// Welcome!
  public static let welcomeSubtitle = CurrencyConverterStrings.tr("Localizable", "welcome_subtitle")
  /// Currency Converter
  public static let welcomeTitle = CurrencyConverterStrings.tr("Localizable", "welcome_title")

  public enum Language: Sendable {
  /// 🇺🇸 English
    public static let english = CurrencyConverterStrings.tr("Localizable", "language.english")
    /// 🇷🇺 Русский
    public static let russian = CurrencyConverterStrings.tr("Localizable", "language.russian")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension CurrencyConverterStrings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = Bundle.module.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
// swiftformat:enable all
// swiftlint:enable all
