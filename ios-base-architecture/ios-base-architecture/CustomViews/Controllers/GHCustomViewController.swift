//
//  GHCustomViewController.swift
//  ios-base-architecture
//
//  Created by Luiz on 27/02/20.
//  Copyright © 2020 PEBMED. All rights reserved.
//

import UIKit

class GHCustomViewController<CustomView: UIView>: UIViewController{
    
    var customView: CustomView{
        return view as! CustomView
    }
    
    override func loadView() {
        super.loadView()
        self.view = CustomView()
    }
}
