// Copyright SIX DAY LLC. All rights reserved.

import Foundation

public struct Constants {
    public static let coinbaseWidgetCode = "88d6141a-ff60-536c-841c-8f830adaacfd"
    public static let shapeShiftPublicKey = "c4097b033e02163da6114fbbc1bf15155e759ddfd8352c88c55e7fef162e901a800e7eaecf836062a0c075b2b881054e0b9aa2324be7bc3694578493faf59af4"
    public static let changellyRefferalID = "968d4f0f0bf9"
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
    public static let supportEmail = "support@ellaism.org"
    public static let donationAddress = "0xEDae451f57B5bfF81d1D9eE64F591Ad6a865a652"

    public static let dappsBrowserURL = "https://ellaism.org/dapps"
    public static let dappsOpenSea = "https://opensea.io"

    public static let images = "https://ellaismimages.nonlocal.ca/images"

    public static let trustAPI = URL(string: "https://ellaismwallet.nonlocal.ca")!
}

public struct UnitConfiguration {
    public static let gasPriceUnit: EthereumUnit = .gwei
    public static let gasFeeUnit: EthereumUnit = .ether
}

public struct URLSchemes {
    public static let trust = "ellaism://"
    public static let browser = trust + "browser"
}
