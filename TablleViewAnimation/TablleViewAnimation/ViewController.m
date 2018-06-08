//
//  ViewController.m
//  TablleViewAnimation
//
//  Created by 蒋礼智 on 2018/5/3.
//  Copyright © 2018年 蒋礼智. All rights reserved.
//

#import "ViewController.h"
#import "TableViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)jumpToListVC:(id)sender {
    TableViewController *vc = [[TableViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
