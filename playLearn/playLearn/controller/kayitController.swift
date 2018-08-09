//
//  kayitController.swift
//  playLearn
//
//  Created by Sierra on 4.05.2018.
//  Copyright © 2018 ktu. All rights reserved.
//

import UIKit
import Firebase

class kayitController: UIViewController {

    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var pass: UITextField!

    @IBAction func kayitOl(_ sender: Any) {
        Auth.auth().createUser(withEmail: email.text!, password: pass.text!) { user, error in
            if error == nil && user != nil {
                let alert = UIAlertController(title: "Kayıt", message: "Başarıyla Kayıt Oldunuz.", preferredStyle: UIAlertControllerStyle.alert)
                
                self.present(alert, animated: true) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                        guard self?.presentedViewController == alert else { return }
                        
                        self?.dismiss(animated: true) {
                            self?.performSegue(withIdentifier: "showGiris", sender: self)
                        }
                    }
                }
                
            } else {
                let alert = UIAlertController(title: "Giriş", message: "Lütfen Bilgileri Doğru Giriniz.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Geri Dön", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion:nil)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
