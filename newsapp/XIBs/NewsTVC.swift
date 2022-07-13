//
//  NewsTVC.swift
//  newsapp
//
//

import UIKit

class NewsTVC: UITableViewCell {

    //MARK: - Outlets
    
    @IBOutlet weak var newsImage: UIImageView!
    
    @IBOutlet weak var newsTitle: UILabel!
    
    @IBOutlet weak var newsAuthor: UILabel!
    
    
    @IBOutlet weak var newsDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

   
    
}
