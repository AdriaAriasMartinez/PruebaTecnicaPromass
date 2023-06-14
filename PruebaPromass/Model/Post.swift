//
//  Post.swift
//  PruebaPromass
//
//  Created by MacBookMBA11 on 14/06/23.
//

import Foundation

struct Post: Encodable {
    
    var autor: String
    var contenido: [String]
    var fecha: String
    var titulo: String
    var imagen: String
    
    init(autor: String, contenido: [String], fecha: String, titulo: String, imagen: String) {
        self.autor = autor
        self.contenido = contenido
        self.fecha = fecha
        self.titulo = titulo
        self.imagen = imagen
    }
    init(){
        self.autor = ""
        self.contenido = []
        self.fecha = ""
        self.titulo = ""
        self.imagen = ""
        
    }
    init(dictionary: [String: Any]) {
        self.autor = dictionary["autor"] as? String ?? ""
        self.contenido = dictionary["contenido"] as? [String] ?? []
        self.fecha = dictionary["fecha"] as? String ?? ""
        self.titulo = dictionary["titulo"] as? String ?? ""
        self.imagen = dictionary["imagen"] as? String ?? ""
    }
}

