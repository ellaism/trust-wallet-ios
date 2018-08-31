// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import UIKit
import Rswift

enum URLServiceProvider {
    case twitter
    case telegram
    case facebook
    case discord
    case bitcointalk
    case reddit
    case github
    case sourceCode
    case privacyPolicy
    case termsOfService
    var title: String {
        switch self {
        case .twitter: return "Twitter"
        case .telegram: return "Telegram"
        case .facebook: return "Facebook"
        case .discord: return "Discord"
        case .reddit: return "Reddit"
        case .bitcointalk: return "Bitcoin Talk"
        case .github: return "GitHub"
        case .sourceCode: return R.string.localizable.settingsSourceCodeButtonTitle()
        case .privacyPolicy: return R.string.localizable.settingsPrivacyTitle()
        case .termsOfService: return R.string.localizable.settingsTermsOfServiceButtonTitle()
       }
    }

    var localURL: URL? {
        switch self {
        case .twitter:
            return URL(string: "twitter://user?screen_name=\(Constants.twitterUsername)")!
        case .telegram:
            return URL(string: "tg://resolve?domain=\(preferredTelegramUsername())")
        case .facebook:
            return URL(string: "fb://profile?id=\(Constants.facebookUsername)")
        case .discord:
            return URL(string: Constants.discordServer)
        case .bitcointalk:
            return URL(string: Constants.bitcoinTalkUrl)
        case .reddit:
            return URL(string: Constants.redditUrl)
        case .github:
            return URL(string: Constants.githubUrl)
        case .sourceCode: return nil
        case .privacyPolicy: return nil
        case .termsOfService: return nil
        }
    }

    var remoteURL: URL {
        return URL(string: self.remoteURLString)!
    }

    private var remoteURLString: String {
        switch self {
        case .twitter:
            return "https://twitter.com/\(Constants.twitterUsername)"
        case .telegram:
            return "https://telegram.me/\(preferredTelegramUsername())"
        case .facebook:
            return "https://www.facebook.com/\(Constants.facebookUsername)"
        case .discord:
            return Constants.discordServer
        case .reddit:
            return Constants.redditUrl
        case .github:
            return Constants.githubUrl
        case .bitcointalk:
            return Constants.bitcoinTalkUrl
        case .sourceCode:
            return "https://github.com/TrustWallet/trust-wallet-ios"
        case .privacyPolicy:
            return "https://trustwalletapp.com/privacy-policy.html"
        case .termsOfService:
            return "https://trustwalletapp.com/terms.html"
        }
    }

    var image: UIImage? {
        switch self {
        case .twitter: return R.image.settings_colorful_twitter()
        case .telegram: return R.image.settings_colorful_telegram()
        case .facebook: return R.image.settings_colorful_facebook()
        case .discord: return R.image.settings_colorful_discord()
        case .bitcointalk: return R.image.settings_colorful_bitcointalk()
        case .reddit: return R.image.settings_colorful_reddit()
        case .github: return R.image.settings_colorful_github()
        case .sourceCode: return nil
        case .privacyPolicy: return nil
        case .termsOfService: return nil
        }
    }

    private func preferredTelegramUsername() -> String {
        let languageCode = NSLocale.preferredLanguageCode ?? ""
        return Constants.localizedTelegramUsernames[languageCode] ?? Constants.telegramUsername
    }
}
