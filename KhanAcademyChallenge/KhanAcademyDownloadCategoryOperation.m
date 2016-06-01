//
//  KhanAcademyCategoryOperation.m
//  KhanAcademyChallenge
//
//  Created by Satinder Singh on 5/20/16.
//  Copyright © 2016 Satinder. All rights reserved.
//

#import "KhanAcademyDownloadCategoryOperation.h"
#import "KhanAcademyOperationInternal.h"

#define kPATH @"/api/v1/badges/categories/"

@implementation KhanAcademyDownloadCategoryOperation

#pragma mark - Helper Methods

- (void)parseWithJSON:(NSArray *)json {
    NSDictionary *dict = [json firstObject];
    self.category.largeIconURL = [NSURL URLWithString:dict[@"large_icon_src"]];
    self.category.compactIconURL = [NSURL URLWithString:dict[@"compact_icon_src"] ];
    self.category.emailIconURL = [NSURL URLWithString:dict[@"email_icon_src"] ];
    self.category.mediumIconURL = [NSURL URLWithString:dict[@"medium_icon_src"] ];
    self.category.categoryId = dict[@"category"];
    self.category.information = dict[@"description"];
    if (dict[@"translated_description"]) {
        self.category.information = dict[@"translated_description"];
    }
    self.category.typeString = dict[@"type_label"];
}

#pragma mark - Init
- (_Nullable instancetype)initWithID:(int)categoryID {
    NSString *path = [NSString stringWithFormat:@"%@%d", kPATH, categoryID];
    return [super initWithPath:path queryItems:nil];
}

#pragma mark - Properties
- (Category *)category {
    if (!_category) {
        _category = [[Category alloc] init];
    }
    return _category;
}

@end