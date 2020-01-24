//
//  MainViewModel.swift
//  TestCherryPick
//
//  Created by Seif Nasri on 24/01/2020.
//  Copyright © 2020 Seif Nasri. All rights reserved.
//

import Foundation
import Combine

final class MainViewModel {
    
    
    private var anyConcallable : [AnyCancellable]
    private var apiService : APIServiceType
    
    private var responseSubject = PassthroughSubject<ServiceResult , Never >()
    private var errorSuvject = PassthroughSubject<ServiceError, Never>()
    
    
    var mainVc = ViewController()
    
    init( apiService : APIServiceType = APIService()) {
           self.apiService = apiService
           anyConcallable = []
           self.bindOutputs()
           self.bindInputs()

       }
    
    
    func bindOutputs(){
        
        
        let cancellableResp = responseSubject.sink(receiveValue: { value in
            print(value)
           
        })
        
        let name = Name(title: "hello", first: "Seif", last: "Nasri")
                   let timeZone = TimeZone(offset: "-6:00", description: "Central Time (US & Canada), Mexico City")
                   let location = Location(city: "Paris", state: "75", country: "France", postcode: 75015, timezone: timeZone)
                   let pict = Picture(large: "https://randomuser.me/api/portraits/women/23.jpg", medium: "https://randomuser.me/api/portraits/women/23.jpg", thumbnail: "https://randomuser.me/api/portraits/women/23.jpg")
                   let result = [Result(name: name, location: location, picture: pict)]
                   let rzsp = ServiceResult(results: result)
                   
                   self.mainVc.newResp = rzsp
        
        let cancellableError = errorSuvject.map { error -> String in
                   switch error {
                   case .network: return "network error"
                   case .parsing: return "parse error"
                   default :
                       return "unknown error"
                       }
               }
               .sink(receiveValue: {value in
                   print(value)
                     self.mainVc.newError = value
               })
        
        
        self.anyConcallable = [ cancellableResp , cancellableError]
        
    }
    
    func bindInputs(){
        
        let responsePublisher = apiService.request(withURL: "https://randomuser.me/api")
                                            .catch { [weak self] error -> Empty<ServiceResult, Never> in
                                                    self?.errorSuvject.send(error)
                                                    return .init()
                                                }
        
        let publisher = responsePublisher
            .share()
            .subscribe(responseSubject)
        
        
        anyConcallable = [publisher]
        
        
        
        
    }
}
