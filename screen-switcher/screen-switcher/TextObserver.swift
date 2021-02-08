//
//  TextObserver.swift
//  screen-switcher
//
//  Created by Urvaksh Sherdiwala on 05/02/21.
//

import Foundation

class TextObserver: NSObject {
    @objc var observedText: Text
    var kvoToken: NSKeyValueObservation?
    
    init(object: Text) {
        observedText = object
        super.init()
        kvoToken = observe(
                    \.observedText.text,
                    options: [.old, .new]
                ) { object, change in
                    print("text changed from: \(change.oldValue!), updated to: \(change.newValue!)")
                }
    }

}
