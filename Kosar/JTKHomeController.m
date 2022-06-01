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
    CGFloat x = 20 + arc4random() % (300 - 20);
    CGFloat y = 20 + arc4random() % (300 - 20);
    UILabel *helloWorldLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, 100, 40)];
    helloWorldLabel.text = @"Hello World!";
    [self.view addSubview:helloWorldLabel];
}


@end

