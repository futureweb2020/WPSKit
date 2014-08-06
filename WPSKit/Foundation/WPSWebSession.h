//
// WPSWebSession.h
//
// Created by Kirby Turner.
// Copyright 2014 White Peak Software. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to permit
// persons to whom the Software is furnished to do so, subject to the
// following conditions:
//
// The above copyright notice and this permission notice shall be included
// in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
// OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
// CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
// TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
// SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import <Foundation/Foundation.h>
#import "WPSWebError.h"

@class WPSCache;
@protocol WPSCache;

/**
 The block that is executed after the GET request to the URL has completed.
 
 @param data The data returned by the server.
 @param responseURL The response URL.
 @param error The error that occured during the request. The error can indicate a failure to make or satisfy the request, or the error can be the HTTP error returned from the server.
 */
typedef void(^WPSWebSessionCompletionBlock)(NSData *data, NSURL *responseURL, NSError *error);

/**
 The block that is executed after the GET request to the URL has completed.

 @param jsonData A Foundation object from the JSON data in the server response data, or nil if an error occurs.
 @param responseURL The response URL.
 @param error The error that occured during the request. The error can indicate a failure to make or satisfy the request, or the error can be the HTTP error returned from the server.
*/
typedef void(^WPSWebSessionJSONCompletionBlock)(id jsonData, NSURL *responseURL, NSError *error);

/**
 The block that is executed after the file has been downloaded.
 
 You must either open the file for reading or move it to a permanent location in your app’s sandbox container directory because the end of the block. The file is deleted once the block is completed.
 
 @param location The temporary location of the downloaded file.
 @param responseURL The response URL.
 @param error The error that occured during the request. The error can indicate a failure to make or satisfy the request, or the error can be the HTTP error returned from the server.
 */
typedef void(^WPSWebSessionDownloadCompletionBlock)(NSURL *location, NSURL *responseURL, NSError *error);

/**
 The block that is executed after the image has been downloaded.

 @param image A `UIImage` representing the downloaded image.
 @param responseURL The response URL.
 @param error The error that occured during the request. The error can indicate a failure to make or satisfy the request, or the error can be the HTTP error returned from the server.
 */
typedef void(^WPSWebSessionImageCompletionBlock)(UIImage *image, NSURL *responseURL, NSError *error);

/**
 `WPSWebSession` provides a wrapper around NSURLSession and session tasks. 
 
 It includes a caching mechanism where previously download information is pulled from the cache to avoid making additional calls over the network. It also manages a queue of each request to prevent the same request from being had twice at the same time.
 */
@interface WPSWebSession : NSObject

/**
 A reference to a `WPSCache` object used as the local cache.
 
 The default is `nil`. Set this reference to `nil` to not use the local cache.
 */
@property (nonatomic, weak) id<WPSCache> cache;

/**
 The cache age for data stored in the local cache. 
 
 The default is 5 minutes. 
 
 This value is ignored when `cache` is `nil`.
 */
@property (nonatomic, assign) NSInteger cacheAge;

/**
 The maximum number of times the HTTP request is sent when an error occurs.
 
 Note that retries only happen when there is an error communicating with the server. Retry attempts do not happen with HTTP errors.
 
 The default is 5 times.
 */
@property (nonatomic, assign) NSInteger retryCount;   // Defaults to 5.

/**
 Additional header fields that are added to each HTTP request.
 */
@property (nonatomic, copy) NSDictionary *additionalHTTPHeaderFields;

/**
 */
- (instancetype)initWithConfiguration:(NSURLSessionConfiguration *)configuration;

#pragma mark - GET Action
/// ----------------
/// @name GET Action
/// ----------------

/**
 Sends a GET request to the URL.
 
 @param URL The destination of the request.
 @param parameters A dictionary containing name-value pairs for each parameter. The parameters are sent as a query string.
 @param completion The block that is executed after the requet has completed.
 */
- (void)getWithURL:(NSURL *)URL parameters:(NSDictionary *)parameters completion:(WPSWebSessionCompletionBlock)completion;

