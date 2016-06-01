//
//  KhanAcademyDownloadBadgeOperation.h
//  KhanAcademyChallenge
//
//  Created by Satinder Singh on 5/17/16.
//  Copyright © 2016 Satinder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KhanAcademyOperation.h"

@interface KhanAcademyDownloadBadgeOperation : KhanAcademyOperation

/*! @abstract   List of badge objects from server */
@property (strong, nonatomic) NSArray *badgeList;

@end
