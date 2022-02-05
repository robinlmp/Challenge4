//
//  ViewController.swift
//  Project1
//
//  Created by Robin Phillips on 30/12/2021.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var pictures = [Picture]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Photo captioner"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newPicture))
        
        tableView.rowHeight = 110
        
    }
    
    func loadPhotos() {
        // this needs editing to only find images from pictures array
        
//        DispatchQueue.global(qos: .userInitiated).async {
//            let fm = FileManager.default
//            let path = Bundle.main.resourcePath!
//            print(path)
//            let items = try! fm.contentsOfDirectory(atPath: path)
//
//            for item in items {
//
//                self.pictures.append(item)
//                    print(item)
//
//            }
//            self.pictures.sort()
//        }
//
//        DispatchQueue.main.async {
//            self.tableView.reloadData()
//        }
    }
    
    
    @objc func newPicture() {
        let picker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        }
        
        picker.allowsEditing = true
        picker.delegate = self
        
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }

        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        
        

        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        // need to set up inputting caption for image
        
        let picture = Picture(name: "temp text", filePath: imagePath.path)
        pictures.append(picture)
        tableView.reloadData()
        
        
        
        dismiss(animated: true)
        
        // save user defaults
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath) as! PictureCell
//        cell.textLabel?.text = pictures[indexPath.row]
//        cell.textLabel?.text = "Picture \(indexPath.row + 1) of \(pictures.count)"
        cell.pictureImage.image = UIImage(named: pictures[indexPath.row].filePath)
        cell.pictureCaption.text = pictures[indexPath.row].caption
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 1: try loading the "Detail" view controller and typecasting it to be DetailViewController
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            // 2: success! Set its selectedImage property
            vc.selectedImage = pictures[indexPath.row].filePath

            // 3: now push it onto the navigation controller
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

