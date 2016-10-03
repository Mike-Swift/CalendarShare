//
//  MessagesViewController.swift
//  MessagesExtension
//
//  Created by Mike Derr on 10/2/16.
//  Copyright © 2016 Mike Derr. All rights reserved.
//
// https://medium.com/lost-bananas/building-an-interactive-imessage-application-for-ios-10-in-swift-7da4a18bdeed#.egwa05wi2
//
//table example
// https://www.captechconsulting.com/blogs/ios-10-imessages-sdk-creating-an-imessages-extension
//

import UIKit
import Messages

class CompactViewController: UIViewController {
    // ...
}

class ExpandedViewController: UIViewController {
    // ...
}

class MessagesViewController: MSMessagesAppViewController {   //UIViewController
    
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var tableView: UITableView!
    
    
    let array: [String] = ["Event1 title", "Event2 title", "Event3 title", "Event4 title", "Event5 title", "Event6 title",]

    
    @IBAction func buttonCreateMessage(_ sender: AnyObject) {
        
        
        
        if let conversation = activeConversation {
        //if let image = createImageForMessage(), let conversation = activeConversation {

            let layout = MSMessageTemplateLayout()
           // layout.image = image
            layout.caption = "My Event to share with you 😃"
            
            var components = URLComponents()
            let queryItem = URLQueryItem(name: "key", value: "value")
            components.queryItems = [queryItem]
            
            let message = MSMessage()
            message.layout = layout
            message.url = URL(string: "emptyURL")
            message.url = components.url
            message.summaryText = "Sent Hello World message"
            
            conversation.insert(message, completionHandler: { (error: Error?) in
                print(error)
            })
        }
        
        
    }
  /*
    @IBAction func tapButton() {
        activeConversation?.insertText("Your text here", completionHandler: nil)
    }
   */
    
    // Messages.framework
    public class MSMessageTemplateLayout : MSMessageLayout {
        public var caption: String?
        public var subcaption: String?
        public var trailingCaption: String?
        public var trailingSubcaption: String?
        public var image: UIImage?
        public var mediaFileURL: URL?
        public var imageTitle: String?
        public var imageSubtitle: String?
    }
    
    func createImageForMessage() -> UIImage? {
        let background = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        background.backgroundColor = UIColor.white
        
        let label = UILabel(frame: CGRect(x: 75, y: 75, width: 150, height: 150))
        label.font = UIFont.systemFont(ofSize: 56.0)
        label.backgroundColor = UIColor.red
        label.textColor = UIColor.white
        label.text = "\(Int(stepper.value))"
        label.textAlignment = .center
        label.layer.cornerRadius = label.frame.size.width/2.0
        label.clipsToBounds = true
        
        background.addSubview(label)
        background.frame.origin = CGPoint(x: view.frame.size.width, y: view.frame.size.height)
        view.addSubview(background)
        
        UIGraphicsBeginImageContextWithOptions(background.frame.size, false, UIScreen.main.scale)
        background.drawHierarchy(in: background.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        background.removeFromSuperview()
        
        return image
    }
    
 
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1    // was 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return array.count
    }
    
    //===== cellForRowAtIndexPath ================================================
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identifier = "tableViewCellIdentifier"
        let cell = tableView.dequeueReusableCell( withIdentifier: identifier, for: indexPath as IndexPath) as! TableViewCell
        
        let item = array[indexPath.row]

        
        cell.labelTitle.text = item

        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let selectedEvent = array[indexPath.row]
        /*
        let controller = EKEventEditViewController()
        controller.event = selectedEvent
        controller.editViewDelegate = self
        controller.eventStore = database
        self.presentViewController(controller, animated: true, completion: nil)
 */
    }
    

    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Conversation Handling
    
    override func willBecomeActive(with conversation: MSConversation) {
        // Called when the extension is about to move from the inactive to active state.
        // This will happen when the extension is about to present UI.
        
        // Use this method to configure the extension and restore previously stored state.
    }
    
    override func didResignActive(with conversation: MSConversation) {
        // Called when the extension is about to move from the active to inactive state.
        // This will happen when the user dissmises the extension, changes to a different
        // conversation or quits Messages.
        
        // Use this method to release shared resources, save user data, invalidate timers,
        // and store enough state information to restore your extension to its current state
        // in case it is terminated later.
    }
    
    override func didReceive(_ message: MSMessage, conversation: MSConversation) {
        // Called when a message arrives that was generated by another instance of this
        // extension on a remote device.
        
        // Use this method to trigger UI updates in response to the message.
    }
    
    override func didStartSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user taps the send button.
    }
    
    override func didCancelSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user deletes the message without sending it.
        
        // Use this to clean up state related to the deleted message.
    }
    
    override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Called before the extension transitions to a new presentation style.
        
        // Use this method to prepare for the change in presentation style.
    }
    
    override func didTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Called after the extension transitions to a new presentation style.
        
        // Use this method to finalize any behaviors associated with the change in presentation style.
    }
    
}
/*
extension MessagesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
}

*/

