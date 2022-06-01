//
//  JTKMainController.m
//  Kosar
//
//  Created by ByteDance on 1/6/22.
//

#import "JTKMainController.h"

@interface JTKMainController ()

@end

@implementation JTKMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UILabel *helloWorldLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    helloWorldLabel.text = @"Hello World!";
    [self.view addSubview:helloWorldLabel];
}


@end

