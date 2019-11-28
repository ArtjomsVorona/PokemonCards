//
//  ShareManager.swift
//  PokemonCards
//
//  Created by Artjoms Vorona on 28/11/2019.
//  Copyright © 2019 Artjoms Vorona. All rights reserved.
//

import UIKit
import Foundation

class ShareManager {
    static func share(image: UIImage,text: String, vc: UIViewController) {
        let objects = [text, image] as [Any]
        
        let activityVC = UIActivityViewController(activityItems: objects as [Any], applicationActivities: nil)
        
        activityVC.completionWithItemsHandler = {
            (activity, success, items, error) in
            if error != nil {
                goToSettings(vc: vc)
            }
            
            if success {
                successAlert(vc: vc)
            }
            
        }//end complition handler
        vc.present(activityVC, animated: true, completion: nil)
        
    }//end func share
    
    static func goToSettings(vc: UIViewController) {
        let alert = UIAlertController(title: "Apparently you have not allowed to use photo library.", message: "Pleease check your settings", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Open", style: .default, handler: { (_) in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
            }
        }))
        
        vc.present(alert, animated: true, completion: nil)
    }//end func gotosettings
    
    static func successAlert(vc: UIViewController) {
        let alert = UIAlertController(title: "Card was sent or saved!", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        vc.present(alert, animated: true, completion: nil)
    }

}