/*
    private func composeMessage() {
        let conversation = activeConversation
        let session = conversation?.selectedMessage?.session ?? MSSession()
        
        let layout = MSMessageTemplateLayout()
        layout.image = UIImage(named: "message-background.png")
        layout.imageTitle = "iMessage Extension"
        layout.caption = "Hello world!"
        layout.subcaption = "Sent by /(conversation?.localParticipantIdentifier)"
        
        var components = URLComponents()
        let queryItem = URLQueryItem(name: "key", value: "value")
        components.queryItems = [queryItem]
        
        let message = MSMessage(session: session)
        message.layout = layout
        message.url = components.url
        message.summaryText = "Sent Hello World message"
        
        conversation?.insert(message)
    }

    private func isSenderSameAsRecipient() -> Bool {
        guard let conversation = activeConversation else { return false }
        guard let message = conversation.selectedMessage else { return false }
        
        return message.senderParticipantIdentifier == conversation.localParticipantIdentifier
    }

    
    
    override func willBecomeActive(with conversation: MSConversation) {
        super.willBecomeActive(with: conversation)
        
        presentVC(for: conversation, with: presentationStyle)
    }
    
    override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        guard let conversation = activeConversation else {
            fatalError("Expected the active conversation")
        }
        
        presentVC(for: conversation, with: presentationStyle)
    }
    
    private func presentVC(for conversation: MSConversation, with presentationStyle: MSMessagesAppPresentationStyle) {
        let controller: UIViewController
        
        if presentationStyle == .compact {
            controller = instantiateCompactVC()
        } else {
            controller = instantiateExpandedVC()
        }
        
        addChildViewController(controller)
        
        // ...constraints and view setup...
        
        view.addSubview(controller.view)
        controller.didMove(toParentViewController: self)
    }
    
    private func instantiateCompactVC() -> UIViewController {
        guard let compactVC = storyboard?.instantiateViewController(withIdentifier: "CompactVC") as? CompactViewController else {
            fatalError("Can't instantiate CompactViewController")
        }
        
        return compactVC
    }
    
    private func instantiateExpandedVC() -> UIViewController {
        guard let expandedVC = storyboard?.instantiateViewController(withIdentifier: "ExpandedVC") as? ExpandedViewController else {
            fatalError("Can't instantiate ExpandedViewController")
        }
        
        return expandedVC
    }

    
    // MARK: - Conversation Handling
/*
    override func willBecomeActive(with conversation: MSConversation) {
        // Called when the extension is about to move from the inactive to active state.
        // This will happen when the extension is about to present UI.
        
        // Use this method to configure the extension and restore previously stored state.
        
        presentVC(for: conversation, with: presentationStyle)

    }
*/
    override func didResignActive(with conversation: MSConversation) {
        // Called when the extension is about to move from the active to inactive state.
        // This will happen when the user dissmises the extension, changes to a different
        // conversation or quits Messages.
        
        // Use this method to release shared resources, save user data, invalidate timers,
        // and store enough state information to restore your extension to its current state
        // in case it is terminated later.
    }
   
    override func didReceive(_ message: MSMessage, conversation: MSConversation) {
        // Called when a message arrives that was generated by another instance of this
        // extension on a remote device.
        
        // Use this method to trigger UI updates in response to the message.
    }
    
    override func didStartSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user taps the send button.
    }
    
    override func didCancelSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user deletes the message without sending it.
    
        // Use this to clean up state related to the deleted message.
    }
/*
    override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Called before the extension transitions to a new presentation style.
    
        // Use this method to prepare for the change in presentation style.
    }
*/
    override func didTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Called after the extension transitions to a new presentation style.
    
        // Use this method to finalize any behaviors associated with the change in presentation style.
    }

}
 
*/
