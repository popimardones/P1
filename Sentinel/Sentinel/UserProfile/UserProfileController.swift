//
//  UserProfileController.swift
//  Sentinel
//
//  Created by Paula Mardones on 11/26/17.
//  Copyright © 2017 paulamardonesb97. All rights reserved.
//

import UIKit
import Firebase

class UserProfileController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, VehiclesRegisteredCellDelegate, CommunitiesJoinedCellDelegate{
    
    var userId: String?

    var vehiclesRegisteredCollectionView : UICollectionView!
    var communitiesJoinedCollectionView : UICollectionView!
    
    
    let vehiclesRegisteredCellId = "vehiclesRegisteredCellId"
    let communitiesJoinedCellId = "communitiesJoinedCellId"
    
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
        button.setTitle("  Registar a vehicle  ", for: .normal)
        button.layer.cornerRadius = 3
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .darkBlue()
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
        button.layer.cornerRadius = 3
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .darkBlue()
        return button
    }()
    
    @objc func handleJoinCommunity(){
        
        let joinCommunityController = JoinCommunityController()
        let navController = UINavigationController(rootViewController: joinCommunityController)
        
        present(navController, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout1: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let layout2: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

//        var collectionViewHeight: CGFloat = view.frame.height
//        collectionViewHeight = collectionViewHeight - (75 + 80 + 40 + 30)
//        let registerVehicleHeight = (collectionViewHeight/2)
//        let joinCommunityHeight = (collectionViewHeight/2)


        //NotificationCenter.default.addObserver(self, selector: #selector(handleUpdateFeed), name: FullEventController.updateFeedNotificationName, object: nil)
        
        //layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        //layout.itemSize = CGSize(width: 90, height: 120)
        
//        let refreshControl = UIRefreshControl()
//        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        
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
        vehiclesRegisteredCollectionView.anchor(top: sectionHeader1Label.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 200)
        
        //vehiclesRegisteredCollectionView.refreshControl = refreshControl
        
        //------------------------------------------------------------------
        view.addSubview(sectionHeader2Label)
        sectionHeader2Label.anchor(top: vehiclesRegisteredCollectionView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 30)
        //--------------------------------------------

        
        //vehicles registered collection view
        communitiesJoinedCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout2)
        communitiesJoinedCollectionView.dataSource = self
        communitiesJoinedCollectionView.delegate = self
        communitiesJoinedCollectionView.backgroundColor = UIColor.rgb(red: 103, green: 112, blue: 154)
        view.addSubview(communitiesJoinedCollectionView)
        communitiesJoinedCollectionView.anchor(top: sectionHeader2Label.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        //view.backgroundColor = UIColor.lightGray
        view.backgroundColor = UIColor.rgb(red: 103, green: 112, blue: 154)

        vehiclesRegisteredCollectionView.register(VehiclesRegisteredCell.self, forCellWithReuseIdentifier: vehiclesRegisteredCellId)
        communitiesJoinedCollectionView.register(CommunitiesJoinedCell.self, forCellWithReuseIdentifier: communitiesJoinedCellId)
        //communitiesJoinedCollectionView.refreshControl = refreshControl
        
        //----------------------------------------------
        
        //fetchAllPosts()
        
        setupLogOutButton()
        fetchUser()
        
    }
    
    //    func handleUpdateFeed() {
    //        handleRefresh()
    //    }
    
//    @objc func handleRefresh() {
//        print("Handling refresh..")
//        //collectionView?.scrollsToTop = false
//        posts.removeAll()
//        fetchAllPosts()
//    }
//
//
//    fileprivate func fetchAllPosts() {
//        fetchPosts()
//        fetchFollowingUserIds()
//    }
//
//    fileprivate func fetchFollowingUserIds() {
//        guard let uid = FIRAuth.auth()?.currentUser?.uid else { return }
//        FIRDatabase.database().reference().child("following").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
//
//            guard let userIdsDictionary = snapshot.value as? [String: Any] else { return }
//
//            userIdsDictionary.forEach({ (key, value) in
//                FIRDatabase.fetchUserWithUID(uid: key, completion: { (user) in
//                    //self.posts.removeAll()
//                    self.fetchPostsWithUser(user: user)
//                })
//            })
//
//        }) { (err) in
//            print("Failed to fetch following user ids:", err)
//        }
//    }
//
//    var posts = [Post]()
//    fileprivate func fetchPosts() {
//        guard let uid = FIRAuth.auth()?.currentUser?.uid else { return }
//
//        FIRDatabase.fetchUserWithUID(uid: uid) { (user) in
//            self.fetchPostsWithUser(user: user)
//        }
//    }
//
//    fileprivate func fetchPostsWithUser(user: User) {
//        let ref = FIRDatabase.database().reference().child("posts").child(user.uid)
//        ref.observeSingleEvent(of: .value, with: { (snapshot) in
//
//            self.collectionViewEvents.refreshControl?.endRefreshing()
//
//            guard let dictionaries = snapshot.value as? [String: Any] else { return }
//
//            dictionaries.forEach({ (key, value) in
//                guard let dictionary = value as? [String: Any] else { return }
//
//                var post = Post(user: user, dictionary: dictionary)
//                post.id = key
//
//                guard let uid = FIRAuth.auth()?.currentUser?.uid else { return }
//                FIRDatabase.database().reference().child("likes").child(key).child(uid).observe(.value, with: { (snapshot) in
//                    print(snapshot)
//
//
//                    if let value = snapshot.value as? Int, value == 1 {
//                        post.hasLiked = true
//                    }
//                    else {
//                        post.hasLiked = false
//                    }
//
//                    self.posts.append(post)
//                    self.posts.sort(by: { (p1, p2) -> Bool in
//                        return p1.creationDate.compare(p2.creationDate) == .orderedDescending
//                    })
//                    self.collectionViewEvents.reloadData()
//
//                }, withCancel: { (err) in
//                    print("Failed to fetch like info for post: ",err)
//                })
//
//            })
//
//        }) { (err) in
//            print("Failed to fetch posts:", err)
//        }
//    }
    
    
   
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
       
        let height: CGFloat = 130
        
        var returnValue = CGSize()
        
        if collectionView == vehiclesRegisteredCollectionView {
            
            returnValue = CGSize(width: view.frame.width, height: height)
            
        } else if collectionView == communitiesJoinedCollectionView {
            returnValue = CGSize(width: view.frame.width, height: height)
        }
        return returnValue
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return posts.count
        var returnValue = Int()
        
        if collectionView == vehiclesRegisteredCollectionView {
            returnValue = 4
            
        } else if collectionView == communitiesJoinedCollectionView {
            returnValue = 1
            
        }
        
        return returnValue
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomePostCell
//        if posts.count > 0 {
//            cell.post = posts[indexPath.item]
//        }
//        cell.delegate = self
//
//        cell.backgroundColor = UIColor.rgb(red: 13, green: 17, blue: 29)
//        return cell
        
        //let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userProfileCellId", for: indexPath) as! UserProfileCell
       

        var cell = UICollectionViewCell()
        
        if collectionView == vehiclesRegisteredCollectionView {
            let cellVehiclesRegisteredCell = collectionView.dequeueReusableCell(withReuseIdentifier: vehiclesRegisteredCellId, for: indexPath) as! VehiclesRegisteredCell
            cell = cellVehiclesRegisteredCell

            cell.backgroundColor = .lightBlue()
            
        } else if collectionView == communitiesJoinedCollectionView {
            let cellCommunitiesJoinedCell = collectionView.dequeueReusableCell(withReuseIdentifier: communitiesJoinedCellId, for: indexPath) as! CommunitiesJoinedCell
            cell = cellCommunitiesJoinedCell
            cell.backgroundColor = .lightBlue()
        }
        return cell

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
    
}


