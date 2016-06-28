//
//  ViewController.swift
//  ASCII Art
//
//  Created by Liuliet.Lee on 25/6/2016.
//  Copyright © 2016 Liuliet.Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, LLTransformerDelegate {

    @IBOutlet weak var label: UILabel!
    
    private let transformer = LLTransformer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        transformer.delegate = self
        
        self.title = "Converting"
        let image = UIImage(named: "bilibili.jpg")!
        let text = transformer.convertUIImageToText(image: image, clarity: 98)
        label.text = text
    }
    
    func convertFinished(text: String) {
        print(text)
    }
    
}

