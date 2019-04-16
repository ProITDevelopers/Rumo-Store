//
//  imagens.swift
//  Rumo-Store
//
//  Created by  Snow on 16/04/2019.
//  Copyright © 2019 ProIT. All rights reserved.
//

import UIKit


@IBDesignable class imagem: UIImageView {
    
    
    @IBInspectable var cornerRadius: CGFloat = 0  {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
        
    }
    
    
    
    
    @IBInspectable var borderWidth: CGFloat = 0  {
        didSet {
            layer.borderWidth = borderWidth
            
        }
        
    }
    
    
    @IBInspectable var borderColor: UIColor?  {
        
        didSet {
            layer.borderColor = borderColor?.cgColor
            
        }
        
    }
    
    
    
}
