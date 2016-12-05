//
//  Services.m
//  TumblrClient
//
//  Created by Dominik Olędzki on 04/12/2016.
//  Copyright © 2016 Dominik Oledzki. All rights reserved.
//

#import <Ono/Ono.h>
#import <UIKit/UIKit.h>
#import "Services.h"
#import "NSURLComponents+Additions.h"

@interface Services ()

@property (nonatomic, copy) NSURLComponents *baseUrl;
@property (nonatomic, copy) NSString *blogName;
@property (nonatomic, strong) NSURLSession *session;

@end

static NSString * const apiHost = @"tumblr.com";
static NSString *const servicesErrorDomain = @"ServicesErrorDomain";
typedef NS_ENUM(NSInteger, ServicesErrorCode) {
    ServicesErrorCodeHTTPError = 1,
    ServicesErrorCodeInvalidData,
    ServicesErrorCodeInvalidXML,
    ServicesErrorCodeNoDataDownloaded,
    ServicesErrorCodeInvalidImageData
};

@implementation Services

- (instancetype)initWithBlogName:(NSString *)blogName {
    self = [super init];
    if (self) {
        _blogName = blogName;
        _baseUrl = [[NSURLComponents alloc] init];
        _baseUrl.scheme = @"https";
        _baseUrl.host = [NSString stringWithFormat:@"%@.%@", blogName, apiHost];
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    }
    return self;
}

- (void)getBlogPostsStartingWith:(NSUInteger)start
                        pageSize:(NSUInteger)pageSize
               completionHandler:(void (^)(BlogPostsServiceResponse *response, NSError *error))completionHandler {
    
    NSArray *queryItems = @[
                            [NSURLQueryItem queryItemWithName:@"start" value:[NSString stringWithFormat:@"%d", start]],
                            [NSURLQueryItem queryItemWithName:@"num" value:[NSString stringWithFormat:@"%d", pageSize]],
                            ];

    NSURLComponents *urlComponents = [self.baseUrl copy];
    NSURL *url = [urlComponents urlWithPath:@"/api/read" andQueryItems:queryItems];
    
    [[self.session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (!completionHandler) {
            return;
        }
        
        if (error) {
            completionHandler(nil, error);
            return;
        }
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (httpResponse.statusCode < 200 || httpResponse.statusCode >= 300) {
            NSNumber *statusCode = @(httpResponse.statusCode);
            NSError *error = [NSError errorWithDomain:servicesErrorDomain code:ServicesErrorCodeHTTPError userInfo:@{@"statusCode": statusCode}];
            completionHandler(nil, error);
            return;
        }
        
        NSError *xmlError = nil;
        ONOXMLDocument *document = [ONOXMLDocument XMLDocumentWithData:data error:&xmlError];
        if (!document || xmlError) {
            NSError *error = [NSError errorWithDomain:servicesErrorDomain code:ServicesErrorCodeInvalidData userInfo:@{@"error": xmlError}];
            completionHandler(nil, error);
            return;
        }
        
        BlogPostsServiceResponse *responseObject = [[BlogPostsServiceResponse alloc] initWithXmlElement:document.rootElement];
        if (!responseObject) {
            NSError *error = [NSError errorWithDomain:servicesErrorDomain code:ServicesErrorCodeInvalidXML userInfo:nil];
            completionHandler(nil, error);
            return;
        }
        
        completionHandler(responseObject, nil);
    }] resume];
}

- (void)downloadImageWithUrl:(NSURL *)url completionHandler:(void (^)(UIImage *image, NSError *error))completionHandler {
    
    [[self.session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!completionHandler) {
            return;
        }
        
        if (error) {
            completionHandler(nil, error);
            return;
        }
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (httpResponse.statusCode < 200 || httpResponse.statusCode >= 300) {
            NSNumber *statusCode = @(httpResponse.statusCode);
            NSError *error = [NSError errorWithDomain:servicesErrorDomain code:ServicesErrorCodeHTTPError userInfo:@{@"statusCode": statusCode}];
            completionHandler(nil, error);
            return;
        }
        
        NSData *data = [[NSData alloc] initWithContentsOfURL:location];
        if (!data) {
            NSError *error = [NSError errorWithDomain:servicesErrorDomain code:ServicesErrorCodeNoDataDownloaded userInfo:nil];
            completionHandler(nil, error);
            return;
        }
        
        UIImage *image = [[UIImage alloc] initWithData:data];
        if (!image) {
            NSError *error = [NSError errorWithDomain:servicesErrorDomain code:ServicesErrorCodeInvalidImageData userInfo:nil];
            completionHandler(nil, error);
            return;
        }
        
        completionHandler(image, nil);
        
    }] resume];
}

@end
