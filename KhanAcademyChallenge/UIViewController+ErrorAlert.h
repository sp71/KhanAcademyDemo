//
//  UIViewController+ErrorAlert.h
//  KhanAcademyChallenge
//
//  Created by Satinder Singh on 5/19/16.
//  Copyright © 2016 Satinder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ErrorAlert)

/*! Present AlertController with information regarding error */
- (void)presentWithError:(NSError* _Nonnull)error withCompletionBlock:(void (^_Nullable)())completionBlock;

@end
