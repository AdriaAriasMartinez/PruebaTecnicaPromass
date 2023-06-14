//
//  DetailViewController.swift
//  PruebaPromass
//
//  Created by MacBookMBA11 on 14/06/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var autorLabel: UILabel!
    @IBOutlet weak var fechaLabel: UILabel!
    @IBOutlet weak var contenidoLabel: UITextView!
    @IBOutlet weak var postImageView: UIImageView!
    
    var id: String = ""
    var titulo: String = ""
    var autor: String = ""
    var fecha: String = ""
    var contenido: [String] = []
    var imagen: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hexString = "BDCDD6"
        if let color = UIColor(hexString: hexString) {
            view.backgroundColor = color
        } else {
            print("Valor hexadecimal no válido")
        }
        
        
        postImageView.layer.cornerRadius = 20
        postImageView.layer.borderWidth = 4.0
        postImageView.layer.borderColor = UIColor(named: "BordeAzul")?.cgColor
        tituloLabel.text = titulo
        autorLabel.text = autor
        fechaLabel.text = fecha
        var contentString = ""
        for i in 0..<contenido.count {
            contentString = contentString + contenido[i] + " "
        }
        contenidoLabel.text = contentString
        contenidoLabel.isEditable = false
        let image = getimage()
        if image == nil{
            postImageView.image = UIImage(named: "trash")
        }else{
            postImageView.image = getimage()
        }
    }
    
    func getimage() -> UIImage?{
        if let imageData = Data(base64Encoded: self.imagen) {
            return UIImage(data: imageData)
        }
        return nil
    }
}


extension UIColor {
    convenience init?(hexString: String) {
        let r, g, b, a: CGFloat
        
        var hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        hexString = hexString.replacingOccurrences(of: "#", with: "")
        
        guard hexString.count == 6 else {
            return nil
        }
        
        var hexNumber: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&hexNumber)
        
        r = CGFloat((hexNumber & 0xFF0000) >> 16) / 255.0
        g = CGFloat((hexNumber & 0x00FF00) >> 8) / 255.0
        b = CGFloat(hexNumber & 0x0000FF) / 255.0
        a = 2.0
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
}
