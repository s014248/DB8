import UIKit
import InputBarAccessoryView
import Firebase
import MessageKit
import FirebaseFirestore
import SDWebImage

class ChatViewController: MessagesViewController, InputBarAccessoryViewDelegate, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
    var receivedString = "empty3"
    var receivedTopic = "bigempty3"
    var currentUser: User = Auth.auth().currentUser!
    
    var user2Name: String?
    var user2ImgUrl: String?
    var user2UID: String?
    
    private var docReference: DocumentReference?
    
    var messages: [Message] = []

//JUSTIN'S VARS & SETUP!!!:
    
    var menuController: MenuController!
    var centerController: UIViewController!
    var isExpanded = false
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation{
        return .slide
    }
    
    override var prefersStatusBarHidden: Bool{
        return isExpanded
    }
    
//
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//JUSTIN'S FUNC CALL!!!:
        configHomeController(stance: receivedString, topic: receivedTopic)
//
        
        print("GUIGUGIGUI")
        if (currentUser.uid=="MsS3bDi1iRXwpDnDOBPctdAdhTx1"){
            user2UID = "Cmy3rjqaFngw3iLS5pYtic0Lb493"
        }
        else{
            user2UID = "MsS3bDi1iRXwpDnDOBPctdAdhTx1"
        }
        
        self.title = user2Name ?? "Chat"

        navigationItem.largeTitleDisplayMode = .never
        maintainPositionOnKeyboardFrameChanged = true
        messageInputBar.inputTextView.tintColor = UIColor.brown
        messageInputBar.sendButton.setTitleColor(UIColor.orange, for: .normal)
        
        messageInputBar.delegate = self
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        /*delete(collection: Firestore.firestore().collection("Chats").document("IcjyOhLDEmCQw9toNNQQ").collection("thread"), batchSize: 500)*/
        loadChat()
        
    }
    func delete(collection: CollectionReference, batchSize: Int = 100) {
    // Limit query to avoid out-of-memory errors on large collections.
    // When deleting a collection guaranteed to fit in memory, batching can be avoided entirely.
        collection.limit(to: batchSize).getDocuments { (docset, error) in
      // An error occurred.
            let docset = docset

            let batch = collection.firestore.batch()
            docset?.documents.forEach { batch.deleteDocument($0.reference) }

            batch.commit {_ in
                self.delete(collection: collection, batchSize: batchSize)
            }
        }
    }
    // MARK: - Custom messages handlers
    
    func createNewChat() {
        let users = [self.currentUser.uid, self.user2UID]
         let data: [String: Any] = [
             "users":users
         ]
         
         let db = Firestore.firestore().collection("Chats")
         db.addDocument(data: data) { (error) in
             if let error = error {
                 print("Unable to create chat! \(error)")
                 return
             } else {
                 self.loadChat()
             }
         }
    }
    
    func loadChat() {
        print("AHUHUHHHUHU")
        //Fetch all the chats which has current user in it
        let db = Firestore.firestore().collection("Chats")
                .whereField("users", arrayContains: Auth.auth().currentUser?.uid ?? "Not Found User 1")
        
        
        db.getDocuments { (chatQuerySnap, error) in
            
            if let error = error {
                print("Error: \(error)")
                return
            } else {
                var xsdfsdf = 0
                //Count the no. of documents returned
                guard let queryCount = chatQuerySnap?.documents.count else {
                    return
                }
                
                if queryCount == 0 {
                    //If documents count is zero that means there is no chat available and we need to create a new instance
                    self.createNewChat()
                }
                else if queryCount >= 1 {
                    //Chat(s) found for currentUser
                    for doc in chatQuerySnap!.documents {
                        //hgh
                        let chat = Chat(dictionary: doc.data())
                        //Get the chat which has user2 id
                        if (chat?.users.contains(self.user2UID!))! {
                            
                            self.docReference = doc.reference
                            //fetch it's thread collection
                             doc.reference.collection("thread")
                                .order(by: "created", descending: false)
                                .addSnapshotListener(includeMetadataChanges: true, listener: { (threadQuery, error) in
                            if let error = error {
                                print("Error: \(error)")
                                return
                            } else {
                                self.messages.removeAll()
                                    for message in threadQuery!.documents {

                                        let msg = Message(dictionary: message.data())
                                        self.messages.append(msg!)
                                        print("Data: \(msg?.content ?? "No message found")")
                                    }
                                self.messagesCollectionView.reloadData()
                                self.messagesCollectionView.scrollToBottom(animated: true)
                            }
                            })
                            return
                        } //end of if
                    } //end of for
                    self.createNewChat()
                } else {
                    print("Let's hope this error never prints!")
                }
            }
        }
    }
    
    
    private func insertNewMessage(_ message: Message) {
        
        messages.append(message)
        messagesCollectionView.reloadData()
        
        DispatchQueue.main.async {
            self.messagesCollectionView.scrollToBottom(animated: true)
        }
    }
    
    private func save(_ message: Message) {
        
        let data: [String: Any] = [
            "content": message.content,
            "created": message.created,
            "id": message.id,
            "senderID": message.senderID,
            "senderName": message.senderName
        ]
        
        docReference?.collection("thread").addDocument(data: data, completion: { (error) in
            
            if let error = error {
                print("Error Sending message: \(error)")
                return
            }
            
            self.messagesCollectionView.scrollToBottom()
            
        })
    }

    // MARK: - InputBarAccessoryViewDelegate
    
            func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {

                let message = Message(id: UUID().uuidString, content: text, created: Timestamp(), senderID: currentUser.uid, senderName: currentUser.displayName!)
                
                  //messages.append(message)
                  insertNewMessage(message)
                  save(message)
    
                  inputBar.inputTextView.text = ""
                  messagesCollectionView.reloadData()
                  messagesCollectionView.scrollToBottom(animated: true)
            }
    
    
    // MARK: - MessagesDataSource
    func currentSender() -> SenderType {
        
        return Sender(id: Auth.auth().currentUser!.uid, displayName: Auth.auth().currentUser?.displayName ?? "Name not found")
        
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        
        return messages[indexPath.section]
        
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        
        if messages.count == 0 {
            print("No messages to display")
            return 0
        } else {
            return messages.count
        }
    }
    
    
    // MARK: - MessagesLayoutDelegate
    
    func avatarSize(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return .zero
    }
    
    // MARK: - MessagesDisplayDelegate
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .blue: .lightGray
    }

    /*func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        
        if message.sender.senderId == currentUser.uid {
            SDWebImageManager.shared.loadImage(with: currentUser.photoURL, options: .highPriority, progress: nil) { (image, data, error, cacheType, isFinished, imageUrl) in
                avatarView.image = image
            }
        } else {
            SDWebImageManager.shared.loadImage(with: URL(string: user2ImgUrl!), options: .highPriority, progress: nil) { (image, data, error, cacheType, isFinished, imageUrl) in
                avatarView.image = image
            }
        }
    }*/

    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {

        let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight: .bottomLeft
        return .bubbleTail(corner, .curved)

    }
    

    
    


