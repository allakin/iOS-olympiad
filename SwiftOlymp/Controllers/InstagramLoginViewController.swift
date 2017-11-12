//
//  InstagramLoginViewController.swift
//  SwiftOlymp
//
//  Created by BLVCK on 12/11/2017.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import UIKit
import WebKit

class InstagramLoginViewController: UIViewController {

    
    @IBOutlet weak var webView: UIWebView!
    
    fileprivate let INSTAGRAM_AUTHURL = "https://api.instagram.com/oauth/authorize/"
    
    fileprivate let INSTAGRAM_CLIENT_ID = "db6b398886db419c80ebe28ed0c05cf5"
    
    fileprivate let INSTAGRAM_CLIENTSERCRET = "f06df012d32f4cfcb2248dab93de638c"
    
     let INSTAGRAM_REDIRECT_URI = "https://adlivetech.com/"
    
    fileprivate let INSTAGRAM_ACCESS_TOKEN = "access_token"
    
    fileprivate let INSTAGRAM_SCOPE = "follower_list+public_content"
    
    let instagramLoginSegueIdentifier = "instagramLoginSeque"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let authURL = String(format: "%@?client_id=%@&redirect_uri=%@&response_type=token&scope=%@&DEBUG=True", arguments: [INSTAGRAM_AUTHURL,INSTAGRAM_CLIENT_ID,INSTAGRAM_REDIRECT_URI, INSTAGRAM_SCOPE])
        let urlRequest = URLRequest.init(url: URL.init(string: authURL)!)
        webView.delegate = self
        webView.loadRequest(urlRequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension InstagramLoginViewController: UIWebViewDelegate{
    func webView(_ webView: UIWebView, shouldStartLoadWith request:URLRequest, navigationType: UIWebViewNavigationType) -> Bool{
        return checkRequestForCallbackURL(request: request)
    }
    
    func checkRequestForCallbackURL(request: URLRequest) -> Bool {
        let requestURLString = (request.url?.absoluteString)! as String
        if requestURLString.hasPrefix("https://adlivetech.com/") {
            let range: Range<String.Index> = requestURLString.range(of: "#access_token=")!
            handleAuth(authToken: requestURLString.substring(from: range.upperBound))
            return false;
        }
        return true
    }
    func handleAuth(authToken: String) {
        print("Instagram authentication token ==", authToken)
        UserDefaults.standard.set(authToken, forKey: "InstagramToken")
        navigationController?.popToRootViewController(animated: true)
    }
}
