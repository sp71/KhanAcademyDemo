//
//  NSString+Validate.h
//  KhanAcademyChallenge
//
//  Created by Satinder Singh on 5/23/16.
//  Copyright © 2016 Satinder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Validate)

/*! Returns false if string is @"???" or length = 0 */
- (BOOL)isValidString;

@end
