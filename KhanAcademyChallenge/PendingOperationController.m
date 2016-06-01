//
//  PendingOperationController.m
//  KhanAcademyChallenge
//
//  Created by Satinder Singh on 5/22/16.
//  Copyright © 2016 Satinder. All rights reserved.
//

#import "PendingOperationController.h"

@interface PendingOperationController () {
    NSMutableDictionary <NSIndexPath *, NSOperation *>  *_pendingOperationsDict;
}

@end

@implementation PendingOperationController

- (instancetype)init {
    self = [super init];
    if (self) {
        _pendingOperationsDict = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)addPendingOperationForIndexPath:(NSIndexPath *)indexPath operation:(NSOperation *)operation {
    _pendingOperationsDict[indexPath] = operation;
}

- (void)removePendingOperationForIndexPath:(NSIndexPath * _Nonnull)indexPath {
    [_pendingOperationsDict removeObjectForKey:indexPath];
}

- (void)cancelPendingOperationsForindexPaths:(NSArray <NSIndexPath * > * _Nullable)indexPathList {
    for (NSIndexPath *indexPath in indexPathList) {
        NSOperation *op = self.pendingOperationsDict[indexPath];
        [op cancel];
        [_pendingOperationsDict removeObjectForKey:indexPath];
    }
}

- (void)cancelAllPendingOperations {
    for (NSIndexPath *indexPath in _pendingOperationsDict) {
        NSOperation *op = self.pendingOperationsDict[indexPath];
        [op cancel];
        [_pendingOperationsDict removeObjectForKey:indexPath];
    }
}

- (NSDictionary<NSIndexPath *,NSOperation *> *)pendingOperationsDict {
    return [_pendingOperationsDict copy];
}

@end
