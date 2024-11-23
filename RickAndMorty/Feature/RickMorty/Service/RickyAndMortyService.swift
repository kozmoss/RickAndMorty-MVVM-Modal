//
//  RickyAndMortyService.swift
//  RickAndMorty
//
//  Created by samet on 23.11.2024.
//

import Foundation
import Alamofire

enum RickyAndMortyServiceEndPoint: String {
    case BASE_URL = "https://rickandmortyapi.com/api"
    case PATH = "/character"
    static func characterPath() -> String {
        return "\(BASE_URL.rawValue)\(PATH.rawValue)"
    }
}

protocol IRickyMortyService {
    func getAllDatas(response: @escaping ([Result]?) -> Void)
}

struct RickyAndMortyService:IRickyMortyService {
    func getAllDatas(response: @escaping ([Result]?) -> Void) {
        AF.request(RickyAndMortyServiceEndPoint.characterPath()).responseDecodable(of: Welcome.self) { modal in
            guard let data = modal.value else {
                response(nil)
                return
            }
            
            response(data.results)
        }
    }
    
    
}
    
