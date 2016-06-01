//
//  KhanAcademyOperation.h
//  KhanAcademyChallenge
//
//  Created by Satinder Singh on 5/20/16.
//  Copyright © 2016 Satinder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KhanAcademyOperation : NSOperation

- (instancetype)initWithPath:(NSString *)path queryItems:(NSArray<NSURLQueryItem *> *)queryItems;

/*!
 @method        serializeFromResponse:
 
 @abstract      Initializes a JSON object with the given data.
 
 @discussion    Error check response status code, error, and data from REST call.
                Information regarding error found within class error property
 @result        Initalized id from data; otherwise, nil if any error occurs
 */
- (id)serializeFromResponse:(NSURLResponse *)response error:(NSError **)error data:(NSData *)data;

@end
