//
//  SideMenu.swift
//  Rumo-Store
//
//  Created by  Snow on 16/04/2019.
//  Copyright © 2019 ProIT. All rights reserved.
//

import UIKit

class SideMenu: UIViewController {

    @IBOutlet weak var nome: UILabel!
    @IBOutlet weak var email: UILabel!
    
    let nomeUsuario = UserDefaults.standard.string(forKey: "nome")

      let emailUsuario = UserDefaults.standard.string(forKey: "email")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        nome.text = nomeUsuario
        email.text = emailUsuario

    }
    


}
