//
//  PendingOperationController.h
//  KhanAcademyChallenge
//
//  Created by Satinder Singh on 5/22/16.
//  Copyright © 2016 Satinder. All rights reserved.
//

#import <Foundation/Foundation.h>

/*! Manages Pending Operations within the application */
@interface PendingOperationController : NSObject

/*! Dictionary of pending operations that have not been executed yet.
 @Note this property is immutable
 */
@property (strong, nonatomic, readonly) NSDictionary <NSIndexPath *, NSOperation *> * _Nonnull pendingOperationsDict;

- (void)removePendingOperationForIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (void)addPendingOperationForIndexPath:(NSIndexPath * _Nonnull)indexPath operation:(NSOperation * _Nonnull)operation;

- (void)cancelPendingOperationsForindexPaths:(NSArray <NSIndexPath * > * _Nullable)indexPathList;
- (void)cancelAllPendingOperations;


@end
