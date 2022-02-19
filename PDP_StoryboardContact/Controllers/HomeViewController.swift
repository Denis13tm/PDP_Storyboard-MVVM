//
//  HomeViewViewController.swift
//  PDP_StoryboardContact
//


import UIKit

class HomeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var contactList: Array<Contact> = Array()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getContactList()
        tableView.reloadData()
    }


    // MARK: - Methods...
    
    private func initViews() {
        initNavBar()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getContactList()
    }
    
    
    //Call APIs...
    public func getContactList() {
        indicateProgressView()
        AFHttp.get(url: AFHttp.API_CONTACT_LIST, params: AFHttp.paramsEmpty(), handler: { response in
            self.hideProgressView()
            switch response.result {
                case .success:
                    let contacts = try! JSONDecoder().decode([Contact].self, from: response.data!)
                    self.refreshTableView(contacts: contacts)
            case let .failure(error):
                print(error.localizedDescription)
            }
        })
    }
    
    private func deleteContact(contact: Contact) {
        indicateProgressView()
        AFHttp.del(url: AFHttp.API_CONTACT_DELETE + contact.id!, params: AFHttp.paramsEmpty(), handler: {
            response in
                self.hideProgressView()
                switch response.result {
                    case .success:
                        self.getContactList()
                case let .failure(error):
                    print(error.localizedDescription)
                }
        })
    }
    
    private func refreshTableView(contacts: [Contact]) {
        self.contactList = contacts
        self.tableView.reloadData()
    }

    private func initNavBar() {
        title = "Storyboard MVC"
        let refresh = UIImage(systemName: "arrow.clockwise")
        let add = UIImage(systemName: "text.badge.plus")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: refresh, style: .plain, target: self, action: #selector(leftTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: add, style: .plain, target: self, action: #selector(rightTapped))
    }
    
    private func callCreateViewController() {
        let vc = CreateViewController(nibName: "CreateViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    private func callEditViewController(contact: Contact) {
        let vc = EditViewController(nibName: "EditViewController", bundle: nil)
        vc.id = contact.id
        vc.name = contact.title
        vc.phoneNumber = contact.body
        
        vc.editCompletion = { res in
            if res {
                self.getContactList()
                self.tableView.reloadData()
            }
        }
        
        self.present(vc, animated: true, completion: nil)
    }
    
    //MARK: - Actions...
    
    @objc func leftTapped() {
        getContactList()
    }
    @objc func rightTapped() {
        callCreateViewController()
    }
   
    //MARK: - Table View Methods...
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contactList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let singleContact = contactList[indexPath.row]
        let cell = Bundle.main.loadNibNamed("ContactTableViewCell", owner: self, options: nil)? .first as! ContactTableViewCell
        
        cell.titleLabel.text = singleContact.title
        cell.bodyLabel.text = singleContact.body
        
        return cell
    }
    
    //new ones to me.. and repractice them :)
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        UISwipeActionsConfiguration(actions: [makeCompleteContextualAction(forRowAt: indexPath, contact: contactList[indexPath.row])])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        UISwipeActionsConfiguration(actions: [makeDeleteContextualAction(forRowAt: indexPath, contact: contactList[indexPath.row])])
    }
    
    //MARK: - Contextual Actions...
    
    private func makeDeleteContextualAction(forRowAt indexPath: IndexPath, contact: Contact) -> UIContextualAction {
        return UIContextualAction(style: .destructive, title: "Delete") { (action, swipeButtonView, completion) in
            print("DELETE :(")
            completion(true)
            self.deleteContact(contact: contact)
        }
    }
    
    private func makeCompleteContextualAction(forRowAt: IndexPath, contact: Contact) -> UIContextualAction {
        return UIContextualAction(style: .normal, title: "Edit") { (action, swipeButtonView, completion) in
            completion(true)
            self.callEditViewController(contact: contact)
            print("COMPLETE :)")
        }
    }
    
    
}
