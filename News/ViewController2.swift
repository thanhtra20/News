//
//  ViewController2.swift
//  News
//
//  Created by Nguyễn Trà on 8/31/21.
//

import Foundation
import UIKit

class ViewController2: UIViewController {
    var passData : Article?
    @IBOutlet weak var LbTitle: UILabel!
    @IBOutlet weak var Content: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LbTitle.text = passData?.title
        Content.text = passData?.content
        
    }
    
}
