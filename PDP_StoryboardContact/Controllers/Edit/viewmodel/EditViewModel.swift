//
//  EditViewModel.swift
//  PDP_StoryboardContact
//
//  Created by 13 Denis on 20/02/2022.
//

import Foundation
import Bond


class EditViewModel {
    
    var controller: BaseViewController!
    
    func editContact(contact: Contact, handler: @escaping (Bool) -> Void) {
        AFHttp.put(url: AFHttp.API_CONTACT_UPDATE + id!, params: AFHttp.paramsPostUpdate(contact: singleContact), handler: { response in
            switch response.result {
                case .success:
                    print("Edited")
                    handler(true)
                case let .failure(error):
                    print(error.localizedDescription)
                    handler(false)
            }
        })
    }
    
}
