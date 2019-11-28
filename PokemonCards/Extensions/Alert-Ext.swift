//
//  Alert-Ext.swift
//  PokemonCards
//
//  Created by Artjoms Vorona on 28/11/2019.
//  Copyright © 2019 Artjoms Vorona. All rights reserved.
//

import UIKit

extension UIViewController {
    func basicAlert(title: String?, message: String?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func goToSettingsAlert(title: String?, message: String?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            alert.addAction(UIAlertAction(title: "Open", style: .default, handler: { (_) in
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
                
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
                }
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