/*
 import UIKit
 import Firebase
 
 class UserProfileController2: UICollectionViewController, UICollectionViewDelegateFlowLayout, UserProfileHeaderDelegate, UserProfileComJoinedHeaderDelegate {
 
 var userId: String?
 
 override func viewDidLoad() {
 super.viewDidLoad()
 
 let titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.rgb(red: 13, green: 17, blue: 29)]
 
 navigationController?.navigationBar.titleTextAttributes = titleTextAttributes
 
 collectionView?.backgroundColor = UIColor.lightGray
 
 collectionView?.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "userProfileHeaderId")
 
 collectionView?.register(UserProfileComJoinedHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "userProfileComJoinedHeaderId")
 
 
 
 
 
 
 collectionView?.register(VehiclesRegisteredCell.self, forCellWithReuseIdentifier: "vehiclesRegisteredCellId")
 collectionView?.register(CommunitiesJoinedCell.self, forCellWithReuseIdentifier: "CommunitiesJoinedCellId")
 
 
 
 setupLogOutButton()
 fetchUser()
 
 
 }
 
 
 
 
 
 //collection view methods
 
 func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
 
 let height: CGFloat = 40
 
 var returnValue = CGSize()
 
 if indexPath.section == 0 {
 
 returnValue = CGSize(width: view.frame.width, height: height)
 
 } else if indexPath.section == 1 {
 returnValue = CGSize(width: view.frame.width, height: height)
 }
 return returnValue
 }
 
 override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
 
 var returnValue = Int()
 
 if section == 0 {
 returnValue = 1
 
 } else if section == 1 {
 returnValue = 2
 
 }
 
 return returnValue
 }
 
 
 
 override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
 
 //let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userProfileCellId", for: indexPath) as! UserProfileCell
 
 
 let cellVehiclesRegistered = collectionView.dequeueReusableCell(withReuseIdentifier: "vehiclesRegisteredCellId", for: indexPath) as! VehiclesRegisteredCell
 let cellCommunitiesJoined = collectionView.dequeueReusableCell(withReuseIdentifier: "CommunitiesJoinedCellId", for: indexPath) as! CommunitiesJoinedCell
 
 let section = indexPath.section
 
 if section == 0 {
 cellVehiclesRegistered.backgroundColor = .lightBlue()
 return cellVehiclesRegistered
 
 }
 
 cellCommunitiesJoined.backgroundColor = .lightBlue()
 return cellCommunitiesJoined
 //        cell.backgroundColor = .lightBlue()
 //        return cell
 
 }
 
 override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
 
 
 let registeredVehicleHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "userProfileHeaderId", for: indexPath) as! UserProfileHeader
 let joinedCommunityHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "userProfileComJoinedHeaderId", for: indexPath) as! UserProfileComJoinedHeader
 
 
 let section = indexPath.section
 
 if section == 0 {
 
 registeredVehicleHeader.backgroundColor = .blueGray()
 
 registeredVehicleHeader.delegate = self
 registeredVehicleHeader.currentUser = self.currentUser
 return registeredVehicleHeader
 
 
 }
 joinedCommunityHeader.backgroundColor = .blueGray()
 joinedCommunityHeader.delegate = self
 joinedCommunityHeader.currentUser = self.currentUser
 
 
 return joinedCommunityHeader
 
 
 }
 
 
 
 func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
 
 //        if section == 0 {
 //            return CGSize(width: view.frame.width, height: 133)
 //        }
 //        else{
 //            return CGSize(width: view.frame.width, height: 53)
 //        }
 
 //var returnValue = CGSize()
 
 if section == 0 {
 
 //            returnValue =  CGSize(width: view.frame.width, height: 148)
 return CGSize(width: view.frame.width, height: 148)
 
 }
 
 return CGSize(width: view.frame.width, height: 53)
 }
 
 
 override func numberOfSections(in collectionView: UICollectionView) -> Int {
 return 2
 }
 
 
 
 //--------------------------------------------------------------------------------------------------------------
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 func showRegisterVehicle() {
 print("showing register vehicle from the controller")
 let registerVehicleController = RegisterVehicleController()
 let navController = UINavigationController(rootViewController: registerVehicleController)
 
 present(navController, animated: true, completion: nil)
 
 }
 
 func showJoinCommunity(){
 
 let joinCommunityController = JoinCommunityController()
 let navController = UINavigationController(rootViewController: joinCommunityController)
 
 present(navController, animated: true, completion: nil)
 
 
 }
 
 var currentUser: User?
 fileprivate func fetchUser() {
 let uid = userId ?? (Auth.auth().currentUser?.uid ?? "")
 
 //guard let uid = FIRAuth.auth()?.currentUser?.uid else { return }
 
 Database.fetchUserWithUID(uid: uid) { (user) in
 self.currentUser = user
 self.navigationItem.title = self.currentUser?.username
 
 
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
 
 }
 */
