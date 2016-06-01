//
//  KhanAcademyNetworkController.h
//  KhanAcademyChallenge
//
//  Created by Satinder Singh on 5/18/16.
//  Copyright © 2016 Satinder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Category.h"
#import "PendingOperationController.h"

typedef void (^_Nonnull badgeCompletion)(NSArray * _Nullable badgeList, NSError * _Nullable error);
typedef void (^_Nonnull ImageCompletion)(NSData * _Nullable imageData, NSError * _Nullable error);
typedef void (^_Nonnull DetailCategoryCompletion)(Category * _Nullable category, NSError * _Nullable error);

/*! Manages network actions between Khan Academy & client
 @Note      All network actions are placed as background tasks
 @Warning   Callbacks are not guaranteed to be on main thread
 */
@interface KhanAcademyNetworkController : NSObject

@property (strong, nonatomic) PendingOperationController * _Nonnull opController;

/*! Shared Instance of KhanAcademyNetworkController */
+ (KhanAcademyNetworkController  * _Nonnull)sharedInstance;

/*! Cancels all upcoming queued operations */
- (void)cancelAllOperations;
/*! Prevents the queue from starting any queued operations, but already executing operations continue to execute */
- (void)suspendAllOperations;
/*! Resumes operations that are in the queue and ready to execute */
- (void)resumeAllOperations;
/*! Delivers list of badges */
- (void)badgeListWithCompletion:(badgeCompletion)completion;
/*! Delivers list of badges */
- (void)imageWithURL:(NSURL * _Nonnull)url indexPath:(NSIndexPath * _Nonnull)indexPath completion:(ImageCompletion)completion;
/*! Delivers category for specified Category Id */
- (void)detailCategoryWithID:(int)categoryID completion:(DetailCategoryCompletion)completion;

@end
