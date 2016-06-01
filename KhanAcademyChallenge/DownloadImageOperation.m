//
//  DownloadImageOperation.m
//  KhanAcademyChallenge
//
//  Created by Satinder Singh on 5/19/16.
//  Copyright © 2016 Satinder. All rights reserved.
//

#import "DownloadImageOperation.h"

#define kDOWNLOAD_IMAGE_OPERATION_DOMAIN_ERROR @"khan.academy.operation.Image"

@implementation DownloadImageOperation

#pragma mark - Helper Methods
- (void)downloadImage {
    self.imageData = [NSData dataWithContentsOfURL:self.imageURL];
    if ([self.imageData length] == 0) {
        self.error = [NSError errorWithDomain:kDOWNLOAD_IMAGE_OPERATION_DOMAIN_ERROR
                                         code:kCFURLErrorZeroByteResource
                                     userInfo:@{ NSLocalizedDescriptionKey : @"Issue Downloading Image" }];
    }
}

#pragma mark - Init
- (void)main {
    [self downloadImage];
}

@end
