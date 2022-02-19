//
//  CreateViewController.swift
//  PDP_StoryboardContact
//


import UIKit

class CreateViewController: BaseViewController {
    
    @IBOutlet weak var mainBackgroundView: UIView!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var saveBtnView: UIButton!
    
    var singleContact: Contact!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
    }


    // MARK: - Methods...

    private func initViews() {
        
        title = "New Contact"
        
        mainBackgroundView.layer.cornerRadius = 18.0
        
        saveBtnView.layer.masksToBounds = true
        saveBtnView.layer.cornerRadius = 18.0
        
    }
    
    private func createContact(contact: Contact) {
        AFHttp.post(url: AFHttp.API_CONTACT_CREATE, params: AFHttp.paramsPostCreate(contact: contact), handler: { response in
            switch response.result {
                case .success:
                    print("done")
                case let .failure(error):
                    print(error.localizedDescription)
            }
            
        })
    }
    
    
    // MARK: - Actions...
    @IBAction func saveBtnAction(_ sender: Any) {
        singleContact = Contact(title: nameTextField.text!, body: phoneNumberTextField.text!)
        createContact(contact: singleContact)
        self.navigationController?.popViewController(animated: true)
    }
    
}
