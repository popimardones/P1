//
//  UserProfileController2.swift
//  Sentinel
//
//  Created by Paula Mardones on 11/26/17.
//  Copyright © 2017 paulamardonesb97. All rights reserved.
//

import UIKit
import Firebase

class UserProfileController2: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, VehiclesRegisteredCellDelegate, CommunitiesJoinedCellDelegate{
    
    var userId: String?
    var vehiclesRegisteredCollectionView : UICollectionView!
    
    let vehiclesRegisteredCellId = "vehiclesRegisteredCellId"
    

    
    let profileImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.layer.borderColor = UIColor.rgb(red: 8, green: 19, blue: 68).cgColor
        iv.layer.borderWidth = 2
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    let sectionHeader1Label : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        let attributedText = NSMutableAttributedString(string: "  Vehicles", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSAttributedString(string: " registered", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)]))
        
        label.attributedText = attributedText
        label.numberOfLines = 0
        label.backgroundColor = .darkBlue()
        return label
    }()
    
    let sectionHeader2Label : UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        let attributedText = NSMutableAttributedString(string: "  Communities", attributes: [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
        
        attributedText.append(NSAttributedString(string: " joined", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)]))
        
        label.attributedText = attributedText
        label.numberOfLines = 0
        label.backgroundColor = .darkBlue()
        return label
    }()
    
    
    let registerVehicleButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(handleRegisterVehicle), for: .touchUpInside)
        button.setTitle("  Register a vehicle  ", for: .normal)
