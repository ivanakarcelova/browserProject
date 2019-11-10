//
//  WebViewController.swift
//  browserProject
//
//  Created by Ivana Karcelova on 10/21/19.
//  Copyright © 2019 Ivana Karcelova. All rights reserved.
//

//************************************************************************************************************\\
/*
 Goals with this project:
 - if the url is correct, go to that website --> "https://www.youtube.com/" (send it to youtube)
        -- make this work for frequent websites (including facebook, instagram,
- if the searchbar has "prep", "rutgers prep" rutgersprep.org --> go to "http://www.rutgersprep.org/"
 - if the searchbar has ivanakarcelova.com --> go to "http://ivanakarcelova.com"
 - IF ANYTHING ELSE THAT IS NO COHERENT (.orgrutgersprep.www , emojis, unfinished sentences) --> SEND TO GOOGLE
 *
*/
//************************************************************************************************************\\


import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate, WKUIDelegate, UISearchBarDelegate
{

    @IBOutlet var webView: WKWebView!
    @IBOutlet var addressBar: UISearchBar!
    @IBOutlet weak var reload: UIButton!

    let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    
    let screenSize = UIScreen.main.bounds

    private func setDelegates()
    {
        self.webView.navigationDelegate = self
        self.addressBar.delegate = self
    }
    
   private func createCustonWebView()
   {
    let webConfiguration = WKWebViewConfiguration()
    self.webView = WKWebView(frame: .zero, configuration: webConfiguration)
    let webViewHeight = self.screenSize.height * 0.90
        self.webView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.webView)
    self.webView.allowsBackForwardNavigationGestures = true
    
    NSLayoutConstraint.activate([
        
        self.webView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
        
        self.webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        
        self.webView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
        
        self.webView.heightAnchor.constraint(equalToConstant: webViewHeight),
    ])
    
    let heightOffset = self.screenSize.height * 0.05
    self.addressBar = UISearchBar(frame: CGRect(x: 0, y: heightOffset , width: self.screenSize.width, height: 30))
    self.addressBar.keyboardType = .URL
    
    self.webView.addSubview(self.activityIndicator)
    self.view.addSubview(self.addressBar)
    self.setDelegates()

    
    
    }
    
    private func createActivityIndicator()
    {
        self.activityIndicator.transform = CGAffineTransform(scaleX: 2.5, y: 2.5)
        // sets up activityIndicator by giving it a size and some scale
        
        self.view.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: self.screenSize.height)
        self.webView.frame = self.view.frame
        
        self.activityIndicator.center = super.view.center
        self.activityIndicator.color = .red
        
        self.webView.addSubview(self.activityIndicator)
       self.activityIndicator.startAnimating()
        
    }
    private func startAnimation()
    {
        self.activityIndicator.startAnimating()
    }
    private func stopAnimation()
    {
        self.activityIndicator.stopAnimating()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //step one: make the url
        let myURL = URL(string: "https://www.google.com")
        
        //step two: make the request
        let request = URLRequest(url: myURL!)
        
        //step three: load the request
        self.webView.load(request)
       self.createActivityIndicator()

    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //start animation
        self.activityIndicator.startAnimating()
        //look for web address - model
        //load site or search google
        guard let urlString = self.addressBar.text
        else
        {
            return
        }
        
        let validator = URLValidator(urlString: urlString)
        let url = validator.getCorrectURL()
        let request = URLRequest(url: url)
        self.webView.load(request)
        //stop animation -> we can't stop it here
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation)
    {
        //finishing loading
        //stop animation
        self.stopAnimation()
       // self.removeActivityIndicator()
       // self.hideAddressBar()
            //when you swipe down, it goes away...
    }
    
    //refresh page
   

}
