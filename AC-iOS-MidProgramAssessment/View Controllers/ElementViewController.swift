//
//  ElementViewController.swift
//  AC-iOS-MidProgramAssessment
//
//  Created by Maryann Yin on 12/8/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit

class ElementViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var elementsTableView: UITableView!
    
    var elementArr = [ElementWrapper]() {
        didSet {
            self.elementsTableView.reloadData()
        }
    }
    
    func loadData() {
        let url = "https://api.fieldbook.com/v1/5a29757f9b3fec0300e1a68c/elements"
        let completion: ([ElementWrapper]) -> Void = {(onlineElementsInfo: [ElementWrapper]) in
            self.elementArr = onlineElementsInfo
            print(onlineElementsInfo.count)
        }
        ElementsAPIClient.manager.getElementInfo(from: url,
                                               completionHandler: completion,
                                               errorHandler: {print($0)})
    }
    
//    func loadImage() {
//        guard let url = URL(string: "http://www.theodoregray.com/periodictable/Tiles/ElementNumberWithThreeDigits/s7.JPG") else {return}
//        let myGlobalQueue = DispatchQueue.global(qos: .utility)
//        myGlobalQueue.async {
//            print("About to make network connection")
//            guard let rawImageData = try? Data(contentsOf: url) else {return}
//            DispatchQueue.main.async {
//                guard let onlineImage = UIImage(data: rawImageData) else {return}
//                ElementTableViewCell.elementThumbNailImageView = onlineImage
//                print("Just set image")
//            }
//            print("Just dispatched to main queue")
//        }
//        print("Just dispatched to global queue")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        elementsTableView.delegate = self
        elementsTableView.dataSource = self
        loadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elementArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellElementContent = self.elementArr[indexPath.row]
        dump(cellElementContent)
        guard let cell = elementsTableView.dequeueReusableCell(withIdentifier: "ElementCell", for: indexPath) as? ElementTableViewCell else
        {return UITableViewCell()}
        cell.elementNameLabel.text = cellElementContent.name
        cell.elementSymbolAndAtomicWeightLabel.text = cellElementContent.symbol + " " + cellElementContent.weight.description
//        let completion: (UIImage) -> Void = {(onlineElementImage: UIImage) in
//            cell.elementThumbNailImageView.image = onlineElementImage
//            cell.setNeedsLayout()
//        }
//        guard let image = else {
//            return cell
//        }
//        ImageAPIClient.manager.getImage(from: image.medium, completionHandler: completion, errorHandler: {print($0)})
        return cell
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let destination = segue.destination as? EpisodesDetailViewController {
//            let selectedRow = self.episodesTableView.indexPathForSelectedRow!.row
//            let selectedEpisode = self.episodeArr[selectedRow]
//            destination.tvEpisodeInfo = selectedEpisode
//        }
//    }
    
}
