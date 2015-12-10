//
//  ViewController.swift
//  AirBNB-paralax
//
//  Created by Sebastian Drew on 11/23/15.
//  Copyright © 2015 los. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageImage: UIImageView!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var imageBlurView: UIVisualEffectView!
    
    @IBOutlet weak var contentView: UIView!
    
    var scale = CGFloat(1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        imageBlurView.alpha = 0
        photoImage.transform = CGAffineTransformMakeScale(scale, scale)
        
       scrollView.contentSize = CGSize(width: 375, height: 4018)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // This method is called as the user scrolls
        let currentOffset = scrollView.contentOffset.y
        
        let finalOffset =  scrollView.contentSize.height - scrollView.frame.height
        
        print("Current Offset \(currentOffset) Final Offset \(finalOffset)")
        
        if currentOffset <  0 {
            
        let scale = convertValue(currentOffset, r1Min: 0, r1Max: -275, r2Min: 1.0, r2Max: 2.5)
        let fadeAlpha = convertValue(currentOffset, r1Min: 0, r1Max: -15, r2Min: 1, r2Max: 0)
        
        
        photoImage.transform = CGAffineTransformMakeScale(scale, scale)
        heartButton.alpha = fadeAlpha
        imageBlurView.alpha = 0
        }
        
        if currentOffset > 0 {
            
            // let scale = convertValue(currentOffset, r1Min: 0, r1Max: 375, r2Min: 1.0, r2Max: 2.5)
            let xPosition = convertValue(currentOffset, r1Min: 0, r1Max: 375, r2Min: 0, r2Max: 0)
            let yPosition = convertValue(currentOffset, r1Min: 0, r1Max: 375, r2Min: 0, r2Max: 200)
            let blurAlpha = convertValue(currentOffset, r1Min: 0, r1Max: 210, r2Min: 0, r2Max: 1)
            
            photoImage.transform = CGAffineTransformMakeTranslation(xPosition, yPosition)
            imageBlurView.transform = CGAffineTransformMakeTranslation(xPosition, yPosition)
           // photoImage.transform = CGAffineTransformMakeScale(scale, scale)
            imageBlurView.alpha = blurAlpha
        }
        
        
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView,
        willDecelerate decelerate: Bool) {
            // This method is called right as the user lifts their finger
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        // This method is called when the scrollview finally stops scrolling.
    }

    

    func convertValue(value: CGFloat, r1Min: CGFloat, r1Max: CGFloat, r2Min: CGFloat, r2Max: CGFloat) -> CGFloat {
        let ratio = (r2Max - r2Min) / (r1Max - r1Min)
        return value * ratio + r2Min - r1Min * ratio
    }

}

