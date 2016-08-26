//
//  FeedVC.swift
//  Vinter
//
//  Created by Guillermo García on 19/07/16.
//  Copyright © 2016 Vinter. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVFoundation

class FeedVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
   
   @IBOutlet weak var collectionView﹫: UICollectionView! // {didSet {cvWidth = collectionView.frame.width}}
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
   }
   
   
   @IBAction func swipped(sender: UISwipeGestureRecognizer) { self.performSegueWithIdentifier("feedToProfile", sender: self) }
   
// MARK CollectionView DataSource
   
   func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return 10 }
   
   func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
      let cellⓞ = collectionView.dequeueReusableCellWithReuseIdentifier("ThumbnailCell", forIndexPath: indexPath) as! ThumbnailCVCell
      return cellⓞ
   }

   
// CollectionViewLayout Delegate
   
   // Asks the delegate for the size of the specified item’s cell. cvWidth is the global var I created in the collectionView IBOutlet
   // RETURN: The width and height of the specified item. Both values must be greater than 0.
   func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: NSIndexPath) -> CGSize {
      return CGSize(width: collectionView.frame.width / 2.09, height: collectionView.frame.width / 2.09)
   }
   
   // Asks the delegate for the margins to apply to content in the specified section.
   // RETURN: The margins to apply to items in the section.
   func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
      return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
   }
   
   // Asks the delegate for the spacing between successive rows or columns of a section.
   // RETURN: The minimum space (measured in points) to apply between successive lines in a section.
   func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
      return 4
   }
   
   // Asks the delegate for the spacing between successive items in the rows or columns of a section.
   // RETURN: The minimum space (measured in points) to apply between successive items in the lines of a section.
   func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
      return 2
   }
   
   // Asks the delegate for the size of the header view in the specified section.
   // RETURN: The size of the header. If you return a value of size (0, 0), no header is added.
   func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
      return CGSize(width: 0, height: 0)
   }
   
   // Asks the delegate for the size of the footer view in the specified section.
   // RETURN: The size of the footer. If you return a value of size (0, 0), no footer is added.
   func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
      return CGSize(width: 0, height: 0)
   }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
   @IBAction func recButtonTapped(sender: AnyObject) { // Could be UIButton but with AnyObject we can link this ABAction to any UI component
      
//      let imagePickerController = UIImagePickerController() // We are stanciating a new picker controller
//      imagePickerController.delegate = self // Declares that the picker will find the delegate function in this module. The DELEGATE property of the picker view is a pointer to a UIViewController subclass (pointer because classes are reference types)
//      imagePickerController.sourceType = .Camera
//      imagePickerController.mediaTypes = [kUTTypeMovie as String]
//      imagePickerController.allowsEditing = true
//      
//      self.presentViewController(imagePickerController, animated: true, completion: nil) // We are segueing from the current VC to the new one we are presenting (it is not on Storyboard)
////      UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(String)
   }
   
   func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
      
//      let urlⓞ = info[UIImagePickerControllerMediaURL] as! NSURL
      //print(url.relativePath)
//      UISaveVideoAtPathToSavedPhotosAlbum(url.relativePath!, self, #selector(FeedVC.videoSavedCallback), nil)
      self.dismissViewControllerAnimated(true, completion: nil)

   }
   
   func videoSavedCallback() {
      
   }
   
   func imagePickerControllerDidCancel(picker: UIImagePickerController) { self.dismissViewControllerAnimated(true, completion: nil) }
   
   
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
