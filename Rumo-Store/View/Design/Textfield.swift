//
//  Textfield.swift
//  Rumo-Store
//
//  Created by  Snow on 16/04/2019.
//  Copyright © 2019 ProIT. All rights reserved.
//

import UIKit


@IBDesignable class Textfield: UITextField {
    
    
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
    
    
    
    @IBInspectable var sizeWidth: CGFloat = 16  {
        
        didSet {
            atualizarView()
            
        }
        
    }
    
    
    
    @IBInspectable var sizeHeigth: CGFloat = 20  {
        
        didSet {
            atualizarView()
            
        }
        
    }
    
    
    @IBInspectable var leftPadding: CGFloat = 0 {
        
        didSet {
            atualizarView()
            
        }
        
    }
    
    
    
    
    @IBInspectable var rightPadding: CGFloat = 0 {
        
        didSet {
            atualizarView()
            
        }
        
    }
    
    
    
    
    
    @IBInspectable var imagemEsquerda: UIImage?  {
        
        didSet {
            atualizarView()
        }
        
    }
    
    
    
    func atualizarView() {
        
        if let image = imagemEsquerda {
            leftViewMode = .always
            
            let imageView = UIImageView(frame: CGRect(x: leftPadding, y: 0, width: sizeWidth, height: sizeHeigth))
            imageView.image = image
            
            
            
            
            let  width = sizeWidth + leftPadding + rightPadding
            let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: sizeHeigth))
            view.addSubview(imageView)
            
            
            
            leftView = view
        }else {
            leftViewMode = .never
        }
        
        
    }
    
    
    
    
}

