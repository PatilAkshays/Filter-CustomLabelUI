//
//  ViewController.swift
//  FilterUI
//
//  Created by Treel Mobility  on 16/05/19.
//  Copyright © 2019 Treel Mobility . All rights reserved.
//

import UIKit


class ViewController: UIViewController,UIScrollViewDelegate {
    @IBOutlet weak var iView: UIView!
    
    @IBOutlet weak var scrollV: UIScrollView!
    var dataArr : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataArr = ["String","Number","Integer","Character","Float","Class","Child","Object","Design Pattern","View","Models","Projects","Rating","Performance","String","Number","Integer","Character","Float","Class","Child","Object","Design Pattern","View","Models","Projects","Rating","Performance"]
        createFilterUIProgramatically()
        
    }
    
    func createFilterUIProgramatically() -> Void {
        self.iView.removeFromSuperview() //Remove iView from scrollview
        var xPos = 10   //initially xPosition will be 10
        var yPos = 0    //initially yPosition will be 0

        for i in 0..<dataArr.count {
            let labelNum = UILabel()
            let buttonCross = UIButton()
            
            let num1Nnum2 = dataArr[i]
            //label initialization and set soime properties
            labelNum.text = "   " + num1Nnum2 + "_\(i)"
            let col1 = UIColor(red: 61/255, green: 165/255, blue: 232/255, alpha: 1)
            labelNum.backgroundColor = col1
            labelNum.textColor = .white
            labelNum.layer.cornerRadius = 20
            labelNum.clipsToBounds = true
            labelNum.sizeToFit();
            labelNum.textAlignment = .left
            labelNum.numberOfLines = 0
            labelNum.borderWidth = 2
            labelNum.borderColor = .darkGray
            //label width + 40 for button h & w
            labelNum.frame = CGRect( x:xPos, y:yPos, width:Int(labelNum.frame.width + 40), height: 40)
            
            //button initialization and set soime properties
            buttonCross.frame = CGRect( x:Int(labelNum.frame.origin.x + labelNum.frame.width - 40), y:Int(labelNum.frame.origin.y + 2 + labelNum.frame.height - 40), width:36, height: 36)  //3
            buttonCross.setTitle("X", for: .normal);
            buttonCross.backgroundColor = .red
            buttonCross.borderWidth = 2
            buttonCross.borderColor = .white
            buttonCross.layer.cornerRadius = 18
            buttonCross.clipsToBounds = true
            
            //Calculate self.view width
            let viewW : Int = Int(self.view.frame.origin.x + self.view.frame.size.width)
            //Calculate xPosition, is current label will be set on horizantally
            let labelNumWidth : Int = (Int(xPos) + Int(labelNum.frame.width + 20))
            if (viewW > labelNumWidth){
                xPos += Int(labelNum.frame.width + 10) + 10
            }else{
                //first label is big then it will not going to next line
                if i != 0 {
                    yPos += 50  //1
                }
                
                xPos = 10   //2 //start next line with xPosition will be 10
                //reinitializing label and button position
                labelNum.frame = CGRect( x:xPos, y:yPos, width:Int(labelNum.frame.width + 40), height: 40)  //3
                buttonCross.frame = CGRect( x:Int(labelNum.frame.origin.x + labelNum.frame.width - 40), y:Int(labelNum.frame.origin.y + 2 + labelNum.frame.height - 40),width:36, height: 36)  //3
                //update xPosition for next label
                xPos += Int(labelNum.frame.width + 10) + 10  //4
                
                
                //condition calculation, if text is too long then it will be shows ...
                let labelNumWidth1 : Int = Int(labelNum.frame.width + 20)
                if (viewW < labelNumWidth1){
                    labelNum.frame.size.width =  self.iView.frame.width - 20
                    buttonCross.frame = CGRect( x:Int(labelNum.frame.origin.x + labelNum.frame.size.width - 40), y:Int(labelNum.frame.origin.y + 2 + labelNum.frame.height - 40),width:36, height: 36) //3
                }
                
            }
            
            
            //Cross button Action
            buttonCross.addTarget(self, action: #selector(handleTap(_:)), for: .touchUpInside)
            //Assign Tag
            buttonCross.tag = i;
            labelNum.tag = i
            //Add label and button to iView
            self.iView.addSubview(labelNum)
            self.iView.addSubview(buttonCross)
            
        }
        //Update scroll view content size as well as iView height
        scrollV.contentSize.height = CGFloat(yPos + 100)
        self.iView.frame = CGRect( x:self.iView.frame.origin.x, y:self.iView.frame.origin.y,width:self.iView.frame.size.width, height: scrollV.contentSize.height + 50)
        //Add iView to Scrollview
        scrollV.addSubview(self.iView);
        self.iView.isUserInteractionEnabled = true
        
    }
    //Remove all subview from iView without animation
    func removeFilterUIProgramatically(withTag : Int) -> Void {
        for viewLB in iView.subviews{
            viewLB.removeFromSuperview()
        }
    }
    
    //Remove selected subview from iView with animation
    func removeSelectedFilterUIProgramatically(withTag : Int) -> Void {
        
        for viewLB in iView.subviews{
            if viewLB.tag == withTag {
                UIView.animate(withDuration: 0.2, animations: {viewLB.alpha = 0.0},
                               completion: {(value: Bool) in
                                viewLB.removeFromSuperview()
                })
            }
        }
    }
    //Action
    @objc func handleTap(_ sender: UIButton) {
        dataArr.remove(at: sender.tag)
        removeSelectedFilterUIProgramatically(withTag: sender.tag)
        
        Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(removeAllSubviewFromIView), userInfo: nil, repeats: false)
    
        
    }

    @objc func removeAllSubviewFromIView() {
        self.removeFilterUIProgramatically(withTag: 0)
        self.createFilterUIProgramatically()
    }
    
    override func viewDidLayoutSubviews() {
        //        scrollV.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.bounds.height)
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}


//@K
extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    
    //    @IBInspectable var position: String {
    //        get {
    //            return layer.cornerRadius
    //        }
    //        set {
    //            layer.cornerRadius = newValue
    //            layer.masksToBounds = newValue > 0
    //        }
    //    }
    
}


