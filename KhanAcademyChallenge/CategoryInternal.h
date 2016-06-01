//
//  CategoryInternal.h
//  KhanAcademyChallenge
//
//  Created by Satinder Singh on 5/31/16.
//  Copyright © 2016 Satinder. All rights reserved.
//

#ifndef CategoryInternal_h
#define CategoryInternal_h

#import "Category.h"

@interface Category ()

@property (strong, nonatomic) NSNumber *categoryId;
@property (strong, nonatomic) NSURL *largeIconURL;
@property (strong, nonatomic) NSURL *emailIconURL;
@property (strong, nonatomic) NSURL *compactIconURL;
@property (strong, nonatomic) NSURL *mediumIconURL;
@property (strong, nonatomic) NSString *information;
@property (strong, nonatomic) NSString *typeString;

@end

#endif /* CategoryInternal_h */