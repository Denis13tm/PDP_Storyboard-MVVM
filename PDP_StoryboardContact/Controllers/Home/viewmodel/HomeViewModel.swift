//
//  HomeViewModel.swift
//  PDP_StoryboardContact
//
//  Created by 13 Denis on 20/02/2022.
//

import Foundation
import Bond

class HomeViewModel {
    
    var controller: BaseViewController!
    var items = Observable<[Contact]>([])
    
    
    //Call APIs...
    func getContactList() {
        controller.indicateProgressView()
        AFHttp.get(url: AFHttp.API_CONTACT_LIST, params: AFHttp.paramsEmpty(), handler: { response in
            self.controller.hideProgressView()
            switch response.result {
                case .success:
                    let contacts = try! JSONDecoder().decode([Contact].self, from: response.data!)
                    self.items.value = contacts
                case let .failure(error):
                    print(error.localizedDescription)
            }
        })
    }
    
    func deleteContact(contact: Contact, handler: @escaping (Bool) -> Void) {
        controller.indicateProgressView()
        AFHttp.del(url: AFHttp.API_CONTACT_DELETE + contact.id!, params: AFHttp.paramsEmpty(), handler: {
            response in
            self.controller.hideProgressView()
                switch response.result {
                    case .success:
                        handler(true)
                    case let .failure(error):
                        print(error.localizedDescription)
                        handler(false)
                }
        })
    }
    
}
