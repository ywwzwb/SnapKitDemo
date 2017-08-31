//
//  ViewController.swift
//  SnapKitDemo
//
//  Created by 曾文斌 on 2017/8/31.
//  Copyright © 2017年 yww. All rights reserved.
//

import UIKit
import SnapKit
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let imageView = UIImageView(image: #imageLiteral(resourceName: "airplane_take_off.png"))
        self.view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.center.equalTo(self.view.snp.center)
        }
        let label = UILabel()
        label.text = "airplane"
        self.view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.centerX.equalTo(imageView.snp.centerX)
            make.top.equalTo(imageView.snp.bottom).offset(8)
        }
        let bg = UIView()
        bg.backgroundColor = UIColor.gray
        self.view.insertSubview(bg, belowSubview: imageView)
        bg.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.top).offset(8)
            make.width.equalTo(self.view.snp.width).multipliedBy(0.8)
            make.centerX.equalTo(self.view.snp.centerX)
            make.bottom.equalTo(label).offset(8)
        }
        let myLabel = UILabel()
        myLabel.text = "my snapkit!"
        self.view.addSubview(myLabel)
        myLabel.mysnp.make { (maker) in
            maker.left.equalTo(bg.mysnp.left).offset(8)
            maker.top.equalTo(bg.mysnp.top).offset(8)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

