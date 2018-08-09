//
//  girisController.swift
//  playLearn
//
//  Created by Sierra on 3.05.2018.
//  Copyright © 2018 ktu. All rights reserved.
//

import UIKit
import Firebase

class girisController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBAction func girisYap(_ sender: UIButton) {
    
        Auth.auth().signIn(withEmail: email.text!, password: pass.text!) { (user, error) in
            if error == nil && user != nil {
                let alert = UIAlertController(title: "Giriş Başarılı", message: "Hoşgeldiniz...", preferredStyle: UIAlertControllerStyle.alert)
                
                self.present(alert, animated: true) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                        guard self?.presentedViewController == alert else { return }
                        
                        self?.dismiss(animated: true) {
                            self?.performSegue(withIdentifier: "nextPage", sender: self)
                        }
                    }
                }
                
            } else {
                let alert = UIAlertController(title: "Giriş", message: "Girilen bilgiler geçersiz...", preferredStyle: UIAlertControllerStyle.alert)
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
