//
//  UIViewController+ErrorAlert.m
//  KhanAcademyChallenge
//
//  Created by Satinder Singh on 5/19/16.
//  Copyright © 2016 Satinder. All rights reserved.
//

#import "UIViewController+ErrorAlert.h"

@implementation UIViewController (ErrorAlert)

- (void)presentWithError:(NSError* _Nonnull)error withCompletionBlock:(void (^_Nullable)())completionBlock {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:error.localizedDescription
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:completionBlock];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
