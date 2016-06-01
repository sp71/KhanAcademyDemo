//
//  DownloadImageOperation.h
//  KhanAcademyChallenge
//
//  Created by Satinder Singh on 5/19/16.
//  Copyright © 2016 Satinder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownloadImageOperation : NSOperation

@property (strong, nonatomic) NSData *imageData;
@property (strong, nonatomic) NSURL *imageURL;
@property (strong, nonatomic) NSError *error;

@end
