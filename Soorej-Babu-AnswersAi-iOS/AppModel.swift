//
//  AppModel.swift
//  Soorej-Babu-AnswersAi-iOS
//
//  Created by Soorej Babu on 07/12/2024.
//

import Foundation

struct AppCardData: Codable, Identifiable
{
    var id = UUID()
    let backgroundImageName: String
    let title: String
    let titleTextColour: String
    let subtitle: String
    let appIcon: String
    let appName: String
    let appDescription: String
    let inAppPurchasesText: String
    let appBarTextColour: String
}
