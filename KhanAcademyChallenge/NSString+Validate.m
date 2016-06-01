//
//  NSString+Validate.m
//  KhanAcademyChallenge
//
//  Created by Satinder Singh on 5/23/16.
//  Copyright © 2016 Satinder. All rights reserved.
//

#import "NSString+Validate.h"

@implementation NSString (Validate)

- (BOOL)isValidString {
    return [self length] > 0 && ![self isEqualToString:@"???"];
}

@end
