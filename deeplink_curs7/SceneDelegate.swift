//
//  SceneDelegate.swift
//  deeplink_curs7
//
//  Created by Orlando Neacsu on 29.03.2023.
//

import UIKit
import UserNotifications

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
        UNUserNotificationCenter.current().delegate = self
        
        if let urlScheme = connectionOptions.urlContexts.first?.url,
           let deeplink = Deeplink.convertFromURLScheme(url: urlScheme)  { // HANDLE URL SCHEME AT APP OPENING
            handleDeeplink(deeplink: deeplink)
        }
        
        if let universalLink = connectionOptions.userActivities.first?.webpageURL,
           let deeplink = Deeplink.convertFromUniversalLink(url: universalLink) { // HANDLE UNIVERSAL LINK APP OPENING
            handleDeeplink(deeplink: deeplink)
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
    
    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        if let universalLink = userActivity.webpageURL,  // HANDLE UNIVERSAL LINK WHEN APP IS IN BACKGROUND
           let deepink = Deeplink.convertFromUniversalLink(url: universalLink) {
            handleDeeplink(deeplink: deepink)
        }
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url,  // HANDLE URL SCHEME WHEN APP IS IN BACKGROUND
           let deeplink = Deeplink.convertFromURLScheme(url: url) {
            handleDeeplink(deeplink: deeplink)
        }
    }
    
    private func handleDeeplink(deeplink: Deeplink) {
        switch deeplink {
        case .footballTeamDetails(let id):
            guard let navigationController = window?.rootViewController as? UINavigationController else {return}
            let sb = UIStoryboard(name: "Main", bundle: .main)
            let footbalTeamDetailsController = sb.instantiateViewController(withIdentifier: "FootballTeamDetails") as! FootballTeamDetails
            footbalTeamDetailsController.footballTeamId = id
            navigationController.pushViewController(footbalTeamDetailsController, animated: true)
        }
    }
}

extension SceneDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge, .sound, .alert])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        if let apsDictionary = userInfo["aps"] as? [AnyHashable: Any],
           let deeplinkString = apsDictionary["deeplink"] as? String,
           let deeplinkURL = URL(string: deeplinkString),
           let deeplink = Deeplink.convertFromURLScheme(url: deeplinkURL) {
            handleDeeplink(deeplink: deeplink)
        }
    }
}
// betfair://football-team-details?id=5

enum Deeplink {
    case footballTeamDetails(Int)
    
    static func convertFromURLScheme(url: URL) -> Deeplink? {
        guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false),
              urlComponents.scheme == "betfair" else {
            return nil
        }
        
        switch urlComponents.host ?? "" {
        case "football-team-details":
            if let idQueryItem = urlComponents.queryItems?.first(where: { $0.name == "id" }),
               let value = idQueryItem.value,
               let id = Int(value) {
                return .footballTeamDetails(id)
            }
        default:
            return nil
        }
        return nil
    }
    
    static func convertFromUniversalLink(url: URL) -> Deeplink? {
        guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return nil
        }
        switch urlComponents.path {
        case "football-team-details":
            if let idQueryItem = urlComponents.queryItems?.first(where: { $0.name == "id" }),
               let value = idQueryItem.value,
               let id = Int(value) {
                return .footballTeamDetails(id)
            }
        default:
            return nil
        }
        return nil
    }
    
}

