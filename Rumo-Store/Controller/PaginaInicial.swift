//
//  PaginaInicial.swift
//  Rumo-Store
//
//  Created by  Snow on 16/04/2019.
//  Copyright © 2019 ProIT. All rights reserved.
//

import UIKit

class PaginaInicial: UIViewController {

    @IBOutlet weak var menuBotao: UIBarButtonItem!
    @IBOutlet weak var colletionview: UICollectionView!

    
    //MARK: DECLARACAO VARIAVEIS
    var noticias: NSArray = []
    var fotos: [String] = []
    var url: URL!
     var alcance : Reachability?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuBotao.target = self.revealViewController()
        menuBotao.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
        self.view.addGestureRecognizer((self.revealViewController()?.tapGestureRecognizer())!)
        self.revealViewController()?.rearViewRevealWidth = 305
        
        self.alcance = Reachability.init()
        if ((self.alcance!.connection) != .none) {
            carregarDados()
        }else {
            print("Internet Not Avaible")
            mostrarMensagem(mensagem: "Sem Conexão a Internet!")
        }
        
    }
    
    
    
    func mostrarMensagem(mensagem: String) {
        let mensagem  = UIAlertController(title: "AVISO", message: mensagem, preferredStyle: UIAlertController.Style.alert)
        
        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (actions) in
            mensagem.dismiss(animated: true, completion: nil)
        }
        mensagem.addAction(action)
        self.present(mensagem,animated: true, completion: nil)
        
    }
    
    
    func carregarDados() {
        url = URL(string: "https://mercado.co.ao/rss/newsletter.xml")!
        carregarRss(url);
    }
    
    
    func carregarRss(_ data: URL) {
        
        // XmlParserManager declaracap
        let pegarDados : XmlParserManager = XmlParserManager().initWithURL(data) as! XmlParserManager
        
        // poes os dados no array
        let teste = pegarDados.fdescription
        let array = teste.components(separatedBy: "<p>")
        let imageArray = array[0]
        let arrayimage = imageArray.components(separatedBy: "<img src=\"")
        let substring = arrayimage[1].dropLast(2)
        let imagem = String(substring)
        fotos = [imagem]
        noticias = pegarDados.feeds
        
        
        colletionview.reloadData()
    }
    
    
    @IBAction func sairButton(_ sender: Any) {
        let loginPage =  self.storyboard?.instantiateViewController(withIdentifier: "login") as! Login
        let appDelegate = UIApplication.shared.delegate
        appDelegate?.window??.rootViewController = loginPage
        
    }
    
    
    
    
    
}






//MARK: Extensions
extension PaginaInicial: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return noticias.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "noticias", for: indexPath) as! PaginaInicialCell
        
        //
        //        // carrega as imagens
        let url = NSURL(string:fotos[indexPath.row])
        let data = NSData(contentsOf:url! as URL)
        let image = UIImage(data:data! as Data)
        
        cell.fotoRumo.image = image
        cell.textoRumo.text = (noticias.object(at: indexPath.row) as AnyObject).object(forKey: "title") as? String
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "feed") as? FeedWeb
        
        let selectedFURL: String = (noticias[indexPath.row] as AnyObject).object(forKey: "link") as! String
        vc?.selectedFeedURL = selectedFURL as String
        
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: 85)
    }
    
    
    
    
    
    
}
