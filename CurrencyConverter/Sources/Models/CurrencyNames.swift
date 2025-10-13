//
//  CurrencyNames.swift
//  CurrencyConverter
//
//  Created by afon.com on 01.10.2025.
//

import Foundation

// MARK: - Словарь с русскими названиями валют

struct CurrencyNames {
    
    static let russianNames: [String: String] = [
        
        // Основные валюты
        "USD": "Доллар США",
        "EUR": "Евро",
        "RUB": "Российский рубль",
        "GBP": "Фунт стерлингов",
        "JPY": "Японская йена",
        "CNY": "Китайский юань",
        "CHF": "Швейцарский франк",
        "CAD": "Канадский доллар",
        "AUD": "Австралийский доллар",
        
        // Популярные валюты
        "KRW": "Южнокорейская вона",
        "SGD": "Сингапурский доллар",
        "HKD": "Гонконгский доллар",
        "NZD": "Новозеландский доллар",
        "SEK": "Шведская крона",
        "NOK": "Норвежская крона",
        "DKK": "Датская крона",
        "PLN": "Польский злотый",
        "CZK": "Чешская крона",
        "HUF": "Венгерский форинт",
        
        // Европейские валюты
        "BGN": "Болгарский лев",
        "HRK": "Хорватская куна",
        "RON": "Румынский лей",
        "ISK": "Исландская крона",
        "TRY": "Турецкая лира",
        
        // Азиатские валюты
        "INR": "Индийская рупия",
        "THB": "Тайский бат",
        "MYR": "Малайзийский ринггит",
        "IDR": "Индонезийская рупия",
        "PHP": "Филиппинское песо",
        "VND": "Вьетнамский донг",
        
        // Ближневосточные валюты
        "AED": "Дирхам ОАЭ",
        "SAR": "Саудовский риял",
        "QAR": "Катарский риал",
        "KWD": "Кувейтский динар",
        "BHD": "Бахрейнский динар",
        "OMR": "Оманский риал",
        "JOD": "Иорданский динар",
        "LBP": "Ливанский фунт",
        "ILS": "Израильский шекель",
        
        // Африканские валюты
        "ZAR": "Южноафриканский рэнд",
        "EGP": "Египетский фунт",
        "NGN": "Нигерийская найра",
        "GHS": "Ганский седи",
        "KES": "Кенийский шиллинг",
        "TZS": "Танзанийский шиллинг",
        "UGX": "Угандийский шиллинг",
        "ETB": "Эфиопский быр",
        "MAD": "Марокканский дирхам",
        "TND": "Тунисский динар",
        
        // Американские валюты
        "MXN": "Мексиканское песо",
        "BRL": "Бразильский реал",
        "ARS": "Аргентинское песо",
        "CLP": "Чилийское песо",
        "COP": "Колумбийское песо",
        "PEN": "Перуанский соль",
        "UYU": "Уругвайское песо",
        "BOB": "Боливийский боливиано",
        "PYG": "Парагвайский гуарани",
        
        // Другие валюты
        "XAF": "Франк КФА (Центральная Африка)",
        "XOF": "Франк КФА (Западная Африка)",
        "XCD": "Восточно-карибский доллар",
        "XPF": "Франк Французской Полинезии",
        "FJD": "Доллар Фиджи",
        "TOP": "Тонганская паанга",
        "WST": "Самоанская тала",
        "VUV": "Вануатский вату",
        "SBD": "Доллар Соломоновых Островов",
        "PGK": "Кина Папуа-Новой Гвинеи",
        
        // Дополнительные валюты
        "ALL": "Албанский лек",
        "AFN": "Афганский афгани",
        "AMD": "Армянский драм",
        "AZN": "Азербайджанский манат",
        "BYN": "Белорусский рубль",
        "BAM": "Конвертируемая марка Боснии и Герцеговины",
        "GEL": "Грузинский лари",
        "KZT": "Казахстанский тенге",
        "KGS": "Киргизский сом",
        "MDL": "Молдавский лей",
        "MKD": "Македонский денар",
        "RSD": "Сербский динар",
        "TJS": "Таджикистанский сомони",
        "TMT": "Туркменский манат",
        "UAH": "Украинская гривна",
        "UZS": "Узбекский сум",
        
    ]
    
