//
//  PostTableViewCell.swift
//  PruebaPromass
//
//  Created by MacBookMBA11 on 14/06/23.
//

import UIKit
import SwipeCellKit

class PostTableViewCell: SwipeTableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var autorLabel: UILabel!
    @IBOutlet weak var fechaLabel: UILabel!
    @IBOutlet weak var contenidoLabel: UILabel!
    @IBOutlet weak var miView: UIView!
    @IBOutlet weak var postImageView: UIImageView!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        postImageView.layer.cornerRadius = 20
        miView.layer.cornerRadius = 20
        miView.layer.borderWidth = 0.8
        miView.layer.borderColor = UIColor(named: "BordeAzul")?.cgColor
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
}
