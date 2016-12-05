//
//  TumblrClientTests.m
//  TumblrClientTests
//
//  Created by Dominik Olędzki on 03/12/2016.
//  Copyright © 2016 Dominik Oledzki. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Ono/Ono.h>
#import "BlogPostsServiceResponse.h"
#import "PhotoBlogPost.h"

@interface TumblrClientTests : XCTestCase

@end

@implementation TumblrClientTests

- (void)testCheckURLComponentsValidation {
    
    NSURLComponents *components = [NSURLComponents new];
    components.scheme = @"https";
    components.host = @"abcd.com";
    
    XCTAssertEqualObjects(components.URL.absoluteString, @"https://abcd.com");
    
    components.host = @"some?invalid##characters";
    XCTAssertEqualObjects(components.URL.absoluteString, @"https://some%3Finvalid%23%23characters");
    
    NSString *urlInjection = @"myDomain.com/";
    components.host = [NSString stringWithFormat:@"%@.tumblr.com", urlInjection];
    NSURL *url = components.URL;
    
    NSURLComponents *components2 = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
    XCTAssertEqualObjects(components2.URL.absoluteString, @"https://myDomain.com%2F.tumblr.com");
}

- (void)testBlogPostsService {
    NSString *xmlPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"example" ofType:@"xml"];
    NSData *xmlData = [[NSData alloc] initWithContentsOfFile:xmlPath];
    ONOXMLDocument *xmlDocument = [ONOXMLDocument XMLDocumentWithData:xmlData error:nil];
    
    BlogPostsServiceResponse *response = [[BlogPostsServiceResponse alloc] initWithXmlElement:xmlDocument.rootElement];
    
    XCTAssertEqualObjects(response.tumblelog.name, @"apitest1");
    XCTAssertEqualObjects(response.tumblelog.title, @"Untitled");
    XCTAssertEqual(response.start, 10);
    XCTAssertEqual(response.total, 4);
    XCTAssertEqual(response.posts.count, 4);
    
    PhotoBlogPost *post0 = response.posts[0];
    XCTAssert([post0 isKindOfClass:[PhotoBlogPost class]]);
    XCTAssertEqualObjects(post0.identifier, @"154005356017");
    XCTAssertEqualObjects(post0.type, @"photo");
    XCTAssertEqualObjects(post0.photoUrl.absoluteString, @"https://68.media.tumblr.com/ca4ceab2736d1d88125f9e9f104ad376/tumblr_ohmtl7Aen41vma4uho1_500.png");
    
}

@end
