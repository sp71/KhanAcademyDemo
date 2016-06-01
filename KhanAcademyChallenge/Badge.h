//
//  Badge.h
//  KhanAcademyChallenge
//
//  Created by Satinder Singh on 5/17/16.
//  Copyright © 2016 Satinder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Category.h"

@interface Badge : NSObject

@property (readonly, strong, nonatomic) NSString *name;
@property (readonly, strong, nonatomic) NSString *slug;
@property (readonly, strong, nonatomic) NSNumber *points;
@property (strong, nonatomic) UIImage *photo;
@property (readonly, strong, nonatomic) NSURL *compactIconURL;
@property (readonly, strong, nonatomic) NSURL *largeIconURL;
@property (readonly, strong, nonatomic) NSURL *absoluteURL;
@property (readonly, strong, nonatomic) NSString *safeExtendedInformation;
@property (readonly, strong, nonatomic) NSString *information;
@property (strong, nonatomic) Category *category;

@end
