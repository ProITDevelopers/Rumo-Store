//
//  imagens.swift
//  Rumo-Store
//
//  Created by  Snow on 15/04/2019.
//  Copyright © 2019 ProIT. All rights reserved.
//

import UIKit

class Carrinho: UIViewController {

    
    @IBOutlet weak var imagns: UIImageView!
    
    var name: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagns.image = name
    }
    


}
