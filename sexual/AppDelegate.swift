//
//  AppDelegate.swift
//  sexual
//
//  Created by shen on 2025/4/28.
//

import UIKit
import IQKeyboardManagerSwift

//#if DEBUG
//extension UIViewController {
//    @objc func injected() {
//        viewDidLoad()
//    }
//}
//#endif

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//#if DEBUG
//        Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle")?.load()
//        //for tvOS:
//        Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/tvOSInjection.bundle")?.load()
//        //Or for macOS:
//        Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/macOSInjection.bundle")?.load()
//#endif
        
        #if !DEBUG
        sleep(2);
        #endif
        IQKeyboardManager.shared.isEnabled = true
        IQKeyboardManager.shared.resignOnTouchOutside = true
        return true
    }

}

