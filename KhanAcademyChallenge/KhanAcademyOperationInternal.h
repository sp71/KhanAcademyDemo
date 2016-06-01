//
//  KhanAcademyOperationInternal.h
//  KhanAcademyChallenge
//
//  Created by Sahel Jalal on 5/29/16.
//  Copyright © 2016 Satinder. All rights reserved.
//

#ifndef KhanAcademyOperationInternal_h
#define KhanAcademyOperationInternal_h

#import "KhanAcademyOperation.h"

@interface KhanAcademyOperation () {
@protected
    NSURLRequest *_request;
    NSURLSession *_session;
    NSError *_error;
}

@property (strong, nonatomic) NSURLRequest *request;
@property (strong, nonatomic) NSURLSession *session;
@property (strong, nonatomic) NSError *error;

- (void)parseWithJSON:(NSArray *)json;

@end

#endif /* KhanAcademyOperationInternal_h */
