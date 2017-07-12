//
//  ViewController.m
//  JFUtilsDemo
//
//  Created by cjf on 2017/6/30.
//  Copyright © 2017年 Jinfei Chen. All rights reserved.
//

#import "ViewController.h"

#import "JFCategories.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSLog(@"%@", [NSString getIPAddressOfInsideNetwork:NO]);
    NSLog(@"%@", [NSString getIPAddressOfOutsideNetwork]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
