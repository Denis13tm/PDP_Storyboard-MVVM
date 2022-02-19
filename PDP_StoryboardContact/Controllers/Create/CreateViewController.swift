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
    
    var viewModel = CreateViewModel()
    
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
        bindViewModel()
    }
    
    func bindViewModel() {
        viewModel.controller = self
    }
    
    
    // MARK: - Actions...
    @IBAction func saveBtnAction(_ sender: Any) {
        singleContact = Contact(title: nameTextField.text!, body: phoneNumberTextField.text!)
        viewModel.createContact(contact: singleContact)
        self.navigationController?.popViewController(animated: true)
    }
    
}
