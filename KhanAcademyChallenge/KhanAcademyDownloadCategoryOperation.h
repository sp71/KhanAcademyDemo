//
//  KhanAcademyDownloadCategoryOperation.h
//  KhanAcademyChallenge
//
//  Created by Satinder Singh on 5/20/16.
//  Copyright © 2016 Satinder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CategoryInternal.h"
#import "KhanAcademyOperation.h"

@interface KhanAcademyDownloadCategoryOperation : KhanAcademyOperation

@property (strong, nonatomic) Category * _Nullable category;

- (_Nullable instancetype)initWithID:(int)categoryID;

@end
