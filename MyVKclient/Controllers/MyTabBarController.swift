//
//  MyTabBarController.swift
//  MyVKclient
//
//  Created by Владислав Тихоненков on 27.06.2021.
//

import UIKit
import RealmSwift
import PromiseKit


final class MyTabBarController: UITabBarController {

    private let network = NetworkFriends()
    private let networkGroup = NetworkGroup()
    private let networkProfile = NetworkProfile()
    private let networkFriendFotos = NetworkFriendFotos()
    private let networkNews = NetworkNews()
    private let newsModel = NewsModel()
    private let realm = try! Realm(configuration: Realm.Configuration(deleteRealmIfMigrationNeeded: true))

    override func viewDidLoad() {
        super.viewDidLoad()

        network.pingMyFriends()
            .done {  [weak self] idFriends  in

                guard let self = self else {return}
                DispatchQueue.global(qos: .userInteractive).async {

                    for i in idFriends {
                        let idFriend = i.friendId
                        self.networkFriendFotos.pingMyFriendFotos(idFriend: idFriend)
                        usleep(300000) // вынужденная задержка из за ограниченного количества запросов  в секунду в ВК

                    }
                }
            }
        networkGroup.pingMyGroups()
        
        DispatchQueue.global(qos: .utility).async {
            self.networkProfile.pingMyFotos()
        }
        print("=============\(realm.configuration.fileURL as Any)")
    }
}

