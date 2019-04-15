//
//  ViewController.swift
//  Rumo-Store
//
//  Created by  Snow on 15/04/2019.
//  Copyright © 2019 ProIT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  
    @IBOutlet weak var icarousel: iCarousel!
    
    
    let array = [UIImage(named: "1"),UIImage(named: "2"),UIImage(named: "3"),UIImage(named: "4"),UIImage(named: "5"),UIImage(named: "6")]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        icarousel.type = .cylinder
        icarousel.contentMode = .scaleAspectFill
        icarousel.currentItemIndex = array.count / 2
        

        
        
    }


}

extension ViewController: iCarouselDelegate, iCarouselDataSource {
    
    
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
       let vc = storyboard?.instantiateViewController(withIdentifier: "imagens") as! imagens
        vc.name = array[index]
        self.navigationController?.pushViewController(vc, animated: true)
            
    }
    
    
}
