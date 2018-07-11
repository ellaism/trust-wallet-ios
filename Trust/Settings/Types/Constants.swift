// Copyright SIX DAY LLC. All rights reserved.

import Foundation

public struct Constants {
    public static let coinbaseWidgetCode = ""
    public static let shapeShiftPublicKey = ""
    public static let changellyRefferalID = ""
    //
    public static let keychainKeyPrefix = "ellawallet"

    // social
    public static let website = "https://ellaism.org"
    public static let twitterUsername = "ellaismproject"
    public static let telegramUsername = "ellaismcoin"
    public static let facebookUsername = "ellaismproject"
    public static let discordServer = "discord://discord.ellaism.org"
    public static let bitcoinTalkUrl = "https://bitcointalk.org/index.php?topic=2168042"
    public static let redditUrl = "https://www.reddit.com/r/ellaism"
    public static let githubUrl = "https://github.com/ellaism"

    // support
    public static let supportEmail = "support@outdoordevs.com"
    public static let donationAddress = "0xe9C2d958E6234c862b4AfBD75b2fd241E9556303"

    public static let dappsBrowserURL = "https://ellaism.github.io/trust-wallet-ios/dapps/index"
    public static let dappsOpenSea = ""

    public static let images = "https://ellaism.github.io/trust-wallet-ios/images"

    public static let trustAPI = URL(string: "https://trustray.outdoordevs.com")!
}

public struct UnitConfiguration {
    public static let gasPriceUnit: EthereumUnit = .gwei
    public static let gasFeeUnit: EthereumUnit = .ether
}

public struct URLSchemes {
    public static let trust = "ellaism://"
    public static let browser = trust + "browser"
}
