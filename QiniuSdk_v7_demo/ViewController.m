//
//  ViewController.m
//  QiniuSdk_v7_demo
//
//  Created by CharlieJade on 11/12/14.
//  Copyright (c) 2014 TheEstGroup. All rights reserved.
//

#import "ViewController.h"

#import "QNUploadManager.h"
#import "UIImage+ResizeMagick.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    
    // Your Token Here, See: http://developer.qiniu.com/docs/v6/api/reference/security/upload-token.html
    NSString *token = @"";
    
    // Load Local Image
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"pixar" ofType:@"jpeg"];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:filePath];
    
    NSString *fileName = [NSString stringWithFormat:@"%@_%@.jpg", [self getDateTimeString], [self randomStringWithLength:8]];
    
    // ------------------- Test putData -------------------------
//    NSData *data = [@"Hello, World!" dataUsingEncoding : NSUTF8StringEncoding];
    NSData *data = [image resizedAndReturnData];
    [upManager putData:data
                   key:fileName
                 token:token
              complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                       
                       NSLog(@" --->> Info: %@  ", info);
                       NSLog(@" ---------------------");
                       NSLog(@" --->> Response: %@,  ", resp);
                }
                option:nil];

    // ------------------- Test putFile -------------------------
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"the_v" ofType:@"png"];
//
//    [upManager putFile:path
//                   key:fileName
//                 token:token
//              complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
//        
//        NSLog(@" --->> Info: %@  ", info);
//        NSLog(@" ---------------------");
//        NSLog(@" --->> Response: %@,  ", resp);
//        
//    } option:nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helpers

- (NSString *)getDateTimeString
{
    NSDateFormatter *formatter;
    NSString        *dateString;
    
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd_HH:mm:ss"];
    
    dateString = [formatter stringFromDate:[NSDate date]];
    
    return dateString;
}


- (NSString *)randomStringWithLength:(int)len
{
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((int)[letters length])]];
    }
    
    return randomString;
}

@end
