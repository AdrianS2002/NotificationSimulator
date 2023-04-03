//
//  FootbalTeamDetails.swift
//  deeplink_curs7
//
//  Created by Orlando Neacsu on 29.03.2023.
//

import Foundation
import UIKit

class FootballTeamDetails: UIViewController {
    
    @IBOutlet private weak var label: UILabel!
    
    var footballTeamId: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = String(footballTeamId)
    }
    
}
