//
//  JTKHomeController.m
//  Kosar
//
//  Created by ByteDance on 1/6/22.
//

#import "JTKHomeController.h"

@interface JTKHomeController ()

@end

@implementation JTKHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *helloWorldLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    helloWorldLabel.text = @"Hello World!";
    [self.view addSubview:helloWorldLabel];
}


@end

