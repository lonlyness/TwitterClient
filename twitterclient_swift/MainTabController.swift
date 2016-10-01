//
//  MainTabController.swift
//  Twitterclient
//
//  Created by ryota yamada on 2016/08/17.
//  Copyright © 2016年 TakumaNishimura. All rights reserved.
//

import UIKit

class MainTabController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = UIColor.orangeColor()   // タブバーのアイコンなどをオレンジ色にしている
    }
}
