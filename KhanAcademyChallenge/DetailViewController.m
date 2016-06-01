//
//  DetailViewController.m
//  KhanAcademyChallenge
//
//  Created by Satinder Singh on 5/20/16.
//  Copyright © 2016 Satinder. All rights reserved.
//

#import "DetailViewController.h"
#import "KhanAcademyNetworkController.h"
#import "UIViewController+ErrorAlert.h"
#import "NSString+Validate.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *categoryImageView;
@property (weak, nonatomic) IBOutlet UIImageView *badgeImageView;
@property (weak, nonatomic) IBOutlet UITextView *categoryTextView;
@property (weak, nonatomic) IBOutlet UITextView *badgeTextView;
@property (strong, nonatomic) KhanAcademyNetworkController *khanController;
@end

@implementation DetailViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureBadgeTextView];
    [self fetchCategoryInfo];
    __weak typeof(self)wself = self;
    NSURL *url = self.badge.largeIconURL;
    [self fetchImageAtURL:url completion:^(NSData * _Nullable imageData, NSError * _Nullable error) {
        if (error) {
            [wself presentWithError:error withCompletionBlock:nil];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                wself.badgeImageView.image = [UIImage imageWithData:imageData];
            });
        }
    }];
}

#pragma mark - Helper Methods
- (void)configureBadgeTextView {
    self.badgeTextView.text = @"Badge";
    if ([self.badge.slug isValidString]) {
        self.badgeTextView.text = [NSString stringWithFormat:@"%@\nSlug: %@", self.badgeTextView.text, self.badge.slug];
    }
    if ([self.badge.name isValidString]) {
        self.badgeTextView.text = [NSString stringWithFormat:@"%@\nName: %@", self.badgeTextView.text, self.badge.name];
    }
    if (self.badge.points) {
        self.badgeTextView.text = [NSString stringWithFormat:@"%@\nPoints: %d", self.badgeTextView.text, [self.badge.points intValue]];
    }
    if ([self.badge.information isValidString]) {
        self.badgeTextView.text = [NSString stringWithFormat:@"%@\nDescription: %@", self.badgeTextView.text, self.badge.information];
    }
    if ([self.badge.safeExtendedInformation isValidString]) {
        self.badgeTextView.text = [NSString stringWithFormat:@"%@\nExtended Info: %@", self.badgeTextView.text, self.badge.safeExtendedInformation];
    }
}

- (void)configureCategoryTextView {
    self.categoryTextView.text = @"Category";
    Category *category = self.badge.category;
    if ([category.typeString isValidString]) {
        self.categoryTextView.text = [NSString stringWithFormat:@"%@\nType: %@", self.categoryTextView.text, category.typeString];
    }
    if ([category.information isValidString]) {
        self.categoryTextView.text = [NSString stringWithFormat:@"%@\nDescription: %@", self.categoryTextView.text, category.information];
    }
}

- (void)fetchCategoryInfo {
    __weak typeof(self)wself = self;
    int categoryId = [self.badge.category.categoryId intValue];
    [self.khanController detailCategoryWithID:categoryId completion:^(Category * _Nullable category, NSError * _Nullable error) {
        if (error) {
            [wself presentWithError:error withCompletionBlock:nil];
        } else {
            wself.badge.category = category;
            [wself fetchImageAtURL:self.badge.category.emailIconURL completion:^(NSData * _Nullable imageData, NSError * _Nullable error) {
                if (error) {
                    [wself presentWithError:error withCompletionBlock:nil];
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        wself.categoryImageView.image = [UIImage imageWithData:imageData];
                        [wself configureCategoryTextView];
                    });
                }
            }];
            dispatch_async(dispatch_get_main_queue(), ^{
                wself.categoryTextView.text = category.information;
            });
        }
    }];
}

- (void)fetchImageAtURL:(NSURL *)url completion:(ImageCompletion)completion {
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.khanController imageWithURL:url indexPath:indexpath completion:completion];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [self.khanController cancelAllOperations];
}

#pragma mark - Properties
- (KhanAcademyNetworkController *)khanController {
    if (!_khanController) {
        _khanController = [KhanAcademyNetworkController sharedInstance];
    }
    return _khanController;
}

@end
