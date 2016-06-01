//
//  BadgeInternal.h
//  KhanAcademyChallenge
//
//  Created by Sahel Jalal on 5/29/16.
//  Copyright © 2016 Satinder. All rights reserved.
//

#ifndef BadgeInternal_h
#define BadgeInternal_h

#import "Badge.h"

@interface Badge ()

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *slug;
@property (strong, nonatomic) NSNumber *points;
@property (strong, nonatomic) NSURL *compactIconURL;
@property (strong, nonatomic) NSURL *largeIconURL;
@property (strong, nonatomic) NSURL *absoluteURL;
@property (strong, nonatomic) NSString *safeExtendedInformation;
@property (strong, nonatomic) NSString *information;

@end


#endif /* BadgeInternal_h */
