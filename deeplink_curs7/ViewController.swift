//
//  ViewController.swift
//  deeplink_curs7
//
//  Created by Orlando Neacsu on 29.03.2023.
//

import UIKit
import UserNotifications

class ViewController2: UIViewController {

    private let label = UILabel()
    private var remainingSeconds: Int = 0
    
    override func viewDidLoad() { // se apeleaza o data!!! la incarcarea view ului in memorie
        super.viewDidLoad()
        configureLabel()
        scheduleLocalNotification()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
    }
    
    private func configureLabel() {
        label.text = nil
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func setRemaningSeconds(_ seconds: Int) {
        remainingSeconds = seconds
        label.text = String(seconds)

    }
    
    private func scheduleLocalNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Local notification title"
        content.subtitle = "It looks hungry"
        content.body = "Body for our local notification"
        content.sound = UNNotificationSound.defaultRingtone
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        setRemaningSeconds(5)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] timer in
            guard let self else {return}
            self.setRemaningSeconds(self.remainingSeconds - 1)
            if self.remainingSeconds == 0 {
                timer.invalidate()
            }
        })
    }
}

/*
 MVVM
 
 Model - MANAGEMENT DE DATE (include modelele de date si nu numai!!!)
 View - UI
 ViewModel - intermediar intre model si view
 
 Model <-> ViewModel <BINDING> View
 BINDING: DELEGATE
 */


