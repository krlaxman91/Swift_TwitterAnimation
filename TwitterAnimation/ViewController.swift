//
//  ViewController.swift
//  TwitterAnimation
//
//  Created by Laxman on 01/06/15.
//  Copyright (c) 2015 mac. All rights reserved.
//

import UIKit


let offset_HeaderStop:CGFloat = 40.0
let offset_B_LabelHeader:CGFloat = 95.0
let distance_W_LabelHeader:CGFloat = 35.0



class ViewController: UIViewController , UIScrollViewDelegate {

    
    @IBOutlet var header: UIView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var headerLabel: UILabel!
    

    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var headerImageView:UIImageView!
    @IBOutlet var headerBlurImageView:UIImageView!
    var blurredHeaderImageView:UIImageView?
    
    
    @IBOutlet var followButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        
        makeUIOfAnimation()
    }

    func makeUIOfAnimation()
    {
    header.backgroundColor = UIColor(red: 0, green: 0.518, blue: 0.706, alpha: 1)
        followButton.layer.cornerRadius = 5
        followButton.layer.borderWidth = 1
        followButton.layer.borderColor = UIColor.blueColor().CGColor
        imageView.layer.cornerRadius = 8
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor=UIColor.whiteColor().CGColor
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        
        var offset = scrollView.contentOffset.y
        var avatarTransform = CATransform3DIdentity
        var headerTransform = CATransform3DIdentity
        
        //  for pulling down view
        
        if offset < 0 {
            
            let headerScaleFactor:CGFloat = -(offset) / header.bounds.height
            let headerSizevariation = ((header.bounds.height * (1.0 + headerScaleFactor)) - header.bounds.height)/2.0
            headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0)
            headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
            
            header.layer.transform = headerTransform
        }
            
            // scroll up/down
            
        else {
            
            // for header
            headerTransform = CATransform3DTranslate(headerTransform, 0, max(-offset_HeaderStop, -offset), 0)
            // for label
            
            let labelTransform = CATransform3DMakeTranslation(0, max(-distance_W_LabelHeader, offset_B_LabelHeader - offset), 0)
            headerLabel.layer.transform = labelTransform
            
            //  header blur effect
            
            headerBlurImageView?.alpha = min (1.0, (offset - offset_B_LabelHeader)/distance_W_LabelHeader)
            //for imageview
            let avatarScaleFactor = (min(offset_HeaderStop, offset)) / imageView.bounds.height / 1.4
            let avatarSizeVariation = ((imageView.bounds.height * (1.0 + avatarScaleFactor)) - imageView.bounds.height) / 2.0
            avatarTransform = CATransform3DTranslate(avatarTransform, 0, avatarSizeVariation, 0)
            avatarTransform = CATransform3DScale(avatarTransform, 1.0 - avatarScaleFactor, 1.0 - avatarScaleFactor, 0)
            
            if offset <= offset_HeaderStop {
                
                if imageView.layer.zPosition < header.layer.zPosition{
                    header.layer.zPosition = 0
                }
                
            }else {
                if imageView.layer.zPosition >= header.layer.zPosition{
                    header.layer.zPosition = 2
                }
            }
        }
        // add Transformations
        header.layer.transform = headerTransform
        imageView.layer.transform = avatarTransform
    }

}

