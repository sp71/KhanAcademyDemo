//
//  KhanAcademyDownloadBadgeOperation.m
//  KhanAcademyChallenge
//
//  Created by Satinder Singh on 5/17/16.
//  Copyright © 2016 Satinder. All rights reserved.
//

#import "KhanAcademyDownloadBadgeOperation.h"
#import "KhanAcademyOperationInternal.h"
#import "BadgeInternal.h"
#import "CategoryInternal.h"

#define kPATH @"/api/v1/badges"

@implementation KhanAcademyDownloadBadgeOperation

#pragma mark - Helper Methods

- (void)parseWithJSON:(NSArray *)json {
    NSMutableArray *mutableBadgeList = [[NSMutableArray alloc] init];
    
    for (NSDictionary *badgeDictJson in json) {
        Badge *badge = [[Badge alloc] init];
        badge.name = badgeDictJson[@"name"];
        badge.points = badgeDictJson[@"points"];
        badge.slug = badgeDictJson[@"slug"];
        badge.information = badgeDictJson[@"description"];
        
        if (badgeDictJson[@"translated_description"]) {
            badge.information = badgeDictJson[@"translated_description"];
        }
        badge.safeExtendedInformation = badgeDictJson[@"safeExtendedInformation"];
        
        if (badgeDictJson[@"translated_safe_extended_description"]) {
            badge.safeExtendedInformation = badgeDictJson[@"translated_safe_extended_description"];
        }
        badge.category.categoryId = badgeDictJson[@"badge_category"];
        
        NSDictionary *iconDictJson = badgeDictJson[@"icons"];
        badge.compactIconURL = [NSURL URLWithString:iconDictJson[@"compact"]];
        badge.largeIconURL = [NSURL URLWithString:iconDictJson[@"large"]];
        
        [mutableBadgeList addObject:badge];
    }
    self.badgeList = [mutableBadgeList copy];
}

#pragma mark - Init

- (instancetype)init {
    return [super initWithPath:kPATH queryItems:nil];
}

@end
