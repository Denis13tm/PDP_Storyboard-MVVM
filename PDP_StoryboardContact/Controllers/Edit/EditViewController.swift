//
//  EditViewController.swift
//  PDP_StoryboardContact
//


import UIKit

class EditViewController: BaseViewController {
    
    @IBOutlet weak var lowestBackgroundView: UIView!
    @IBOutlet weak var middleBackgroundView: UIView!
    @IBOutlet weak var mainBackgroundView: UIView!
    
    @IBOutlet weak var titleBackgroundView: UIView!
    @IBOutlet weak var titleUpperBackgroundView: UIView!
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var saveBtnView: UIButton!
    
    var singleContact: Contact!
    var id: String?
    var name: String?
    var phoneNumber: String?
    
    typealias completion = (Bool)->Void
    var editCompletion:completion!
    
    var viewModel = EditViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        hideKeyboardWhenTappedAround()
    }
    
    func bindViewModel() {
        viewModel.controller = self
        viewModel.editContact(contact: singleContact, handler: { contact in
            //action...
        })
    }


    // MARK: - Methods...

    private func initViews() {
        saveBtnView.layer.masksToBounds = true
        saveBtnView.layer.cornerRadius = 18.0
        
        titleBackgroundView.layer.cornerRadius = 18.0
        titleUpperBackgroundView.layer.cornerRadius = 18.0
        
        lowestBackgroundView.layer.cornerRadius = 18.0
        middleBackgroundView.layer.cornerRadius = 18.0
        mainBackgroundView.layer.cornerRadius = 18.0
        
        nameTextField.text = name
        phoneNumberTextField.text = phoneNumber
        
    }
    
    

    //MARK: - Actions...
    
    @IBAction func saveBtnAction(_ sender: Any) {
        singleContact = Contact(title: nameTextField.text!, body: phoneNumberTextField.text!)
        singleContact.id = id
        editContact(contact: singleContact)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelBtnAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}



// Put this piece of code anywhere you like to hide default keyboard
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