/**
 Sends a GET request to the URL.
 
 @param URL The destination of the request.
 @param parameters A dictionary containing name-value pairs for each parameter. The parameters are sent as a query string.
 @param ignoreCache Set to `YES` to not use the local cache even if it is available.
 @param completion The block that is executed after the requet has completed.
 */
- (void)getWithURL:(NSURL *)URL parameters:(NSDictionary *)parameters ignoreCache:(BOOL)ignoreCache completion:(WPSWebSessionCompletionBlock)completion;

/**
 Sends a GET request to the URL and retrieve JSON data as the response.
 
 @param URL The destination of the request.
 @param parameters A dictionary containing name-value pairs for each parameter. The parameters are sent as a query string.
 @param completion The block that is executed after the requet has completed.
 */
- (void)getJSONWithURL:(NSURL *)URL parameters:(NSDictionary *)parameters completion:(WPSWebSessionJSONCompletionBlock)completion;

/**
 Sends a GET request to the URL and retrieve JSON data as the response.
 
 @param URL The destination of the request.
 @param parameters A dictionary containing name-value pairs for each parameter. The parameters are sent as a query string.
 @param ignoreCache Set to `YES` to not use the local cache even if it is available.
 @param completion The block that is executed after the requet has completed.
 */
- (void)getJSONWithURL:(NSURL *)URL parameters:(NSDictionary *)parameters ignoreCache:(BOOL)ignoreCache completion:(WPSWebSessionJSONCompletionBlock)completion;

#pragma mark - POST Action
/// -----------------
/// @name POST Action
/// -----------------

/**
 Sends a POST request to the URL.
 
 @param URL The destination of the POST request.
 @param parameters A dictionary containing name-value pairs for each parameter. The parameters are send in the request body.
 @param completion The block that is executed after the requet has completed.
 */
- (void)post:(NSURL *)URL parameters:(NSDictionary *)parameters completion:(WPSWebSessionCompletionBlock)completion;

/**
 Sends a POST request to the URL passing the data as a JSON structure.
 
 
 @param URL The destination of the POST request.
 @param jsonData A Foundation object representing the JSON data.
 @param completion The block that is executed after the requet has completed.
 */
- (void)post:(NSURL *)URL jsonData:(id)jsonData completion:(WPSWebSessionJSONCompletionBlock)completion;

/**
 Sends a POST request to the URL passing the provided data and using the provided contentType.

 @param URL The destination of the POST request.
 @param data The data sent as the body of the POST request.
 @param contentType The content type of the data.
 @param completion The block that is executed after the requet has completed.
*/
- (void)post:(NSURL *)URL data:(NSData *)data contentType:(NSString *)contentType completion:(WPSWebSessionCompletionBlock)completion;

/**
 Downloads a file at the provided URL.
 
 @param URL The location of the file to download.
 @param completion The block that is executed after the requet has completed.
 */
- (void)downloadFileAtURL:(NSURL *)URL completion:(WPSWebSessionDownloadCompletionBlock)completion;

/**
 Downloads a file at the provided URL with the provided parameters.
 
 @param URL The location of the file to download.
 @param parameters A dictionary containing name-value pairs for each parameter. The parameters are sent as a query string.
 @param completion The block that is executed after the requet has completed.
 */
- (void)downloadFileAtURL:(NSURL *)URL parameters:(NSDictionary *)parameters completion:(WPSWebSessionDownloadCompletionBlock)completion;

/**
 Downloads the image at the provided URL with the provided parameters.
 
 @param URL The location of the image to download.
 @param completion The block that is executed after the requet has completed.
 */
- (void)imageAtURL:(NSURL *)URL completion:(WPSWebSessionImageCompletionBlock)completion;

/**
 Downloads the image at the provided URL with the provided parameters.

 @param URL The location of the image to download.
 @param parameters A dictionary containing name-value pairs for each parameter. The parameters are sent as a query string.
 @param completion The block that is executed after the requet has completed.
 */
- (void)imageAtURL:(NSURL *)URL parameters:(NSDictionary *)parameters completion:(WPSWebSessionImageCompletionBlock)completion;

@end
