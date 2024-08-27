//
//  ViewController.swift
//  project-1
//
//  Created by Sueda Beyza Özcan on 26.08.2024.
//

import UIKit


class ViewController: UITableViewController {
    var pictures = [String]()
    var name = [String](
    )
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true

        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        name = ["nssl0033","nssl0034","nssl0041","nssl0042","nssl0043","nssl0045","nssl0046","nssl0049","nssl0051","nssl0091"]
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
                pictures.sort()
            }
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    }
 

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    @objc func shareTapped() {
        let message = "This app is my favorite"
        let url = URL(string: "https://www.apple.com")!
        
        // Paylaşılacak içerikleri oluşturun
        let items: [Any] = [message, url]
        
        // UIActivityViewController'ı başlatın
        let ac = UIActivityViewController(activityItems: items, applicationActivities: [])
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        // Cihazın gerçek bir cihazda olduğundan emin olun
        present(ac, animated: true)
    
    }

}

