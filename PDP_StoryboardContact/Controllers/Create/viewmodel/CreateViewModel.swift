//
//  CreateViewModel.swift
//  PDP_StoryboardContact
//
//  Created by 13 Denis on 20/02/2022.
//

import Foundation
import Bond

class CreateViewModel {
    
    var controller: BaseViewController!
    
    func createContact(contact: Contact, handler: @escaping (Bool) -> Void) {
        AFHttp.post(url: AFHttp.API_CONTACT_CREATE, params: AFHttp.paramsPostCreate(contact: contact), handler: { response in
            switch response.result {
                case .success:
                    print("done")
                    handler(true)
                case let .failure(error):
                    print(error.localizedDescription)
                    handler(false)
            }
            
        })
    }
}
