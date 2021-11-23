//
//  NetworkProxi.swift
//  MyVKclient
//
//  Created by Владислав Тихоненков on 22.11.2021.
//

import Foundation


class NetworkNewsServiceProxy : NetworkNewsInterface {
    let networkNews : NetworkNews

    init (networkNews : NetworkNews){
        self.networkNews = networkNews
    }
    func newsRequest(startFrom: String = "", startTime: Double? = nil, completion: @escaping ([News], String) -> Void) {

        print("------------------------------------")
        self.networkNews.newsRequest { news, nextFrom in
            print(" ++++++      Called func networkNews with news !!!!  =  \(news)")
        }
    }


}

