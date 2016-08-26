//
//  ProfileVC.swift
//  Vinter
//
//  Created by Guillermo García on 19/07/16.
//  Copyright © 2016 Vinter. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVFoundation

class ProfileVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
   
   @IBOutlet weak var profileIV﹫: UIImageView!
   
   override func viewDidLoad() {
      super.viewDidLoad()
   }
   
   override func viewDidAppear(animated: Bool) {
      
      profileIV﹫.layer.borderWidth = 2
      profileIV﹫.layer.borderColor = UIColor.whiteColor().CGColor
      profileIV﹫.layer.cornerRadius = profileIV﹫.frame.width / 2
      profileIV﹫.layer.masksToBounds = true
//      profilePicture.clipsToBounds = false
      profileIV﹫.layer.shadowColor = UIColor.whiteColor().CGColor //UIColor(red: shadowColor, green: shadowColor, blue: shadowColor, alpha: 0.5).CGColor
      profileIV﹫.layer.shadowOpacity = 1
      profileIV﹫.layer.shadowRadius = 5
      profileIV﹫.layer.shadowOffset = CGSize(width: 5, height: 5)
      UIView.animateWithDuration(0.1, animations: { self.profileIV﹫.alpha = 1 } ) // Showing the profile picture. It has the picture alpha set to 0 on the Storyboard
   }
   
   
   @IBAction func swipped(sender: UISwipeGestureRecognizer) {
      navigationController?.popViewControllerAnimated(true)
   }
   

// MARK: CollectionView DataSource
   
   func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return 10 }

   func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
      let cellⓞ = collectionView.dequeueReusableCellWithReuseIdentifier("ThumbnailCell", forIndexPath: indexPath) as! ThumbnailCVCell
      cellⓞ.layer.cornerRadius = cellⓞ.frame.width / 20
      return cellⓞ
   }

   
   
// MARK: CollectionViewLayout Delegate
   
   // Asks the delegate for the size of the specified item’s cell. cvWidth is the global var I created in the collectionView IBOutlet
   // RETURN: The width and height of the specified item. Both values must be greater than 0.
   func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
      return CGSize(width: collectionView.frame.width / 2.09, height: collectionView.frame.width / 2.09)
   }
   
   // Asks the delegate for the margins to apply to content in the specified section.
   // RETURN: The margins to apply to items in the section.
   func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
      return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
   }
   
   // Asks the delegate for the spacing between successive rows or columns of a section.
   // RETURN: The minimum space (measured in points) to apply between successive lines in a section.
   func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
      return 4
   }
   
   // Asks the delegate for the spacing between successive items in the rows or columns of a section.
   // RETURN: The minimum space (measured in points) to apply between successive items in the lines of a section.
   func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
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
   

// MARK ViewController LifeCycle
   
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
   

   
   
   
   /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
   
}