//        button.titleLabel?.font = .systemFont(ofSize: 14)
//        button.layer.cornerRadius = 3
//        button.setTitleColor(UIColor.white, for: .normal)
//        button.backgroundColor = .darkBlue()
       
        button.backgroundColor = .lightBlue()
        button.layer.borderColor = UIColor.rgb(red: 7, green: 17, blue: 63).cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        
        return button
    }()
    
    @objc func handleRegisterVehicle(){
        
        let registerVehicleController = RegisterVehicleController()
        let navController = UINavigationController(rootViewController: registerVehicleController)
        
        present(navController, animated: true, completion: nil)
        
    }
    
    let joinCommunityButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(handleJoinCommunity), for: .touchUpInside)
        button.setTitle("  Join a community  ", for: .normal)
        //button.titleLabel?.font = .systemFont(ofSize: 14)
        //button.layer.cornerRadius = 3
        //button.setTitleColor(UIColor.white, for: .normal)
        //button.backgroundColor = .darkBlue()
        
        button.backgroundColor = .lightBlue()
        button.layer.borderColor = UIColor.rgb(red: 7, green: 17, blue: 63).cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        
        
        return button
    }()
    
    @objc func handleJoinCommunity(){
        
        let joinCommunityController = JoinCommunityController()
        let navController = UINavigationController(rootViewController: joinCommunityController)
        
        present(navController, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(handleUpdateCollectionView), name: RegisterVehicleController.updateFeedNotificationName, object: nil)

        let layout1: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
        //------------------------------------------------------------------
        view.addSubview(profileImageView)
        profileImageView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 75, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 80, height: 80)
        profileImageView.layer.cornerRadius = 80 / 2
        profileImageView.clipsToBounds = true
        //------------------------------------------------------------------
        let buttonStackView = UIStackView(arrangedSubviews: [registerVehicleButton,joinCommunityButton])
        buttonStackView.spacing = 10
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fill
        view.addSubview(buttonStackView)
        buttonStackView.anchor(top: nil, left: profileImageView.rightAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
        buttonStackView.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor).isActive = true
        
        //------------------------------------------------------------------
        view.addSubview(sectionHeader1Label)
        sectionHeader1Label.anchor(top: profileImageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 30)
        
        //------------------------------------------------------------------
        
        //vehicles registered collection view
        vehiclesRegisteredCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout1)
        vehiclesRegisteredCollectionView.dataSource = self
        vehiclesRegisteredCollectionView.delegate = self
        vehiclesRegisteredCollectionView.backgroundColor = UIColor.rgb(red: 103, green: 112, blue: 154)
        //        vehiclesRegisteredCollectionView.backgroundColor = UIColor.rgb(red: 187, green: 190, blue: 202)
        
        view.addSubview(vehiclesRegisteredCollectionView)
        vehiclesRegisteredCollectionView.anchor(top: sectionHeader1Label.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        //vehiclesRegisteredCollectionView.refreshControl = refreshControl
        
        
        //view.backgroundColor = UIColor.lightGray
        view.backgroundColor = UIColor.rgb(red: 103, green: 112, blue: 154)
        
        vehiclesRegisteredCollectionView.register(VehiclesRegisteredCell.self, forCellWithReuseIdentifier: vehiclesRegisteredCellId)

        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        vehiclesRegisteredCollectionView.refreshControl = refreshControl
        
        fetchUser()
        fetchVehicles()
        setupLogOutButton()

    }
    
    @objc func handleUpdateCollectionView(){
        handleRefresh()
    }
    
    
    @objc func handleRefresh() {
        print("Handling refresh..")
        //collectionView?.scrollsToTop = false
        vehiclesRegistered.removeAll()
        fetchVehicles()
    }
    
    var currentUser: User? {
        didSet {
            guard let profileImageUrl = currentUser?.profileImageUrl else { return }
            profileImageView.loadImage(urlString: profileImageUrl)
            
            //------------number of vehicles register-------------------------
            
            guard let numVehiclesRegistered = currentUser?.numberOfVehiclesRegistered else { return }
            let numVehiclesRegisteredString = String(numVehiclesRegistered)
            let numVehiclesAttributedText = NSMutableAttributedString(string: numVehiclesRegisteredString, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedStringKey.foregroundColor: UIColor.white])
            
            numVehiclesAttributedText.append(NSAttributedString(string: " vehicles registered", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16), NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 8, green: 19, blue: 68)
                ]))
            
            //numberOfVehiclesRegisteredLabel.attributedText = numVehiclesAttributedText
            
        }
    }
    
    
    fileprivate func fetchUser() {
        let uid = userId ?? (Auth.auth().currentUser?.uid ?? "")
        
        //guard let uid = FIRAuth.auth()?.currentUser?.uid else { return }
        
        Database.fetchUserWithUID(uid: uid) { (user) in
            self.currentUser = user
            self.navigationItem.title = self.currentUser?.username
            //            let profileImageUrl = user.profileImageUrl
            //            self.profileImageView.loadImage(urlString: profileImageUrl)
            //
            
        }
    }
    
    var vehiclesRegistered = [Vehicle]()
    fileprivate func fetchVehicles() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Database.fetchUserWithUID(uid: uid) { (user) in
            self.fetchVehiclesWithUser(user: user)
        }
    }
    
    fileprivate func fetchVehiclesWithUser(user: User) {
        let ref = Database.database().reference().child("Vehicles_of_users").child(user.uid)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
        self.vehiclesRegisteredCollectionView.refreshControl?.endRefreshing()
        guard let dictionaries = snapshot.value as? [String: Any] else { return }
        print(dictionaries)
            
        dictionaries.forEach({ (key, value) in
            guard let dictionary = value as? [String: Any] else { return }
            print(dictionary)
                //                var post = Post(user: user, dictionary: dictionary)
                //                post.id = key
            var vehicle = Vehicle(user: user, dictionary: dictionary)
            vehicle.id = key
                
            self.vehiclesRegistered.append(vehicle)
            self.vehiclesRegisteredCollectionView.reloadData()
            })
        }) { (err) in
            print("Failed to fetch posts:", err)

        }
    }
   
    fileprivate func setupLogOutButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "gear"), style: .plain, target: self, action: #selector(handleLogOut))
        navigationItem.rightBarButtonItem?.tintColor = .blueGray()
    }
    
    @objc func handleLogOut() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (_) in
            
            do {
                try Auth.auth().signOut()
                
                //what happens? we need to present some kind of login controller
                let loginController = LoginController()
                let navController = UINavigationController(rootViewController: loginController)
                self.present(navController, animated: true, completion: nil)
                
            } catch let signOutErr {
                print("Failed to sign out:", signOutErr)
            }
            
            
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height: CGFloat = 100
        
        return CGSize(width: view.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        return posts.count
        return vehiclesRegistered.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cellVehiclesRegisteredCell = collectionView.dequeueReusableCell(withReuseIdentifier: vehiclesRegisteredCellId, for: indexPath) as! VehiclesRegisteredCell
        
        if vehiclesRegistered.count > 0 {
            cellVehiclesRegisteredCell.vehicle = vehiclesRegistered[indexPath.item]
        }
        cellVehiclesRegisteredCell.backgroundColor = .lightBlue()
        
        return cellVehiclesRegisteredCell
        
    }
    
    
}