//JUSTIN'S METHODS!!!:
    func configHomeController(stance: String, topic: String){
        let homeController = HomeController()
        homeController.delegate = self
        homeController.receivedString = receivedString
        homeController.receivedTopic = receivedTopic
        centerController = UINavigationController(rootViewController: homeController)
        
        view.addSubview(centerController.view)
        addChild(centerController)
        centerController.didMove(toParent: self)
        
    }
    
    func configMenuController(){
        if menuController == nil{
            // add menu controller here
            menuController = MenuController()
            menuController.delegate = self
            view.insertSubview(menuController.view, at: 1)
            addChild(menuController)
            menuController.didMove(toParent: self)
        }
    }
    
    func animatePanel(shouldExpand: Bool, menuOption: MenuOption?){
        
        if shouldExpand{
            // show menu
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {self.centerController.view.frame.origin.x = self.centerController.view.frame.width - 80}, completion: nil)
            
        }
        else{
            // hide menu
            /*UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {}, completion: nil)*/
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {self.centerController.view.frame.origin.x = 0}) { (_) in
                guard let menuOption = menuOption else{return}
                self.didSelectMenuOption(menuOption: menuOption)
            }
            
        }
        
        animateStatusBar()
        
    }
    
    func didSelectMenuOption(menuOption: MenuOption){
        switch menuOption{
        case .Profile:
            print("Show Profile")
        case .Inbox:
            print("Show Inbox")
        case .Exit:
            print("Show Exit")
            let controller = LeaveController()
            present(UINavigationController(rootViewController: controller), animated: true, completion: nil)
        case .Settings:
            print("Show Settings")
            
            
        }
    }
    
    func animateStatusBar(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {self.setNeedsStatusBarAppearanceUpdate()}, completion: nil)
    }
//

}

//JUSTIN'S EXTENSION!!!:
extension ChatViewController: HomeControllerDelegate {
    
    func handleMenuToggle(forMenuOption menuOption: MenuOption?) {
        if !isExpanded{
            configMenuController()
        }
        
        isExpanded = !isExpanded
        animatePanel(shouldExpand: isExpanded, menuOption: menuOption)
    }
}

//
