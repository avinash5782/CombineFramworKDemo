//
//  ViewModelClass.swift
//  CombineFramworKDemo
//
//  Created by Avinash on 20/06/21.
//

import Foundation
import Combine
class viewModelClass  {
    
    let apiAMnagerr: ApiManager?
    let passthroughobj = PassthroughSubject<[userData], Error>()
    let url: URL
    init(apiMange : ApiManager, Url: URL) {
    self.apiAMnagerr = apiMange
        self.url = Url
    }
    
    func fetdata() {
        
        ApiManager.shared.fetchUser(url: self.url) {[weak self]( result: Result<[userData], Error>) in
            switch result {
            case .failure(let error):
                self?.passthroughobj.send(completion: .failure(error))
            case .success(let data):
                self?.passthroughobj.send(data)
            }
        }
    }
}
