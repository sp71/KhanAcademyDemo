//
//  Category.h
//  KhanAcademyChallenge
//
//  Created by Satinder Singh on 5/20/16.
//  Copyright © 2016 Satinder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Category : NSObject

@property (readonly, strong, nonatomic) NSNumber *categoryId;
@property (readonly, strong, nonatomic) NSURL *largeIconURL;
@property (readonly, strong, nonatomic) NSURL *emailIconURL;
@property (readonly, strong, nonatomic) NSURL *compactIconURL;
@property (readonly, strong, nonatomic) NSURL *mediumIconURL;
@property (readonly, strong, nonatomic) NSString *information;
@property (readonly, strong, nonatomic) NSString *typeString;

@end
