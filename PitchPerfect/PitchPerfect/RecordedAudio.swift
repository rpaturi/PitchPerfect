//
//  RecordedAudio.swift
//  PitchPerfect
//
//  Created by Rachel Paturi on 11/29/15.
//  Copyright © 2015 Rachel Paturi. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
    var filePathUrl: NSURL!
    var title: String!
    
    init(filePathUrl: NSURL, title: String) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
}


