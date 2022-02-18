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


    // MARK: - Methods...
    
    private func initViews() {
        initNavBar()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        contactList.append(Contact(title: "Otabek Tuychiev", body: "+82 10 2215 1913"))
        contactList.append(Contact(title: "Shohrukh Khayitov", body: "+82 10 3535 7807"))
        contactList.append(Contact(title: "Jonathan Duke", body: "+82 10 5643 2829"))
        contactList.append(Contact(title: "Stephany Madson", body: "+82 10 2299 0305"))
        contactList.append(Contact(title: "PDP", body: "pdp.com/contact_admin/"))
        
    }

    private func initNavBar() {
        title = "My Contacts"
        let refresh = UIImage(systemName: "arrow.clockwise")
        let add = UIImage(systemName: "text.badge.plus")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: refresh, style: .plain, target: self, action: #selector(leftTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: add, style: .plain, target: self, action: #selector(rightTapped))
    }
    
    private func callCreateViewController() {
        let vc = CreateViewController(nibName: "CreateViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    private func callEditViewController() {
        let vc = EditViewController(nibName: "EditViewController", bundle: nil)
        let nv = UINavigationController(rootViewController: vc)
        self.present(nv, animated: true, completion: nil)
    }
    
    //MARK: - Actions...
    
    @objc func leftTapped() {
        
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
        UISwipeActionsConfiguration(actions: [makeCompleteContextualAction(forRowAt: indexPath, model: contactList[indexPath.row])])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        UISwipeActionsConfiguration(actions: [makeDeleteContextualAction(forRowAt: indexPath, model: contactList[indexPath.row])])
    }
    
    //MARK: - Contextual Actions...
    
    private func makeDeleteContextualAction(forRowAt indexPath: IndexPath, model: Contact) -> UIContextualAction {
        return UIContextualAction(style: .destructive, title: "Delete") { (action, swipeButtonView, completion) in
            print("DELETE :(")
            completion(true)
        }
    }
    
    private func makeCompleteContextualAction(forRowAt: IndexPath, model: Contact) -> UIContextualAction {
        return UIContextualAction(style: .normal, title: "Edit") { (action, swipeButtonView, completion) in
            print("COMPLETE :)")
            completion(true)
            self.callEditViewController()
        }
    }
    
    
}
