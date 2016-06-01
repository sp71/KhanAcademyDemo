//
//  KhanAcademyOperation.m
//  KhanAcademyChallenge
//
//  Created by Satinder Singh on 5/20/16.
//  Copyright © 2016 Satinder. All rights reserved.
//

#import "KhanAcademyOperationInternal.h"
#define kOP_CONTROLLER_SCHEME           @"https"
#define kOP_CONTROLLER_HOST             @"www.khanacademy.org"
#define kOP_CONTROLLER_STATUS_SUCCESS   200
#define kOP_CONTROLLER_DOMAIN_ERROR     @"khan.academy.operation"

@interface KhanAcademyOperation ()
@property (strong, nonatomic) NSString *path;
@property (strong, nonatomic) NSArray<NSURLQueryItem *> *queryItems;
@end

@implementation KhanAcademyOperation

@synthesize request = _request;
@synthesize session = _session;
@synthesize error = _error;

#pragma mark - Helper Methods
- (id)serializeFromResponse:(NSURLResponse * )response error:(NSError **)error data:(NSData *)data {
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    id serializedData;
    if (*error) {
        self.error = *error;
    } else if (httpResponse.statusCode != kOP_CONTROLLER_STATUS_SUCCESS) {
        self.error = [NSError errorWithDomain:kOP_CONTROLLER_DOMAIN_ERROR
                                         code:kCFStreamErrorHTTPSProxyFailureUnexpectedResponseToCONNECTMethod
                                     userInfo:@{ NSLocalizedDescriptionKey : @"Unexpected HTTP status code" }];
    } else if (!data) {
        self.error = [NSError errorWithDomain:kOP_CONTROLLER_DOMAIN_ERROR
                                         code:kCFURLErrorCannotParseResponse
                                     userInfo:@{ NSLocalizedDescriptionKey : @"Cannot Parse Data" }];
    } else {
        NSError *errorJson = nil;
        serializedData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&errorJson];
        if (errorJson) {
            self.error = errorJson;
        }
    }
    return serializedData;
}

- (id)fetchJson {
    __block id serialize;
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:self.request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        serialize = [self serializeFromResponse:response error:&error data:data];
        dispatch_group_leave(group);
    }];
    [task resume];
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    return serialize;
}

- (void)parseWithJSON:(NSMutableArray *)json
{
    @throw [NSException exceptionWithName:@"Unimplemented method" reason:@"Override in subclass" userInfo:nil];
}

#pragma mark - Main
- (void)main
{
    id serialize = [self fetchJson];
    if (!self.error && serialize) {
        [self parseWithJSON:serialize];
    }
}


#pragma mark - Initalizers
- (instancetype)initWithPath:(NSString *)path queryItems:(NSArray<NSURLQueryItem *> *)queryItems {
    self = [super init];
    if (self) {
        self.path = path;
        self.queryItems = queryItems;
    }
    return self;
}

#pragma mark - Properties
- (NSURLRequest *)request {
    if (!_request) {
        NSURLComponents *urlComponents = [[NSURLComponents alloc] init];
        urlComponents.scheme = kOP_CONTROLLER_SCHEME;
        urlComponents.host = kOP_CONTROLLER_HOST;
        urlComponents.path = self.path;
        urlComponents.queryItems = self.queryItems;
        _request = [NSURLRequest requestWithURL:urlComponents.URL];
    }
    return _request;
}

- (NSURLSession *)session {
    if (!_session) {
        _session = [NSURLSession sharedSession];
    }
    return _session;
}

@end
