//
//  APIService.swift
//  TestCherryPick
//
//  Created by Seif Nasri on 24/01/2020.
//  Copyright © 2020 Seif Nasri. All rights reserved.
//

import Foundation
import Combine

protocol APIServiceType  {
    func request(withURL : String ) -> AnyPublisher< ServiceResult , ServiceError >
}

final class APIService : APIServiceType {
    
    init() {
        
    }
    
    func request(withURL : String ) -> AnyPublisher< ServiceResult , ServiceError > {
        
        
        let pathURL = URL(string: withURL)!
        
                let urlComponents = URLComponents(url: pathURL, resolvingAgainstBaseURL: true)!
                var request = URLRequest(url: urlComponents.url!)
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
                let decorder = JSONDecoder()
                //decorder.keyDecodingStrategy = .convertFromSnakeCase

                return URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { data, urlResponse in
                    print(data)
                    return  data
                }
                .mapError { _ in ServiceError.network }
                .decode(type: ServiceResult.self, decoder: decorder)
                .mapError{ _ in ServiceError.parsing}
                .receive(on: RunLoop.main)
                .eraseToAnyPublisher()
        
        
    }
    
}
