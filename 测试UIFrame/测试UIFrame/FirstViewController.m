//
//  FirstViewController.m
//  测试UIFrame
//
//  Created by 蒋礼智 on 2018/5/19.
//  Copyright © 2018年 蒋礼智. All rights reserved.
//

#import "FirstViewController.h"
#import "NSObject+Caculator.h"
#import "Calcultor.h"

@interface FirstViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"常用";
    [self.view addSubview:self.tableView];
    NSLog(@"%f=======%f",self.tableView.contentInset.top,self.tableView.contentInset.bottom);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 100, 30)];
    label.text = @"hehe";
    [self.view addSubview:label];
    if (self.navigationController.navigationBar.translucent) {
        NSLog(@"默认透明");
    }
    // [self wr_setNavBarBarTintColor:[UIColor redColor]];
    // [self wr_setNavBarBackgroundAlpha:0];
    // 改变标题文字大小
    // self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:22]};
}

#pragma mark - tableview delegate / dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:nil];
    NSString *str = nil;
    switch (indexPath.row) {
        case 0:
            str = @"新浪微博个人中心";
            break;
        case 1:
            str = @"类似qq应用空间效果";
            break;
        case 2:
            str = @"类似QQ空间效果";
            break;
        case 3:
            str = @"知乎日报";
            break;
        case 4:
            str = @"QQ我的资料页";
            break;
        case 5:
            str = @"蚂蚁森林";
            break;
        case 6:
            str = @"连续多个界面隐藏导航栏";
            break;
        case 7:
            str = @"拉钩App首页";
            break;
        case 8:
            str = @"WRNavigationBar 对其不产生任何印象";
            break;
        case 9:
            str = @"测试 IQKeyBoardManager 对其影响";
            break;
            
        default:
            str = @"hehe";
            break;
    }
    cell.textLabel.text = str;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.navigationController.navigationBar.translucent = NO;
//    int result = [NSObject makeCaculators:^(CaculatorMaker *maker) {
//        maker.add(10).sub(1).muilt(3).divide(9);
//    }];
//
//    CaculatorMaker *maker = [[CaculatorMaker alloc] init];
//    maker.add(10).sub(1).muilt(3).divide(9);
//    NSLog(@"%d=============%d",result,maker.result);
    
    Calcultor *cal = [[Calcultor alloc] init];
    BOOL isequal = [[[cal calculator:^int(int num) {
        return num+2;
    }] equal:^BOOL(int num) {
        return num==3;
    }] isEqual] ;
    NSLog(@"是否相等%d",isequal);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter / setter
- (UITableView *)tableView
{
    if (_tableView == nil) {
        CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-0-49);
        _tableView = [[UITableView alloc] initWithFrame:frame
                                                  style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
                _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = [UIColor blueColor];
    }
    return _tableView;
}

//- (UIRectEdge)edgesForExtendedLayout {
//    return UIRectEdgeNone;
//}


@end
