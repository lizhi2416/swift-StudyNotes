//
//  TableViewController.m
//  TablleViewAnimation
//
//  Created by 蒋礼智 on 2018/5/3.
//  Copyright © 2018年 蒋礼智. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation TableViewController

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItemAnimation)];
    UIBarButtonItem *deleteItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(removeItemAnimation)];

    
    self.navigationItem.rightBarButtonItems = @[addItem,deleteItem];
    
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    self.tableView.tableFooterView = [UIView new];
    
    NSArray *hehe = @[@"第1行",@"第2行",@"第3行",@"第4行",@"第5行",@"第6行"];
    [self.dataSource addObjectsFromArray:hehe];
    
}

- (void)addItemAnimation {
    NSArray *haha = @[@"第7行",@"第8行",@"第9行",@"第10行",@"第11行"];
    [self.dataSource addObjectsFromArray:haha];
//    [self.tableView reloadData];
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:6 inSection:0],[NSIndexPath indexPathForRow:7 inSection:0]
                                             ,[NSIndexPath indexPathForRow:8 inSection:0]
                                             ,[NSIndexPath indexPathForRow:9 inSection:0]
                                             ,[NSIndexPath indexPathForRow:10 inSection:0]
                                             
                                             ] withRowAnimation:(UITableViewRowAnimationAutomatic)];
    [self.tableView endUpdates];
    
//    [self.tableView reloadRowsAtIndexPaths:<#(nonnull NSArray<NSIndexPath *> *)#> withRowAnimation:<#(UITableViewRowAnimation)#>];
}

- (void)removeItemAnimation {
//    NSArray *haha = @[@"第7行",@"第8行",@"第9行",@"第10行",@"第11行"];
//    [self.dataSource removeObjectsInArray:haha];
//    [self.tableView reloadData];
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:6 inSection:0],[NSIndexPath indexPathForRow:7 inSection:0]
                                             ,[NSIndexPath indexPathForRow:8 inSection:0]
                                             ,[NSIndexPath indexPathForRow:9 inSection:0]
                                             ,[NSIndexPath indexPathForRow:10 inSection:0]
                                             
                                             ] withRowAnimation:(UITableViewRowAnimationAutomatic)];
    [self.tableView endUpdates];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class) forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [self.dataSource objectAtIndex:indexPath.row];
    return cell;
}




/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