    static let englishNames: [String: String] = [
        
        // Main currencies
        "USD": "US Dollar",
        "EUR": "Euro",
        "RUB": "Russian Ruble",
        "GBP": "British Pound Sterling",
        "JPY": "Japanese Yen",
        "CNY": "Chinese Yuan",
        "CHF": "Swiss Franc",
        "CAD": "Canadian Dollar",
        "AUD": "Australian Dollar",
        
        // Popular currencies
        "KRW": "South Korean Won",
        "SGD": "Singapore Dollar",
        "HKD": "Hong Kong Dollar",
        "NZD": "New Zealand Dollar",
        "SEK": "Swedish Krona",
        "NOK": "Norwegian Krone",
        "DKK": "Danish Krone",
        "PLN": "Polish Zloty",
        "CZK": "Czech Koruna",
        "HUF": "Hungarian Forint",
        
        // European currencies
        "BGN": "Bulgarian Lev",
        "HRK": "Croatian Kuna",
        "RON": "Romanian Leu",
        "ISK": "Icelandic Krona",
        "TRY": "Turkish Lira",
        
        // Asian currencies
        "INR": "Indian Rupee",
        "THB": "Thai Baht",
        "MYR": "Malaysian Ringgit",
        "IDR": "Indonesian Rupiah",
        "PHP": "Philippine Peso",
        "VND": "Vietnamese Dong",
        
        // Middle Eastern currencies
        "AED": "UAE Dirham",
        "SAR": "Saudi Riyal",
        "QAR": "Qatari Rial",
        "KWD": "Kuwaiti Dinar",
        "BHD": "Bahraini Dinar",
        "OMR": "Omani Rial",
        "JOD": "Jordanian Dinar",
        "LBP": "Lebanese Pound",
        "ILS": "Israeli New Shekel",
        
        // African currencies
        "ZAR": "South African Rand",
        "EGP": "Egyptian Pound",
        "NGN": "Nigerian Naira",
        "GHS": "Ghanaian Cedi",
        "KES": "Kenyan Shilling",
        "TZS": "Tanzanian Shilling",
        "UGX": "Ugandan Shilling",
        "ETB": "Ethiopian Birr",
        "MAD": "Moroccan Dirham",
        "TND": "Tunisian Dinar",
        
        // American currencies
        "MXN": "Mexican Peso",
        "BRL": "Brazilian Real",
        "ARS": "Argentine Peso",
        "CLP": "Chilean Peso",
        "COP": "Colombian Peso",
        "PEN": "Peruvian Sol",
        "UYU": "Uruguayan Peso",
        "BOB": "Bolivian Boliviano",
        "PYG": "Paraguayan Guarani",
        
        // Other currencies
        "XAF": "Central African CFA Franc",
        "XOF": "West African CFA Franc",
        "XCD": "East Caribbean Dollar",
        "XPF": "CFP Franc",
        "FJD": "Fijian Dollar",
        "TOP": "Tongan Pa'anga",
        "WST": "Samoan Tala",
        "VUV": "Vanuatu Vatu",
        "SBD": "Solomon Islands Dollar",
        "PGK": "Papua New Guinean Kina",
        
        // Additional currencies
        "ALL": "Albanian Lek",
        "AFN": "Afghan Afghani",
        "AMD": "Armenian Dram",
        "AZN": "Azerbaijani Manat",
        "BYN": "Belarusian Ruble",
        "BAM": "Bosnia and Herzegovina Convertible Mark",
        "GEL": "Georgian Lari",
        "KZT": "Kazakhstani Tenge",
        "KGS": "Kyrgystani Som",
        "MDL": "Moldovan Leu",
        "MKD": "Macedonian Denar",
        "RSD": "Serbian Dinar",
        "TJS": "Tajikistani Somoni",
        "TMT": "Turkmenistani Manat",
        "UAH": "Ukrainian Hryvnia",
        "UZS": "Uzbekistani Som",
    ]
    
    /// Получить русское название валюты по коду
    static func getRussianName(for currencyCode: String) -> String? {
        return russianNames[currencyCode]
    }
    
    /// Получить английское название валюты по коду
    static func getEnglishName(for currencyCode: String) -> String? {
        return englishNames[currencyCode]
    }
    
    /// Получить локализованное название валюты
    static func getLocalizedName(for currencyCode: String, languageCode: String) -> String? {
        switch languageCode {
        case "ru":
            return getRussianName(for: currencyCode)
        case "en":
            return getEnglishName(for: currencyCode)
        default:
            return getEnglishName(for: currencyCode) // По умолчанию английский
        }
    }
}
