//
//  CamProfileScrollVCswift
//  Vinter
//
//  Created by Guillermo García on 08/08/16.
//  Copyright © 2016 Vinter. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
   
   @IBOutlet weak var scrollView﹫: UIScrollView!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      // Do any additional setup after loading the view.
   }
   
   override func viewWillAppear(animated: Bool) {
      super.viewWillAppear(animated)
      edgesForExtendedLayout = UIRectEdge()
   }
   
   override func viewDidAppear(animated: Bool) {
      super.viewDidAppear(animated)
      scrollView﹫.contentSize = CGSize(width: view.frame.size.width * 2, height: view.frame.size.height)
      let camViewControllerⓄ = storyboard!.instantiateViewControllerWithIdentifier("camera") as! CameraVC
         addChildViewController(camViewControllerⓄ)
         scrollView﹫.addSubview(camViewControllerⓄ.view)
      let profileViewControllerⓄ = storyboard!.instantiateViewControllerWithIdentifier("profile") as! ProfileVC
         profileViewControllerⓄ.view.setFrame(xⓖ: view.frame.width, yⓖ: 0)
         addChildViewController(profileViewControllerⓄ)
         scrollView﹫.addSubview(profileViewControllerⓄ.view)
         profileViewControllerⓄ.view.layoutSubviews()
   }
   
   
   // MARK: ViewController LifeCycle
   
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
