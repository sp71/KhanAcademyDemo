//
//  KhanAcademyNetworkController.m
//  KhanAcademyChallenge
//
//  Created by Satinder Singh on 5/18/16.
//  Copyright © 2016 Satinder. All rights reserved.
//

#import "KhanAcademyNetworkController.h"
#import "KhanAcademyDownloadBadgeOperation.h"
#import "DownloadImageOperation.h"
#import "KhanAcademyNetworkController.h"
#import "KhanAcademyDownloadCategoryOperation.h"
#import "KhanAcademyOperationInternal.h"

@interface KhanAcademyNetworkController()

@property (strong, nonatomic) NSOperationQueue * _Nonnull operationQueue;

@end

@implementation KhanAcademyNetworkController

#pragma mark - Queue
- (void)cancelAllOperations {
    [self.operationQueue cancelAllOperations];
}

- (void)suspendAllOperations {
    self.operationQueue.suspended = YES;
}

- (void)resumeAllOperations {
    self.operationQueue.suspended = NO;
}

#pragma mark - Operations
- (void)badgeListWithCompletion:(badgeCompletion)completion {
    KhanAcademyDownloadBadgeOperation *fetchOp = [[KhanAcademyDownloadBadgeOperation alloc] init];
    __weak KhanAcademyDownloadBadgeOperation *wfetchOp = fetchOp;
    fetchOp.completionBlock = ^{
        completion(wfetchOp.badgeList, wfetchOp.error);
    };
    [self.operationQueue addOperation:fetchOp];
}

- (void)detailCategoryWithID:(int)categoryId completion:(DetailCategoryCompletion)completion {
    KhanAcademyDownloadCategoryOperation *fetchOp = [[KhanAcademyDownloadCategoryOperation alloc] initWithID:categoryId];
    __weak KhanAcademyDownloadCategoryOperation *wfetchOp = fetchOp;
    fetchOp.completionBlock = ^{
        completion(wfetchOp.category, wfetchOp.error);
    };
    [self.operationQueue addOperation:fetchOp];
}

- (void)imageWithURL:(NSURL * _Nonnull)url indexPath:(NSIndexPath * _Nonnull)indexPath completion:(ImageCompletion)completion {
    DownloadImageOperation *fetchOp = [[DownloadImageOperation alloc] init];
    fetchOp.imageURL = url;
    __weak DownloadImageOperation *wfetchOp = fetchOp;
    fetchOp.completionBlock = ^{
        [self.opController removePendingOperationForIndexPath:indexPath];
        completion(wfetchOp.imageData, wfetchOp.error);
    };
    [self.opController addPendingOperationForIndexPath:indexPath operation:fetchOp];
    [self.operationQueue addOperation:fetchOp];
}

#pragma mark - Singletons
+ (KhanAcademyNetworkController *)sharedInstance {
    static KhanAcademyNetworkController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[KhanAcademyNetworkController alloc] init];
    });
    return sharedInstance;
}

#pragma mark - Properties
- (PendingOperationController *)opController {
    if (!_opController) {
        _opController = [[PendingOperationController alloc] init];
    }
    return _opController;
}

- (NSOperationQueue *)operationQueue {
    if (!_operationQueue) {
        _operationQueue = [[NSOperationQueue alloc] init];
        _operationQueue.maxConcurrentOperationCount = NSOperationQueueDefaultMaxConcurrentOperationCount;
    }
    return _operationQueue;
}

@end
