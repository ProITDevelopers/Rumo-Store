//
//  ViewController.swift
//  Rumo-Store
//
//  Created by  Snow on 15/04/2019.
//  Copyright © 2019 ProIT. All rights reserved.
//

import UIKit



class Mercado: UIViewController {

  
    @IBOutlet weak var icarousel: iCarousel!
    @IBOutlet weak var menuBotao: UIBarButtonItem!
    
    
    let array = [UIImage(named: "1"),UIImage(named: "2.1"),UIImage(named: "3"),UIImage(named: "1"),UIImage(named: "2.1"),UIImage(named: "3"),UIImage(named: "2.1"),UIImage(named: "3"),UIImage(named: "2.1"),UIImage(named: "3")]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        menuBotao.target = self.revealViewController()
        menuBotao.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
        self.view.addGestureRecognizer((self.revealViewController()?.tapGestureRecognizer())!)
        self.revealViewController()?.rearViewRevealWidth = 305
        
        
        icarousel.type = .coverFlow2
        icarousel.contentMode = .scaleAspectFill
        icarousel.currentItemIndex = array.count / 2
     
    }
    
    
    @IBAction func sairButton(_ sender: Any) {
        let loginPage =  self.storyboard?.instantiateViewController(withIdentifier: "login") as! Login
        let appDelegate = UIApplication.shared.delegate
        appDelegate?.window??.rootViewController = loginPage
        
        
    }
    


}

extension Mercado: iCarouselDelegate, iCarouselDataSource{
    
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        return array.count
    }
    
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
   
        var image: UIImageView!
        
        if view == nil {
            
           
            image = UIImageView(frame: CGRect(x: 0, y: 0, width: 120, height: 140))
            
        }else {
            image = view as? UIImageView
        }
        
        image.image = array[index]
        return image
    }
    
    
    
    

    
    
    
    
    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
       let vc = storyboard?.instantiateViewController(withIdentifier: "imagens") as! Carrinho
        vc.name = array[index]
        self.navigationController?.pushViewController(vc, animated: true)
            
    }
    
    
}
