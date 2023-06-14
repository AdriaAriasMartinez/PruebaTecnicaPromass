//
//  SearchViewController.swift
//  PruebaPromass
//
//  Created by MacBookMBA11 on 14/06/23.
//

import UIKit
import SwipeCellKit
import Firebase
import FirebaseFirestore
import Network

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var postsTableView: UITableView!
    
    var posts = [Post]()
    let firebaseViewModel = FireBaseViewModel()
    let coreViewModel = CoreViewModel()
    var busqueda: String = ""
    var id: String = ""
    var titulo: String = ""
    var autor: String = ""
    var fecha: String = ""
    var contenido: [String] = []
    var imagenStr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewWillAppear(true)
        searchBar.delegate = self
        //searchBar.showsCancelButton = true
        searchBar.placeholder = "Buscar por autor, titulo o contenido"
        postsTableView.selectionFollowsFocus = false
        postsTableView.dataSource = self
        postsTableView.delegate = self
        postsTableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "PostCell")
        
        let conexion =  verificarConexionInternet()
        
        if conexion{
            loadData()
        }else{
            let alert = UIAlertController(title: "Aviso", message: "No hay conexión a internet", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default) { action in
                self.posts = []
                self.firebaseViewModel.getAll1 { data, error in
                    if data != nil {
                        self.posts = []
                        self.posts = data!
                        DispatchQueue.main.async {
                            self.postsTableView.reloadData()
                        }
                    }
                }
            }
            alert.addAction(ok)
            self.present(alert, animated: true)
            navigationItem.rightBarButtonItem = nil
            
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    func loadData(){
        firebaseViewModel.getAll1 { data, error in
            if let data = data {
                self.posts = data
                self.postsTableView.reloadData()
            }
        }
    }
    func verificarConexionInternet() -> Bool {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "MonitoreoInternet")
        
        var tieneConexionInternet = false
        
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                tieneConexionInternet = true
            } else {
                tieneConexionInternet = false
            }
        }
        
        monitor.start(queue: queue)
        print(tieneConexionInternet)
        return tieneConexionInternet
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.busqueda = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.posts = []
        firebaseViewModel.getByAutor(autor: self.busqueda) { data, error in
            if data != nil {
                //self.posts = []
                self.posts = self.posts + data!
                DispatchQueue.main.async {
                    self.postsTableView.reloadData()
                }
            }
        }
        firebaseViewModel.getByTitulo(titulo: self.busqueda) { data, error in
            if data != nil {
                //self.posts = []
                self.posts = self.posts + data!
                DispatchQueue.main.async {
                    self.postsTableView.reloadData()
                }
            }
        }
        firebaseViewModel.getByContent(content: self.busqueda.components(separatedBy: " ")) { data, error in
            if data != nil{
                //self.posts = []
                self.posts = self.posts + data!
                DispatchQueue.main.async {
                    self.postsTableView.reloadData()
                }
            }
        }
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
        firebaseViewModel.getAll1 { data, error in
            if data != nil {
                self.posts = []
                self.posts = data!
                DispatchQueue.main.async {
                    self.postsTableView.reloadData()
                }
            }
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        searchBar.setShowsCancelButton(true, animated: true)
        
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        searchBar.setShowsCancelButton(false, animated: true)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostTableViewCell
        
        cell.tituloLabel.text = posts[indexPath.row].titulo
        cell.autorLabel.text = posts[indexPath.row].autor
        cell.fechaLabel.text = posts[indexPath.row].fecha
        //let text = posts[indexPath.row].contenido
        var contentString = ""
        for i in 0..<posts[indexPath.row].contenido.count{
            contentString = contentString + posts[indexPath.row].contenido[i] + " "
        }
        
        //cell.contenidoLabel.text = text.truncate(length: 60)
        cell.contenidoLabel.text = contentString.truncate(length: 60)
        let imageData = Data(base64Encoded: posts[indexPath.row].imagen)
        cell.postImageView.image = UIImage(data: imageData!)
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.postsTableView.deselectRow(at: indexPath, animated: true)
        self.id = posts[indexPath.row].titulo
        self.titulo = posts[indexPath.row].titulo
        self.fecha = posts[indexPath.row].fecha
        self.autor = posts[indexPath.row].autor
        self.contenido = posts[indexPath.row].contenido
        self.imagenStr = posts[indexPath.row].imagen
        
        performSegue(withIdentifier: "DetailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "DetailSegue" {
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.id = self.id
            detailViewController.titulo = self.titulo
            detailViewController.contenido = self.contenido
            detailViewController.fecha = self.fecha
            detailViewController.autor = self.autor
            detailViewController.imagen = self.imagenStr
        }
        if segue.identifier == "UpdateSegue"{
            let formViewController = segue.destination as! FormViewController
            formViewController.id = self.id
        }
    }
}


extension SearchViewController: SwipeTableViewCellDelegate{
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        if orientation == .right{
            let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
                self.id = self.posts[indexPath.row].titulo
                self.firebaseViewModel.Delete(id: self.id) { data, error in
                    if let error = error{
                        fatalError("Error al eliminar: \(error.localizedDescription)")
                    }else{
                        
                    }
                }
                self.loadData()
            }
            deleteAction.image = UIImage(named: "trash")
            return [deleteAction]
        }else{
            let updateAction = SwipeAction(style: .destructive, title: "Update") { action, indexPath in
                self.id = self.posts[indexPath.row].titulo
                self.performSegue(withIdentifier: "UpdateSegue", sender: self)
                
            }
            updateAction.image = UIImage(systemName: "repeat")
            updateAction.backgroundColor = .orange
            return [updateAction]
        }
    }
}

extension String {
    
    func truncate(length: Int, trailing: String = " ...Ver mas") -> String {
        if self.count > length {
            return String(self.prefix(length)) + trailing
        } else {
            return self
        }
    }
}
