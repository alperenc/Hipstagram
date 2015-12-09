//
//  DetailViewController.swift
//  Hipstagram
//
//  Created by Alp Eren Can on 09/12/15.
//  Copyright © 2015 Hipo. All rights reserved.
//

import UIKit

import PureLayout

class DetailViewController: UIViewController, UIScrollViewDelegate {
    
    var imageData: NSData!
    
    var scrollView: UIScrollView!
    var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
        
        scrollView = UIScrollView(frame: view.frame)
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 4.0
        scrollView.delegate = self
        
        view.addSubview(scrollView)
        
        imageView = UIImageView(frame: CGRectMake(0, 0, view.bounds.width, view.bounds.width))
        imageView.contentMode = .ScaleAspectFit
        imageView.image = UIImage(data: imageData)
        
        scrollView.addSubview(imageView)
        
        imageView.autoPinEdgesToSuperviewEdges()
        imageView.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
        imageView.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
    }
    
    // MARK: - Scroll view delegate
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }

}
