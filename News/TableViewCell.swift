//
//  TableViewCell.swift
//  News
//
//  Created by Nguyễn Trà on 8/27/21.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var Description: UITextView!
    @IBOutlet weak var newsImg: UIImageView!
   
    var img: String! {
        didSet{
            if let url = URL(string: img) {
                
                if let data = try? Data(contentsOf: url) {
                    newsImg.image = UIImage(data: data)
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //Title.numberOfLines = 0
        Title.font = UIFont.boldSystemFont(ofSize: 17.0)
        imageView?.backgroundColor = .blue
        
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
 
