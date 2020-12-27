//
//  CategoryView.swift
//  MovieLand
//
//  Created by Galih Asmarandaru on 25/12/20.
//

import UIKit

protocol CategoryDelegate: class {
    func handlePopularMovieTapped()
    func handleUpCommingMovieTapped()
    func handleTopRatedMovieTapped()
    func handleNowPlayingMovieTapped()
}

class CategoryViewController: UIViewController {
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    
    weak var delegate: CategoryDelegate?
    
    @IBOutlet weak var slideClose: UIView!
    @IBAction func popularButton(_ sender: Any) {
        print("button popularButton clicked")
        delegate?.handlePopularMovieTapped()
    }
    @IBAction func upcommingButton(_ sender: Any) {
        print("button upcommingButton clicked")
        delegate?.handleUpCommingMovieTapped()
    }
    @IBAction func topRatedButton(_ sender: Any) {
        print("button topRatedButton clicked")
        delegate?.handleTopRatedMovieTapped()
    }
    @IBAction func nowPlayingButton(_ sender: Any) {
        print("button nowPlayingButton clicked")
        delegate?.handleNowPlayingMovieTapped()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
        
        slideClose.roundCorners(.allCorners, radius: 10)
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        guard translation.y >= 0 else { return }
        
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 200)
                }
            }
        }
    }
}
