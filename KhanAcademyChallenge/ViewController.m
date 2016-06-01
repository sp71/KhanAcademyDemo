//
//  ViewController.m
//  KhanAcademyChallenge
//
//  Created by Satinder Singh on 5/17/16.
//  Copyright © 2016 Satinder. All rights reserved.
//

#import "ViewController.h"
#import "BadgeCollectionViewCell.h"
#import "KhanAcademyNetworkController.h"
#import "Badge.h"
#import "UIViewController+ErrorAlert.h"
#import "DetailViewController.h"

#define kDETAIL_SEGUE           @"detailSegue"
#define kREUSE_CELL_IDENTIFIER  @"badgeCell"

typedef void (^imageCompletion)(UIImage * _Nullable image);

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *badgeList;
@property (strong, nonatomic) KhanAcademyNetworkController *khanController;

@end

@implementation ViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self populateBadgeList];
}

#pragma mark - Helper Methods
/*! Populate Data Source and then update collectionView */
- (void)populateBadgeList {
    __weak typeof(self) wself = self;
    
    [self.khanController badgeListWithCompletion:^(NSArray * _Nullable badgeList, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                [wself presentWithError:error withCompletionBlock:nil];
            } else {
                wself.badgeList = badgeList;
                [wself.collectionView reloadData];
            }
        });
    }];
}

/*! Download photo for badge at specific indexpath */
- (void)downloadPhotoWithIndexPath:(NSIndexPath *)indexpath badge:(Badge *)badge {
    if (self.khanController.opController.pendingOperationsDict[indexpath]) {
        return;
    }
    NSURL *url = badge.compactIconURL;
    __weak typeof(self)wself = self;
    [self.khanController imageWithURL:url indexPath:indexpath completion:^(NSData * _Nullable imageData, NSError * _Nullable error) {
        if (error) {
            [wself presentWithError:error withCompletionBlock:nil];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([imageData length] > 0) {
                    badge.photo = [UIImage imageWithData:imageData];
                    [wself.collectionView reloadItemsAtIndexPaths:@[indexpath]];
                }
            });
        }
    }];
}

/*! only focus on pending operations that are visible to user's screen.
 Removes pending operations that
 */
- (void)prioritizeOperations {
    NSArray <NSIndexPath *> *visibleIndexPathList = [self.collectionView indexPathsForVisibleItems];
    NSMutableSet *visibleSet = [NSMutableSet setWithArray:visibleIndexPathList];
    NSArray *pendingOpsArray = self.khanController.opController.pendingOperationsDict.allKeys;
    NSMutableSet *allPendingOperations = [NSMutableSet setWithArray:pendingOpsArray];
    NSMutableSet *cancelSet = allPendingOperations;
    [cancelSet minusSet:visibleSet];
    NSMutableSet *visibleUnprocessSet = visibleSet;
    [visibleUnprocessSet minusSet:allPendingOperations];
    [self.khanController.opController cancelPendingOperationsForindexPaths:cancelSet.allObjects];
    
    for (NSIndexPath *indexPath in visibleUnprocessSet) {
        Badge *badge = self.badgeList[indexPath.row];
        [self downloadPhotoWithIndexPath:indexPath badge:badge];
    }
}

#pragma mark - CollectionViewDelegates
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.badgeList.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BadgeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kREUSE_CELL_IDENTIFIER forIndexPath:indexPath];
    Badge *badge = self.badgeList[indexPath.row];
    cell.photoLabel.text = badge.slug ?: badge.name;
    
    if (badge.photo) {
        cell.photo.image = badge.photo;
    } else {
        cell.photo.image = nil;
        [self downloadPhotoWithIndexPath:indexPath badge:badge];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:kDETAIL_SEGUE sender:self];
}

#pragma mark - ScrollViewDelegates
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.khanController suspendAllOperations];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self prioritizeOperations];
        [self.khanController resumeAllOperations];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self prioritizeOperations];
    [self.khanController resumeAllOperations];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kDETAIL_SEGUE] && [segue.destinationViewController isKindOfClass:[DetailViewController class]]) {
        [self.khanController cancelAllOperations];
        DetailViewController *detailVC = segue.destinationViewController;
        NSIndexPath *indexpath = [self.collectionView indexPathsForSelectedItems].firstObject;
        detailVC.badge = self.badgeList[indexpath.row];
    }
}

#pragma mark - Properties
- (NSArray *)badgeList {
    if (!_badgeList) {
        _badgeList = [[NSArray alloc] init];
    }
    return _badgeList;
}

- (KhanAcademyNetworkController *)khanController {
    if (!_khanController) {
        _khanController = [KhanAcademyNetworkController sharedInstance];
    }
    return _khanController;
}

@end
